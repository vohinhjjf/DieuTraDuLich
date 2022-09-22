
class BangKeHoModel {
  late String stt_ho;
  late int hoso;
  late String name;
  late String tinh;
  late String huyen;
  late String xa;
  late String address;
  late String phone;
  late int status;
  late int status_dt;
  late int status_bk;
  late String dtv;
  late int status_db;
  late int phieu;

  BangKeHoModel({
    required this.stt_ho,
    required this.hoso,
    required this.name,
    required this.tinh,
    required this.huyen,
    required this.xa,
    required this.address,
    required this.phone,
    required this.status,
    required this.status_dt,
    required this.status_bk,
    required this.dtv,
    required this.status_db,
    required this.phieu
  });

  factory BangKeHoModel.fromMap(Map<String, dynamic> json) => BangKeHoModel(
      stt_ho: json["STT_HO"],
      hoso: json["HOSO"],
      name: json["TENCHUHO"],
      tinh: json["TINH"],
      huyen: json["HUYEN"],
      xa: json["XA"],
      address: json["DIACHI"],
      status: json["TRANGTHAI"],
      phone: json["DIENTHOAI"],
      status_dt: json["TINHTRANGDTRA"],
      status_bk: json["TINHTRANGBK"],
      dtv: json["DIEUTRAVIEN"],
      status_db: json["TRANGTHAIDBO"],
      phieu: json["PHIEU"]
  );

  /*Map<String, dynamic> toMap() {
    return {
      'HOSO': id_ho,
      'TENCHUHO': name,
      'TINH': tinh,
      'HUYEN': huyen,
      'XA': xa,
      'DIACHI': address,
      'TRANGTHAI': status,
      'DIENTHOAI': phone,
      'TINHTRANGDTRA': status_dt,
      'TINHTRANGBK': status_bk,
      'DIEUTRAVIEN': dtv,
      'TRANGTHAIDBO': status_db,
      'PHIEU': phieu
    };
  }*/
}





