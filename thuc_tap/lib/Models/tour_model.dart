class TourModel {
  late int id;
  late String stt_ho;
  late int chuyen;
  late String ma_tinh;
  late int thang;
  late int so_ngay;
  late int so_dem;
  late int loai_cs;
  late int phuong_tien;
  late int so_nguoi;
  late String stt_nguoi;
  late int ngay_dem;
  late int muc_dich;
  late int loai_tour;
  
  TourModel({
    required this.id,
    required this.stt_ho,
    required this.chuyen,
    required this.ma_tinh,
    required this.so_ngay,
    required this.so_dem,
    required this.so_nguoi,
    required this.stt_nguoi,
    required this.thang,
    required this.ngay_dem,
    required this.loai_cs,
    required this.phuong_tien,
    required this.muc_dich,
    required this.loai_tour,
  });

  factory TourModel.fromMap(Map<String, dynamic> json) => TourModel(
    id: json['ID'],
    stt_ho: json['STT'],
    chuyen: json['CHUYEN'],
    ma_tinh: json['MA_TINH'],
    thang: json['THANG'],
    ngay_dem: json['DEM_NGAY'],
    so_ngay: json['SO_NGAY'],
    so_dem: json['SO_DEM'],
    loai_cs: json['LOAI_CS'],
    phuong_tien: json['PHUONG_TIEN'],
    so_nguoi: json['SO_NGUOI'],
    stt_nguoi: json['SO_NGUOI6'],
    muc_dich: json['MUC_DICH'],
    loai_tour: json['TOUR_TUSAP'],
  );
  
  Map<String, dynamic> toMap() {
    return {
      "STT":stt_ho,
      "CHUYEN": chuyen,
      "MA_TINH":ma_tinh,
      "THANG": thang,
      "DEM_NGAY": ngay_dem,
      "SO_NGAY": so_ngay,
      "SO_DEM": so_dem,
      "LOAI_CS":loai_cs,
      "PHUONG_TIEN": phuong_tien,
      "SO_NGUOI": so_nguoi,
      "SO_NGUOI6": stt_nguoi,
      "MUC_DICH": muc_dich,
      "TOUR_TUSAP": loai_tour,
    };
  }
}