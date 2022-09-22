import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:thuc_tap/Models/bangkeho_model.dart';
import 'package:thuc_tap/Models/danhsach_model.dart';
import 'package:thuc_tap/Models/phieu01_model.dart';
import '../../Database/database.dart';
import '../Models/synsPhieu_model.dart';

class CustomerApiProvider {

  Future<String?> fetchLogin(String taikhoan, String matkhau) async {
    var diges = md5.convert(utf8.encode(matkhau)).toString().toLowerCase();;
    var envelope = 'grant_type=password&username=$taikhoan&password=$diges';
    http.Response response = await http.post (Uri.parse(
        'http://192.168.137.1/dulich/login'),
        body: envelope
    );
    if (response.statusCode == 200) {
      String access_token = json.decode(response.body)['access_token'].toString();
      fetchData(access_token);
      DBProvider.db.setToken(access_token);
      return access_token;
    } else {
      return null;
    }
  }

  Future<bool> fetchData(String access_token) async {
    var st = "Bearer ${access_token.toString()}";
    List<dynamic> listTinh=[];
    await rootBundle.loadString("assets/data/DM_Tinh.json").then((value) => {
        listTinh = json.decode(json.encode(json.decode(value)['Tinh'])),
        DBProvider.db.setTinh(listTinh)
    });
    http.Response response = await http.get(Uri.parse(
        'http://192.168.137.1/dulich/api/bangkeho'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: st
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> listBK = json.decode(json.encode(json.decode(response.body)["Lst_BangKeHo"]));
      List<dynamic> listHuyen = json.decode(json.encode(json.decode(response.body)["Lst_DmHuyen"]));
      List<dynamic> listXa = json.decode(json.encode(json.decode(response.body)["Lst_DmXa"]));
      List<dynamic> listphieu = json.decode(json.encode(json.decode(response.body)["Lst_Phieu"]));
      List<dynamic> listphieu_danhsach = json.decode(json.encode(json.decode(response.body)["Lst_Phieu_Danhsach"]));
      List<dynamic> listphieu_chuyen = json.decode(json.encode(json.decode(response.body)["Lst_Phieu_Chuyen"]));
      List<dynamic> listphieu_chiphi = json.decode(json.encode(json.decode(response.body)["Lst_Phieu_Chiphi"]));
      List<dynamic> listphieu_danhgia = json.decode(json.encode(json.decode(response.body)["Lst_Phieu_Danhgia"]));
      DBProvider.db.setInterview(listBK);
      DBProvider.db.setHuyen(listHuyen);
      DBProvider.db.setXa(listXa);
      DBProvider.db.setListPhieu(listphieu);
      DBProvider.db.setListDanhsach(listphieu_danhsach);
      DBProvider.db.setListChuyen(listphieu_chuyen);
      DBProvider.db.setListChiPhi(listphieu_chiphi);
      DBProvider.db.setListDanhgia(listphieu_danhgia);
      return true;
    } else {
      throw Exception('Fail to load Bang ke ho');
    }
  }
  Future<List<PhieuDieuTra>> List_PhieuDieuTra(List<BangKeHoModel> list_BangKe) async {
    List<PhieuDieuTra> listphieuDieuTra = [];
    late final PhieuDieuTra phieuDieuTra = PhieuDieuTra();
    for(int i=0; i<list_BangKe.length; i++){
      phieuDieuTra.STT_HO = list_BangKe[i].stt_ho;
      phieuDieuTra.TENCHUHO_BKE = list_BangKe[i].name;
      phieuDieuTra.DIACHI_BKE = list_BangKe[i].address;
      phieuDieuTra.TRANGTHAIPV_BKE = list_BangKe[i].status;
      phieuDieuTra.TINHTRANGDTRA_BKE = list_BangKe[i].status_dt;
      await DBProvider.db.getPhieu01(list_BangKe[i].stt_ho).then((value) async =>
      {
        phieuDieuTra.Phieu_01 = value,
        await DBProvider.db.getInformation(list_BangKe[i].stt_ho).then((value) async =>
        {
          phieuDieuTra.Lst_Danhsach = value,
          await DBProvider.db.getTour(list_BangKe[i].stt_ho).then((value) async =>
          {
            phieuDieuTra.Lst_Chuyen = value.toList(),
            await DBProvider.db.getAllChiPhi().then((value) async =>
            {
              phieuDieuTra.Lst_Chiphi = value.toList(),
              await DBProvider.db.getDanhGia(list_BangKe[i].stt_ho).then((value) =>
              {
                phieuDieuTra.Lst_Danhgia = value.toList(),
                listphieuDieuTra.add(phieuDieuTra)
              })
            })
          })
        }),
      }).catchError((error){
        print("Lỗi: $error");
        phieuDieuTra.Phieu_01 = Phieu01Model(
            stt_ho: list_BangKe[i].stt_ho,
            hoso: null as int,
            tenchuho: list_BangKe[i].name,
            diachi: list_BangKe[i].address,
            dienthoai: '',
            tinh: '',
            huyen: '',
            xa: '',
            codulich: null as int,
            thamkhao: '',
            quaylai: null as int,
            dichvuxau: '',
            dichvuxau_khac: '',
            dieutraviendt: '',
            dieutravien: '',
            kinhdo: 107.74123,
            vido: 16.366798,
            thoigianbd: DateTime.now().toString(),
            thoigiankt: DateTime.now().toString());
        phieuDieuTra.Lst_Danhsach = [null as DanhSachModel];
        phieuDieuTra.Lst_Chuyen = [];
        phieuDieuTra.Lst_Chiphi = [];
        phieuDieuTra.Lst_Danhgia = [];
        listphieuDieuTra.add(phieuDieuTra);
      });
    }
    return listphieuDieuTra;
  }

  Future<String> Dongbo() async {
    var token ='', tempt =0;
    List<PhieuDieuTra> listphieuDieuTra = [];
    await DBProvider.db.getHo_Chua_DBO(9, 1).then((value) async => {
      listphieuDieuTra = await List_PhieuDieuTra(value)
    });
    await DBProvider.db.getToken().then((value) => {
        token = value
    });
    for(int i = 0 ; i < listphieuDieuTra.length; i++) {
      var data = listphieuDieuTra[i].toMap();
      print(data);
      http.Response response = await http.post(
        Uri.parse('http://192.168.137.1/dulich/api/phieudieutra'),
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        print("Success!");
        tempt++;
        DBProvider.db.updateTT_DONGBO(listphieuDieuTra[i].STT_HO);
      } else {
        print('Fail!');
      }
    }
    return '$tempt/${listphieuDieuTra.length}';
  }

  Future<String?> DoiMatKhau(String matkhau) async {
    var token ='';
    await DBProvider.db.getToken().then((value) => {
      token = value
    });
    var envelope = {
      "mansd":"D981001",
      "matkhau":matkhau
    };
    http.Response response = await http.put (Uri.parse(
        'http://192.168.137.1/dulich/api/doimatkhau'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
        body: jsonEncode(envelope)
    );
    print(jsonEncode(envelope));
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return null;
    }
  }
}