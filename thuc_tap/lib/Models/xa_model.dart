class XaModel{
  late int Tinh;
  late int Huyen;
  late int Xa;
  late String TenXa;

  XaModel({
    required this.Tinh,
    required this.Huyen,
    required this.Xa,
    required this.TenXa,
  });

  factory XaModel.fromMap(Map<String, dynamic> json) => XaModel(
      Tinh: json['TINH'],
      Huyen: json['HUYEN'],
      Xa: json['XA'],
      TenXa: json['TENXA']
  );
}