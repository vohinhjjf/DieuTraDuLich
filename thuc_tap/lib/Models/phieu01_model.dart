class Phieu01Model{
  late String stt_ho;
  late int hoso;
  late String tenchuho;
  late String dienthoai;
  late String tinh;
  late String huyen;
  late String xa;
  late String diachi;
  late int codulich;
  late String thamkhao;
  late int quaylai;
  late String dichvuxau;
  late String dichvuxau_khac;
  late String dieutravien;
  late String dieutraviendt;
  late double kinhdo;
  late double vido;
  late String thoigianbd;
  late String thoigiankt;

  Phieu01Model({
    required this.stt_ho,
    required this.tenchuho,
    required this.diachi,
    required this.dienthoai,
    required this.hoso,
    required this.tinh,
    required this.huyen,
    required this.xa,
    required this.codulich,
    required this.thamkhao,
    required this.quaylai,
    required this.dichvuxau,
    required this.dichvuxau_khac,
    required this.dieutravien,
    required this.dieutraviendt,
    required this.kinhdo,
    required this.vido,
    required this.thoigianbd,
    required this.thoigiankt,
  });

  factory Phieu01Model.fromMap(Map<String, dynamic> json) => Phieu01Model(
      stt_ho: json['STT_HO'],
      tenchuho: json['TENCHUHO'],
      diachi: json['DIACHI'],
      dienthoai: json['DIENTHOAI'],
      hoso: json['HOSO'],
      tinh: json['TINH'],
      huyen: json['HUYEN'],
      xa: json['XA'],
      codulich: json['CODULICH'],
      thamkhao: json['THAMKHAO'],
      quaylai: json['QUAYLAI'],
      dichvuxau: json['DICHVUXAU'],
      dichvuxau_khac: json['DICHVUXAUKHAC'],
      dieutravien: json['DIEUTRAVIEN'],
      dieutraviendt: json['DIEUTRAVIENDT'],
      kinhdo: json['KINHDO'],
      vido: json['VIDO'],
      thoigianbd: json['THOIGIANBD'],
      thoigiankt: json['THOIGIANKT'],
  );

  Map<String, dynamic> toMap() {
    return {
      'STT_HO': stt_ho,
      'TENCHUHO': tenchuho,
      'DIACHI': diachi,
      'DIENTHOAI': dienthoai,
      'HOSO': hoso,
      'TINH': tinh,
      'HUYEN': huyen,
      'XA': xa,
      'CODULICH': codulich,
      'THAMKHAO': thamkhao,
      'QUAYLAI': quaylai,
      'DICHVUXAU': dichvuxau,
      'DICHVUXAUKHAC': dichvuxau_khac,
      'DIEUTRAVIEN': dieutravien,
      'DIEUTRAVIENDT': dieutraviendt,
      'KINHDO': kinhdo,
      'VIDO': vido,
      'THOIGIANBD': thoigianbd,
      'THOIGIANKT': thoigiankt,
    };
  }
}
