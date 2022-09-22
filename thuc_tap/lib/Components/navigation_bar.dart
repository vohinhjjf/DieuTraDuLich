import 'package:flutter/material.dart';
import 'package:thuc_tap/Models/bangkeho_model.dart';
import 'package:thuc_tap/Models/danhgia_model.dart';
import 'package:thuc_tap/Models/danhsach_model.dart';
import 'package:thuc_tap/Screen/Interview/locate_screen.dart';
import 'package:thuc_tap/Screen/Interview/questions/DieuTraVien.dart';
import 'package:thuc_tap/Screen/Interview/questions/NguoiKhaiPhieu.dart';
import 'package:thuc_tap/constant.dart';
import 'package:thuc_tap/Database/database.dart';
import '../Models/phieu01_model.dart';
import '../Models/tour_model.dart';
import '../Screen/Interview/questions/TT_household.dart';
import '../Screen/Interview/questions/ThongTinHoGiaDinh.dart';
import '../Screen/Interview/questions/question10.dart';
import '../Screen/Interview/questions/question5.dart';
import '../Screen/Interview/questions/question6_1.dart';
import '../Screen/Interview/questions/question6_2.dart';
import '../Screen/Interview/questions/question7.dart';
import '../Screen/Interview/questions/question8.dart';
import '../Screen/Interview/questions/question9.dart';
import '../Screen/Interview/questions/question_3.dart';
import '../Screen/Interview/questions/question_4.dart';

class NavBar extends StatelessWidget {
  final String stt_ho;
  late String tinhtranghd ='';
  late String tenchuho='';
  late String tinh ='';
  late String huyen ='';
  late String xa ='';
  late String thon ='';
  late String sdt ='';
  late String email ='';
  late String tinhtrangdl ='';
  late String thongtin ='';
  late String so_chuyen_di ='';
  late String so_chuyen_di_tour ='';
  late String so_chuyen_di_tu_sap_xep ='';
  late String danh_gia_chat_luong ='';
  late String tham_khao ='';
  late String quay_lai ='';
  late String ly_do ='';
  late String dieutravien = '';

  NavBar({
    required this.stt_ho,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(top:84),
        child: SingleChildScrollView(
          // Remove padding
          padding: EdgeInsets.zero,
          child: FutureBuilder(
              future: DBProvider.db.getHouseHold(stt_ho),
              builder: (context, AsyncSnapshot<BangKeHoModel> snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data!.status) {
                    case 1: tinhtranghd = 'Đang hoạt động'; break;
                    case 2: tinhtranghd = 'Chuyển khỏi địa bàn'; break;
                    case 3: tinhtranghd = 'Không liên hệ được'; break;
                  }
                  tenchuho = snapshot.data!.name;
                  tinh = snapshot.data!.tinh;
                  huyen = snapshot.data!.huyen;
                  xa = snapshot.data!.xa;
                  thon = snapshot.data!.address;
                  sdt = snapshot.data!.phone;
                  switch (snapshot.data!.status_bk) {
                    case 1: tinhtrangdl = 'Có'; break;
                    case 2: tinhtrangdl = 'Không'; break;
                  }

                  return FutureBuilder(
                    future: DBProvider.db.getInformation(stt_ho),
                    builder: (context, AsyncSnapshot<List<DanhSachModel>> snapshot) {
                      if (snapshot.hasData) {
                        if(snapshot.data!.isNotEmpty) {
                          thongtin = snapshot.data!.length.toString();
                        }
                        return FutureBuilder(
                          future: DBProvider.db.getTour(stt_ho),
                          builder: (context, AsyncSnapshot<List<TourModel>> snapshot) {
                            if (snapshot.hasData) {
                              if(snapshot.data!.isNotEmpty) {
                                so_chuyen_di = snapshot.data!.length.toString();
                              }
                              return FutureBuilder(
                                future: DBProvider.db.getTour_Private(1,stt_ho),
                                builder: (context, AsyncSnapshot<List<TourModel>> snapshot) {
                                  if (snapshot.hasData) {
                                    if(snapshot.data!.isNotEmpty) {
                                      so_chuyen_di_tour = snapshot.data!.length.toString();
                                    }
                                    return FutureBuilder(
                                      future: DBProvider.db.getTour_Private(2,stt_ho),
                                      builder: (context, AsyncSnapshot<List<TourModel>> snapshot) {
                                        if (snapshot.hasData) {
                                          if(snapshot.data!.isNotEmpty) {
                                            so_chuyen_di_tu_sap_xep = snapshot.data!.length.toString();
                                          }
                                          return FutureBuilder(
                                            future: DBProvider.db.getDanhGia(stt_ho),
                                            builder: (context, AsyncSnapshot<List<DanhGiaModel>> snapshot) {
                                              if (snapshot.hasData) {
                                                if(snapshot.data!.isNotEmpty) {
                                                  danh_gia_chat_luong =
                                                      snapshot.data!.length
                                                          .toString();
                                                }
                                                return FutureBuilder(
                                                  future: DBProvider.db.getPhieu01(stt_ho),
                                                  builder: (context, AsyncSnapshot<Phieu01Model> snapshot) {
                                                    if (snapshot.hasData) {
                                                      tham_khao = snapshot.data!.thamkhao;
                                                      switch (snapshot.data!.quaylai) {
                                                        case 1: quay_lai = 'Có'; break;
                                                        case 2: quay_lai = 'Không'; break;
                                                      }
                                                      ly_do = snapshot.data!.dichvuxau;
                                                      dieutravien = snapshot.data!.dieutravien;
                                                      return ListNavigation(context);
                                                    } else if (snapshot.hasError) {
                                                      return ListNavigation(context);
                                                    }
                                                    return const CircularProgressIndicator();
                                                  },
                                                );
                                              } else if (snapshot.hasError) {
                                                return Container();
                                              }
                                              return const CircularProgressIndicator();
                                            },
                                          );
                                        } else if (snapshot.hasError) {
                                          return Container();
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Container();
                                  }
                                  return const CircularProgressIndicator();
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Container();
                            }
                            return const CircularProgressIndicator();
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Container();
                      }
                      return const CircularProgressIndicator();
                    },
                  );
                } else if (snapshot.hasError) {
                  return Container();
                }
                return const CircularProgressIndicator();
              },
            ),//Thông tin hộ
        ),
      )
    );
  }

  Widget ListNavigation (BuildContext context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: mPrimaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('THÔNG TIN CƠ SỞ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: mFontTitle,
                      fontWeight: FontWeight.bold
                  ),
                ),
                IconButton(
                    onPressed: (){
                      Navigator.of(context).setState(() {
                        Navigator.pop(context);
                      });
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white,))
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => StatusHouseHold(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tình trạng hoạt động', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(tinhtranghd, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InformationHouseHold(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tên chủ hộ', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(tenchuho, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InformationHouseHold(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tỉnh/Thành phố trực thuộc', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(tinh, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InformationHouseHold(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Huyện/Quận', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(huyen, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InformationHouseHold(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Xã/phường/thị trấn', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(xa, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InformationHouseHold(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Thôn, ấp (số nhà, đường phố)', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(thon, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InformationHouseHold(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Số điện thoại', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(sdt, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InformationHouseHold(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Email', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(email, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Question3(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('3. Hộ có thành viên đi du lịch không?', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(tinhtrangdl, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>  Question4(stt_ho: stt_ho,)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('4. Số thành viên đi du lịch', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(thongtin, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),//số thành viên
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Question5(stt_ho: stt_ho,)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('5. Số chuyến đi', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(so_chuyen_di, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),//số chuyến đi
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Question6_1(stt_ho: stt_ho,)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('6.1 Các chuyến đi theo tour', style: const TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(so_chuyen_di_tour, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),//số chuyến đi theo tour
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Question6_2(stt_ho: stt_ho,)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('6.2 Các chuyến đi tự sắp xếp', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(so_chuyen_di_tu_sap_xep, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),//số chuyến đi tự sắp xếp
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Question7(stt_ho: stt_ho)
              ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('7. Đánh giá về chất lượng một số dịch vụ', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(danh_gia_chat_luong, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Question8(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('8. Ông(bà) đã tham khảo từ đâu về chuyến du lịch này', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(tham_khao, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Question9(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('9. Ông/Bà có ý định quay trở lại một số địa điểm đã đến không?', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(quay_lai, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Question10(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('10. Lý do khiến Ông/Bà không có ý định quay trở lại?', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(ly_do, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NguoiKhaiPhieuScreen(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Họ và tên người khai phiếu', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text('', style: TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => DieuTraVienScreen(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Họ và tên điều tra viên', style:  TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text(dieutravien, style: const TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LocateScreen(stt_ho: stt_ho)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Hoàn thành phỏng vấn', style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w600),),
                Text('', style: TextStyle(fontSize: mFontSize, color: mTextColor) )
              ],
            ),
          ),
          Divider(height: 20,color: Colors.blue[200]),
        ],
      ),
    );
  }
}