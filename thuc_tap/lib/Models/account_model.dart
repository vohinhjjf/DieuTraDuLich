class Account {
  late int id;
  late String taikhoan;
  late String matkhau;

  Account({
    required this.id,
    required this.taikhoan,
    required this.matkhau
  });

  factory Account.fromMap(Map<String, dynamic> json) => Account(
      id: json['ID'],
      taikhoan: json['MANSD'],
      matkhau: json['MATKHAU']
  );

  Map<String, dynamic> toMap(){
    return {
    'ID': id,
    'MANSD': taikhoan,
    'MATKHAU': matkhau
    };
  }
}