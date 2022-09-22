import 'dart:convert';

import 'package:thuc_tap/Models/chiphi_model.dart';
import 'package:thuc_tap/Models/danhgia_model.dart';
import 'package:thuc_tap/Models/danhsach_model.dart';
import 'package:thuc_tap/Models/phieu01_model.dart';
import 'package:thuc_tap/Models/tour_model.dart';

class PhieuDieuTra
{
  late String STT_HO ;
  late String TENCHUHO_BKE ;
  late String DIACHI_BKE ;
  late int TRANGTHAIPV_BKE ;
  late int TINHTRANGDTRA_BKE;
  late Phieu01Model Phieu_01 ;
  late List<DanhSachModel> Lst_Danhsach ;
  late List<TourModel> Lst_Chuyen ;
  late List<ChiPhiModel> Lst_Chiphi ;
  late List<DanhGiaModel> Lst_Danhgia ;


  String toMap() {
    return jsonEncode({
      "STT_HO_BKE": STT_HO,
      "TENCHUHO_BKE": TENCHUHO_BKE,
      "DIACHI_BKE":DIACHI_BKE,
      "TRANGTHAIPV_BKE":TRANGTHAIPV_BKE,
      "TINHTRANGDTRA" : TINHTRANGDTRA_BKE,
      "Phieu_01": Phieu_01.toMap(),
      "Lst_Danhsach": Lst_Danhsach.map((e) => e.toMap()).toList(),
      "Lst_Chuyen": Lst_Chuyen.map((e) => e.toMap()).toList(),
      "Lst_Chiphi": Lst_Chiphi.map((e) => e.toMap()).toList(),
      "Lst_Danhgia": Lst_Danhgia.map((e) => e.toMap()).toList()
    });
  }
}