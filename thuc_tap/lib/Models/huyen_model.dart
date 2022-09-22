class HuyenModel{
  late int Tinh;
  late int Huyen;
  late String TenHuyen;

  HuyenModel({
    required this.Tinh,
    required this.Huyen,
    required this.TenHuyen,
  });

  factory HuyenModel.fromMap(Map<String, dynamic> json) => HuyenModel(
      Tinh: json['TINH'],
      Huyen: json['HUYEN'],
      TenHuyen: json['TENHUYEN']
  );
  Map<String, dynamic> toMap() {
    return {
      'TINH': Tinh,
      'HUYEN': Huyen,
      'TENHUYEN': TenHuyen
    };
  }
}