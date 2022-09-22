class ChiPhiModel {
  late int id;
  late String stt_ho;
  late int tour;
  late int id_tour;
  late int la_tongso;
  late int money_one_people ;
  late String khoan_muc;
  late int money_total ;
  late int money_eating ;
  late int money_rent ;
  late int money_go ;
  late int money_visit ;
  late int money_buy ;
  late int money_play ;
  late int money_medical ;
  late int money_other ;
  late int people ;
  late int loai_tour;

  ChiPhiModel({
    required this.id,
    required this.stt_ho,
    required this.id_tour,
    required this.tour,
    required this.la_tongso,
    required this.money_one_people,
    required this.khoan_muc,
    required this.money_total,
    required this.money_eating,
    required this.money_rent,
    required this.money_go,
    required this.money_visit,
    required this.money_buy,
    required this.money_play,
    required this.money_medical,
    required this.money_other,
    required this.people,
    required this.loai_tour
 });

  factory ChiPhiModel.fromMap(Map<String, dynamic> json) => ChiPhiModel(
    id: json['ID'],
    stt_ho: json['STT'],
    id_tour: json['ID_CHUYEN'],
    tour: json['CHUYEN'],
    la_tongso: json['LA_TONGSO'],
    money_one_people: json['SOTIEN_TOUR'],
    khoan_muc: json['KHOAN_MUC'],
    money_total: json['SOTIEN_NGOAI'],
    money_eating: json['AN_UONG'],
    money_rent: json['THUE_PHONG'],
    money_go: json['DI_LAI'],
    money_visit: json['THAM_QUAN'],
    money_buy: json['MUA_SAM'],
    money_play: json['VUI_CHOI'],
    money_medical: json['Y_TE'],
    money_other: json['KHAC'],
    people: json['SO_NGUOI'],
    loai_tour: json['TOUR_TUSAP'],
  );

  Map<String, dynamic> toMap() {
    return {
      'STT': stt_ho,
      'CHUYEN': tour,
      'ID_CHUYEN': id_tour,
      'LA_TONGSO': la_tongso,
      'SOTIEN_TOUR': money_one_people,
      'KHOAN_MUC': khoan_muc,
      'SOTIEN_NGOAI': money_total,
      'AN_UONG' : money_eating,
      "THUE_PHONG":money_rent,
      "DI_LAI":money_go,
      "THAM_QUAN":money_visit,
      "MUA_SAM":money_buy,
      "VUI_CHOI":money_play,
      "Y_TE":money_medical,
      "KHAC":money_other,
      "SO_NGUOI":people,
      "TOUR_TUSAP":loai_tour,
    };
  }
}