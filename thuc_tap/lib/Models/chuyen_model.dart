class ChuyenModel{
  late String stt_ho;
  late int chuyen;

  ChuyenModel({
    required this.stt_ho,
    required this.chuyen
  });
  factory ChuyenModel.fromMap(Map<String, dynamic> json) => ChuyenModel(
      stt_ho: json['STT_HO'],
    chuyen: json['CHUYEN']
  );

  Map<String, dynamic> toMap() {
    return {

      "STT_HO":stt_ho,
      "CHUYEN": chuyen
    };
  }
}