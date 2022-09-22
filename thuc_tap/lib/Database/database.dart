import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thuc_tap/Models/chiphi_model.dart';
import 'package:thuc_tap/Models/huyen_model.dart';
import 'package:thuc_tap/Models/tour_model.dart';
import 'package:thuc_tap/Models/xa_model.dart';
import '../Models/account_model.dart';
import '../Models/chuyen_model.dart';
import '../Models/danhsach_model.dart';
import '../Models/bangkeho_model.dart';
import '../Models/danhgia_model.dart';
import '../Models/phieu01_model.dart';
import '../Models/tinh_model.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDBInterview();
    return _database;
  }

  //Interview
  initDBInterview() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Database.db");
    _database = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE PHIEU01_HO ("
          "STT_HO TEXT PRIMARY KEY,"
          "HOSO INTEGER,"
          "TINH TEXT,"
          "HUYEN TEXT,"
          "XA TEXT,"
          "TENCHUHO TEXT,"
          "DIACHI TEXT,"
          "DIENTHOAI TEXT,"
          "TRANGTHAI INTEGER,"
          "TINHTRANGDTRA INTEGER,"
          "TINHTRANGBK INTEGER,"
          "DIEUTRAVIEN TEXT,"
          "TRANGTHAIDBO INTEGER,"
          "PHIEU INTEGER"
          ")");
      await db.execute("CREATE TABLE PHIEU01_DANHSACH ("
          "STT TEXT,"
          "ID INTEGER,"
          "HUYEN TEXT,"
          "HO_TEN TEXT,"
          "TUOI INTEGER,"
          "GIOI_TINH INTEGER,"
          "NGHE_NGHIEP INTEGER,"
          "TRINH_DO INTEGER,"
          "NGUOI_KP INTEGER"
          ")");
      await db.execute("CREATE TABLE DmTINH ("
          "MA_TINH TEXT PRIMARY KEY,"
          "TEN_TINH TEXT,"
          "MATINH TEXT,"
          "MA_VUNG TEXT"
          ")");
      await db.execute("CREATE TABLE DmHUYEN ("
          "TINH INTEGER,"
          "HUYEN INTEGER PRIMARY KEY,"
          "TENHUYEN TEXT"
          ")");
      await db.execute("CREATE TABLE DmXA ("
          "TINH INTEGER,"
          "HUYEN INTEGER,"
          "XA INTEGER PRIMARY KEY,"
          "TENXA TEXT,"
          "TTNT INTEGER"
          ")");
      await db.execute("CREATE TABLE PHIEU01_TOUR ("
          "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "STT TEXT,"
          "CHUYEN INTEGER,"
          "MA_TINH TEXT,"
          "THANG INTEGER,"
          "DEM_NGAY INTEGER,"
          "SO_NGAY INTEGER,"
          "SO_DEM INTEGER,"
          "LOAI_CS INTEGER,"
          "PHUONG_TIEN INTEGER,"
          "SO_NGUOI INTEGER,"
          "SO_NGUOI6 TEXT,"
          "MUC_DICH INTEGER,"
          "TOUR_TUSAP INTEGER"
          ")");
      await db.execute("CREATE TABLE PHIEU01_CHIPHI ("
          "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "STT TEXT,"
          "CHUYEN INTEGER,"
          "ID_CHUYEN INTEGER,"
          "LA_TONGSO INTEGER,"
          "SOTIEN_TOUR INTEGER,"
          "KHOAN_MUC TEXT,"
          "SOTIEN_NGOAI INTEGER,"
          "AN_UONG INTEGER,"
          "THUE_PHONG INTEGER,"
          "DI_LAI INTEGER,"
          "THAM_QUAN INTEGER,"
          "MUA_SAM INTEGER,"
          "VUI_CHOI INTEGER,"
          "Y_TE INTEGER,"
          "KHAC INTEGER,"
          "SO_NGUOI INTEGER,"
          "TOUR_TUSAP INTEGER"
          ")");
      await db.execute("CREATE TABLE PHIEU01_DANHGIA ("
          "STT TEXT,"
          "MA_TINH TEXT,"
          "COSO_LUUTRU INTEGER,"
          "CTY_LUHANH INTEGER,"
          "NHAHANG_QUANAN INTEGER,"
          "DIEM_THAMQUAN INTEGER,"
          "VS_MOITRUONG INTEGER"
          ")");
      await db.execute("CREATE TABLE PHIEU01 ("
          "STT_HO TEXT PRIMARY KEY,"
          "TENCHUHO TEXT,"
          "DIACHI TEXT,"
          "DIENTHOAI TEXT,"
          "HOSO INTEGER,"
          "TINH TEXT,"
          "HUYEN TEXT,"
          "XA TEXT,"
          "CODULICH INTEGER,"
          "THAMKHAO TEXT,"
          "QUAYLAI INTEGER,"
          "DICHVUXAU TEXT,"
          "DICHVUXAUKHAC TEXT,"
          "DIEUTRAVIEN TEXT,"
          "DIEUTRAVIENDT TEXT,"
          "KINHDO INTEGER,"
          "VIDO INTEGER,"
          "THOIGIANBD TEXT,"
          "THOIGIANKT TEXT"
          ")");
      await db.execute("CREATE TABLE ACCESS_TOKEN ("
          "ID INTEGER PRIMARY KEY,"
          "TOKEN"
          ")");
      await db.execute("CREATE TABLE ACCOUNT ("
          "ID INTEGER PRIMARY KEY,"
          "MANSD TEXT,"
          "MATKHAU TEXT"
          ")");
    });
  }

  //login
  setAccount(Account account) async {
    print(await _database.insert("ACCOUNT", account.toMap()));
  }

  Future<Account?> getAccount() async {
    var res = await _database.rawQuery("SELECT * FROM ACCOUNT WHERE ID=?", [0]);
    Account? account =
        res.isEmpty ? null : res.map((e) => Account.fromMap(e)).first;
    return account;
  }

  updateAccount(String matkhau) async {
    print(await _database.rawUpdate(
        'UPDATE ACCOUNT SET MATKHAU = ? WHERE ID = ?', [matkhau, 0]));
  }

  setToken(String token) async {
    var data = {"ID": 0, "TOKEN": token};
    print(await _database.insert("ACCESS_TOKEN", data));
  }

  Future<String> getToken() async {
    var res = await _database.query("ACCESS_TOKEN", columns: ['TOKEN']);
    var token = res[0]['TOKEN'].toString();
    return token;
  }

  Future<String> checkToken() async {
    var res = await _database.rawQuery("SELECT * FROM ACCESS_TOKEN");
    var token = res[0].toString();
    return token;
  }

  //danh muc
  setTinh(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("DmTINH", data[i]));
    }
  }

  Future<List<TinhModel>> getTinh() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM DmTINH");
    List<TinhModel> listTinh =
        res.isNotEmpty ? res.map((c) => TinhModel.fromMap(c)).toList() : [];
    return listTinh;
  }

  Future<String> queryTinh(String tinh) async {
    final db = await database;
    var res = await db.query("DmTINH",
        columns: ['TEN_TINH'], where: "MA_TINH = ?", whereArgs: [tinh]);
    var Tinh = res[0]['TEN_TINH'].toString();
    return Tinh;
  }

  setHuyen(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("DmHUYEN", data[i]));
    }
  }

  Future<List<HuyenModel>> getHuyen(int tinh) async {
    final db = await database;
    var res = await db.query("DmHUYEN", where: "TINH = ?", whereArgs: [tinh]);
    List<HuyenModel> listhuyen =
        res.isNotEmpty ? res.map((c) => HuyenModel.fromMap(c)).toList() : [];
    return listhuyen;
  }

  setXa(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("DmXA", data[i]));
    }
  }

  Future<List<XaModel>> getXa(int tinh, int huyen) async {
    final db = await database;
    var res = await db.query("DmXA",
        where: "TINH = ? AND HUYEN = ?", whereArgs: [tinh, huyen]);
    List<XaModel> listxa =
        res.isNotEmpty ? res.map((c) => XaModel.fromMap(c)).toList() : [];
    return listxa;
  }

  //bang ke ho
  setInterview(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("PHIEU01_HO", data[i]));
    }
  }
  Future<List<BangKeHoModel>> getInterview(int tinhtrangdt, String name) async {
    final db = await database;
    List<Map<String, Object?>> res;
    if (name == '') {
      res = await db.rawQuery(
          "SELECT * FROM PHIEU01_HO WHERE TINHTRANGDTRA=?", [tinhtrangdt]);
    } else {
      res = await db.rawQuery(
          "SELECT * FROM PHIEU01_HO WHERE TINHTRANGDTRA='$tinhtrangdt' AND TENCHUHO LIKE '$name%'");
    }
    List<BangKeHoModel> list =
        res.isNotEmpty ? res.map((c) => BangKeHoModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<BangKeHoModel>> getHo_Chua_DBO(
      int tinhtrangdt, int trangthaidbo) async {
    final db = await database;
    List<Map<String, Object?>> res = await db.rawQuery(
        "SELECT * FROM PHIEU01_HO WHERE TINHTRANGDTRA=? AND TRANGTHAIDBO = ?",
        [tinhtrangdt, trangthaidbo]);
    List<BangKeHoModel> list =
        res.isNotEmpty ? res.map((c) => BangKeHoModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<BangKeHoModel> getHouseHold(String stt_ho) async {
    final db = await database;
    var res =
        await db.query("PHIEU01_HO", where: "STT_HO = ?", whereArgs: [stt_ho]);
    BangKeHoModel bangKeHoModel =
        res.map((c) => BangKeHoModel.fromMap(c)).first;
    return bangKeHoModel;
  }

  Future<int> getBangke() async {
    final db = await database;
    var res =
        await db.rawQuery("SELECT * FROM PHIEU01_HO");
    List<BangKeHoModel> list =
    res.isNotEmpty ? res.map((c) => BangKeHoModel.fromMap(c)).toList() : [];
    return list.length;
  }

  updateInterview(
      String stt_ho, int trangthai, int tinhtrangdt, int trangthaidb) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01_HO SET TRANGTHAI = ?, TINHTRANGDTRA = ?, TRANGTHAIDBO = ? WHERE STT_HO = ?',
        [trangthai, tinhtrangdt, trangthaidb, stt_ho]));
  }

  updateTTHO(
      String stt_ho, String tenchuho, String diachi, String phone) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01_HO SET TENCHUHO = ?, DIACHI = ?, DIENTHOAI = ? WHERE STT_HO = ?',
        [tenchuho, diachi, phone, stt_ho]));
  }

  updateTTDT(String stt_ho, int tinhtrangdt, int trangthaidb) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01_HO SET TINHTRANGDTRA = ?, TRANGTHAIDBO = ? WHERE STT_HO = ?',
        [tinhtrangdt, trangthaidb, stt_ho]));
  }

  updateTT_DONGBO(String stt_ho) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01_HO SET TRANGTHAIDBO = ? WHERE STT_HO = ?',
        [2, stt_ho]));
  }

  //thông tin thành viên
  Future<List<DanhSachModel>> getInformation(String stt_ho) async {
    List<Map<String, dynamic>> maps = await _database
        .query("PHIEU01_DANHSACH", where: "STT = ?", whereArgs: [stt_ho]);
    return maps.map((map) => DanhSachModel.fromMap(map)).toList();
  }
  setListDanhsach(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("PHIEU01_DANHSACH", data[i]));
    }
  }
  setInformation(DanhSachModel informationModel) async {
    print(await _database.insert("PHIEU01_DANHSACH", informationModel.toMap()));
  }

  deleteInformation(int id, String stt) async {
    final db = await database;
    db.delete("PHIEU01_DANHSACH",
        where: "ID = ? AND STT = ?", whereArgs: [id, stt]);
  }

  updateInformation(DanhSachModel informationModel, int id, String stt) async {
    final db = await database;
    var res = await db.update("PHIEU01_DANHSACH", informationModel.toMap(),
        where: "ID = ? AND STT = ?", whereArgs: [id, stt]);
    return res;
  }

  // Chuyen đi
  setListChuyen(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("PHIEU01_TOUR", data[i]));
    }
  }

  setTour(TourModel tourModel) async {
    print(await _database.insert("PHIEU01_TOUR", tourModel.toMap()));
  }

  Future<List<TourModel>> getTour(String stt_ho) async {
    List<Map<String, dynamic>> maps = await _database
        .query("PHIEU01_TOUR", where: "STT = ?", whereArgs: [stt_ho]);
    return maps.map((map) => TourModel.fromMap(map)).toList();
  }

  Future<List<TourModel>> getTour_Private(int tour, String stt_ho) async {
    List<Map<String, dynamic>> maps = await _database.query("PHIEU01_TOUR",
        where: "STT = ? AND TOUR_TUSAP = ?", whereArgs: [stt_ho, tour]);
    return maps.map((map) => TourModel.fromMap(map)).toList();
  }

  deleteTour(int id) async {
    final db = await database;
    db.delete("PHIEU01_TOUR", where: "ID = ?", whereArgs: [id]);
  }

  updateTour(TourModel tourModel, int id) async {
    final db = await database;
    var res = await db.update("PHIEU01_TOUR", tourModel.toMap(),
        where: "ID = ?", whereArgs: [id]);
    return res;
  }

  //Chi Phi
  setChiPhi(ChiPhiModel chiPhiModel) async {
    print(await _database.insert("PHIEU01_CHIPHI", chiPhiModel.toMap()));
  }
  setListChiPhi(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("PHIEU01_CHIPHI", data[i]));
    }
  }
  Future<List<ChiPhiModel>> getChiPhi(int id_tour) async {
    List<Map<String, dynamic>> maps = await _database
        .query("PHIEU01_CHIPHI", where: "ID_CHUYEN = ?", whereArgs: [id_tour]);
    return maps.map((map) => ChiPhiModel.fromMap(map)).toList();
  }
  Future<int> getChiPhi_chuyen (String stt_ho, int chuyen) async {
    List<Map<String, dynamic>> maps = await _database
        .query("PHIEU01_CHIPHI", where: "STT = ? AND TOUR_TUSAP = ?", whereArgs: [stt_ho,chuyen]);
    return maps.length;
  }

  Future<List<ChiPhiModel>> getAllChiPhi() async {
    List<Map<String, dynamic>> maps =
        await _database.rawQuery("SELECT * FROM PHIEU01_CHIPHI");
    return maps.map((map) => ChiPhiModel.fromMap(map)).toList();
  }

  updateChiPhi(ChiPhiModel chiPhiModel, int id) async {
    final db = await database;
    var res = await db.update("PHIEU01_CHIPHI", chiPhiModel.toMap(),
        where: "ID = ?", whereArgs: [id]);
    return res;
  }

  //Đánh giá
  setDanhGia(DanhGiaModel reviewModel) async {
    print(await _database.insert("PHIEU01_DANHGIA", reviewModel.toMap()));
  }
  setListDanhgia(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("PHIEU01_DANHGIA", data[i]));
    }
  }
  Future<List<DanhGiaModel>> getDanhGia(String STT_HO) async {
    List<Map<String, dynamic>> maps = await _database
        .query("PHIEU01_DANHGIA", where: "STT =?", whereArgs: [STT_HO]);
    return maps.map((map) => DanhGiaModel.fromMap(map)).toList();
  }

  Future<List<DanhGiaModel>> getDanhGia_MATINH(
      String STT_HO, String ma_tinh) async {
    List<Map<String, dynamic>> maps = await _database.query("PHIEU01_DANHGIA",
        where: "STT =? AND MA_TINH = ?", whereArgs: [STT_HO, ma_tinh]);
    return maps.map((map) => DanhGiaModel.fromMap(map)).toList();
  }

  deleteDanhGia(String stt, int ma_tinh) async {
    final db = await database;
    db.delete("PHIEU01_DANHGIA",
        where: "STT =? AND MA_TINH = ?", whereArgs: [stt, ma_tinh]);
  }

  updateDanhGia(DanhGiaModel danhGiaModel) async {
    final db = await database;
    var res = await db.update("PHIEU01_DANHGIA", danhGiaModel.toMap(),
        where: "STT =? AND MA_TINH = ?",
        whereArgs: [danhGiaModel.stt_ho, danhGiaModel.ma_tinh]);
    return res;
  }

  //Tham khảo
  setPhieu01(Phieu01Model Phieu01Model) async {
    print(await _database.insert('PHIEU01', Phieu01Model.toMap()));
  }
  setListPhieu(List data) async {
    for (int i = 0; i < data.length; i++) {
      print(await _database.insert("PHIEU01", data[i]));
    }
  }
  Future<Phieu01Model> getPhieu01(String stt_ho) async {
    List<Map<String, dynamic>> maps = await _database
        .query("PHIEU01", where: "STT_HO = ?", whereArgs: [stt_ho]);
    return maps.map((map) => Phieu01Model.fromMap(map)).first;
  }

  Future<String> getThamKhao(String STT_HO) async {
    final db = await database;
    var res = await db.query("PHIEU01",
        columns: ['THAMKHAO'], where: "STT_HO = ?", whereArgs: [STT_HO]);
    var thamkhao = res[0]['THAMKHAO'].toString();
    return thamkhao;
  }

  updateCoDuLich(int codulich, String stt_ho) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01 SET CODULICH = ? WHERE STT_HO = ?',
        [codulich, stt_ho]));
  }

  updateThamKhao(String thamkhao, String stt_ho) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01 SET THAMKHAO = ? WHERE STT_HO = ?',
        [thamkhao, stt_ho]));
  }

  updateQuayLai(String quaylai, String STT_HO) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01 SET QUAYLAI = ? WHERE STT_HO = ?', [quaylai, STT_HO]));
  }

  updateDichVuXau(String dichvuxau, String lydokhac, String STT_HO) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01 SET DICHVUXAU = ?, DICHVUXAUKHAC = ? WHERE STT_HO = ?',
        [dichvuxau, lydokhac, STT_HO]));
  }

  Future<String> getDichVuXau(String STT_HO) async {
    final db = await database;
    var res = await db.query("PHIEU01",
        columns: ['DICHVUXAU'], where: "STT_HO = ?", whereArgs: [STT_HO]);
    var dichvuxau = res[0]['DICHVUXAU'].toString();
    return dichvuxau;
  }
  Future<bool> getKD_VD (String stt_ho) async {
    var check = false;
    await _database.query("PHIEU01",
        columns: ['KINHDO'], where: "STT_HO = ?", whereArgs: [stt_ho])
        .then((value) => {
          if(value == null){
            check =true
          }
          else {
            check =false
          }
    });
    return check;
  }
  updateDTV(String stt_ho,String tenDTV, String sdt) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01 SET DIEUTRAVIEN = ?, DIEUTRAVIENDT = ? WHERE STT_HO = ?',
        [tenDTV, sdt, stt_ho]));
  }
  updateKD_VD(double kinhdo, double vido, String STT_HO) async{
    print(await _database.rawUpdate(
        'UPDATE PHIEU01 SET KINHDO = ?, VIDO = ? WHERE STT_HO = ?',
        [kinhdo, vido, STT_HO]));
  }
  updateTime(String stt_ho, String thoigiankt) async {
    print(await _database.rawUpdate(
        'UPDATE PHIEU01 SET THOIGIANKT = ? WHERE STT_HO = ?',
        [thoigiankt, stt_ho]));
  }
  //Tiến độ
  Future<int> getLengthInterview(String tinhtrangdt) async {
    final db = await database;
    var res = await db.query("PHIEU01_HO",
        where: "TINHTRANGDTRA = ?", whereArgs: [tinhtrangdt]);
    var tinhtrang = res.length;
    return tinhtrang;
  }

  Future<int> getTrangThai(String trangthai) async {
    final db = await database;
    var res = await db.query("PHIEU01_HO",
        where: "TRANGTHAI = ? AND TINHTRANGDTRA = ?",
        whereArgs: [trangthai, '9']);
    var _trangthai = res.length;
    return _trangthai;
  }

  Future<int> getDongBo(int trangthaidbo) async {
    final db = await database;
    var res = await db.query("PHIEU01_HO",
        where: "TINHTRANGDTRA = ? AND TRANGTHAIDBO = ?",
        whereArgs: [9, trangthaidbo]);
    var _dongbo = res.length;
    return _dongbo;
  }
}
