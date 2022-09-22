import 'dart:convert';

DanhSachModel clientFromJson(String str) {
  final jsonData = json.decode(str);
  return DanhSachModel.fromMap(jsonData);
}

String clientToJson(DanhSachModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
class DanhSachModel {
  late String stt;
  late int id;
  late String huyen;
  late String name;
  late int age;
  late int gender;
  late int qualification;
  late int job;
  late int nguoi_kp;

  DanhSachModel({
    required this.id,
    required this.stt,
    required this.huyen,
    required this.name,
    required this.age,
    required this.gender,
    required this.job,
    required this.qualification,
    required this.nguoi_kp
  });

  factory DanhSachModel.fromMap(Map<String, dynamic> json) => DanhSachModel(
    id: json["ID"],
    stt: json["STT"],
    huyen: json["HUYEN"],
    name: json["HO_TEN"],
    age: json["TUOI"],
    gender: json["GIOI_TINH"],
    job: json["NGHE_NGHIEP"],
    qualification: json["TRINH_DO"],
    nguoi_kp: json['NGUOI_KP']
  );

  Map<String, dynamic> toMap() {
    return {
      'STT': stt,
      'ID': id,
      'HUYEN': huyen,
      'HO_TEN': name,
      'TUOI': age,
      'GIOI_TINH': gender,
      'NGHE_NGHIEP': job,
      'TRINH_DO': qualification,
      'NGUOI_KP': nguoi_kp
    };
  }

}