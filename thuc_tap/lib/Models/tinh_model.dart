class TinhModel{
  late String Ma_Tinh;
  late String TenTinh;
  late String MaTinh;
  late String Ma_Vung;

  TinhModel({
    required this.Ma_Tinh,
    required this.TenTinh,
    required this.MaTinh,
    required this.Ma_Vung
  });

  factory TinhModel.fromMap(Map<String, dynamic> json) => TinhModel(
      Ma_Tinh: json['MA_TINH'],
      TenTinh: json['TEN_TINH'],
      Ma_Vung: json['MA_VUNG'],
      MaTinh: json['MATINH'],
  );
  Map<String, dynamic> toMap() {
    return {
      'MA_TINH': Ma_Tinh,
      'TEN_TINH': TenTinh,
      'MATINH': MaTinh,
      'MA_VUNG': Ma_Vung
    };
  }
}