class DanhGiaModel {
  late String stt_ho;
  late String ma_tinh;
  late int co_so;
  late int cong_ty;
  late int nhahang_quanan;
  late int tham_quan;
  late int moi_truong;

  DanhGiaModel({
    required this.stt_ho,
    required this.ma_tinh,
    required this.co_so,
    required this.cong_ty,
    required this.nhahang_quanan,
    required this.tham_quan,
    required this.moi_truong
  });

  factory DanhGiaModel.fromMap(Map<String, dynamic> json) => DanhGiaModel(
      stt_ho: json['STT'],
      ma_tinh: json['MA_TINH'],
      co_so: json['COSO_LUUTRU'],
      cong_ty: json['CTY_LUHANH'],
      nhahang_quanan: json['NHAHANG_QUANAN'],
      tham_quan: json['DIEM_THAMQUAN'],
      moi_truong: json['VS_MOITRUONG']
  );

  Map<String, dynamic> toMap() {
    return {
      "STT": stt_ho,
      "MA_TINH": ma_tinh,
      "COSO_LUUTRU":co_so,
      "CTY_LUHANH":cong_ty,
      "NHAHANG_QUANAN": nhahang_quanan,
      "DIEM_THAMQUAN": tham_quan,
      "VS_MOITRUONG": moi_truong
    };
  }
}