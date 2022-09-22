import 'dart:ffi';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:thuc_tap/Database/database.dart';
import 'package:thuc_tap/Models/bangkeho_model.dart';
import 'package:thuc_tap/Screen/Interview/questions/question_4.dart';
import '../../../Components/navigation_bar.dart';
import '../../../Models/phieu01_model.dart';
import '../../../constant.dart';
import '../interview_screen.dart';
import 'ThongTinHoGiaDinh.dart';

class Question3 extends StatefulWidget{
  const Question3({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();
}

class Body extends State<Question3>{
  bool? ischeck = true;
  bool check_data = false;
  var tenchuho ="";
  var diachi ="";
  var dienthoai ="";
  int? hoso, tinh, huyen, xa;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBProvider.db.getPhieu01(widget.stt_ho).then((value) => {
      if(value.codulich == 1){
        ischeck = true
      }
      else {
        ischeck = false
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: mPrimaryColor),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'PHIẾU 2/DLTN',
            style: TextStyle(
              fontSize: mFontSize,
              color: mPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 7),
              child: GFButton(
                onPressed: (){
                  _showStopDialog();
                },
                text: "STOP",
                color: Colors.white,
                borderShape: const RoundedRectangleBorder(
                    side:BorderSide(color: Colors.red,width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                textStyle: const TextStyle(color: Colors.red,fontSize: mFontSize,fontWeight: FontWeight.w500),
              ),
            )
          ],
          shape: const UnderlineInputBorder(
            borderSide: BorderSide(color: mPrimaryColor),
          ),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 25, 10, 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("3. Trong năm 2021, hộ Ông/Bà có các thành viên đi du lịch không?",
                      style: TextStyle(
                          color: mDividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: mFontSize),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        RoundCheckBox(
                          isChecked: ischeck,
                          onTap: (selected) {
                            setState(() => {
                              ischeck=selected!,
                            });
                          },
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          ),
                          checkedColor: Colors.white,
                          checkedWidget: const Icon(Icons.check, color: mPrimaryColor),
                          uncheckedWidget: null,
                          animationDuration: const Duration(
                            seconds: 1,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        const Text("Có",
                          style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        RoundCheckBox(
                          isChecked: !ischeck!,
                          onTap: (selected) {
                            setState(() => {ischeck=!selected!});
                          },
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          ),
                          checkedColor: Colors.white,
                          checkedWidget: const Icon(Icons.check, color: mPrimaryColor),
                          uncheckedWidget: null,
                          animationDuration: const Duration(
                            seconds: 1,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        const Text("Không",
                          style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    //SizedBox(height: 100,),
                  ]
              ),
            ),
            //Lay thong tin ho
            FutureBuilder(
              future: DBProvider.db.getHouseHold(widget.stt_ho),
              builder: (context, AsyncSnapshot<BangKeHoModel> snapshot){
                if(snapshot.hasData){
                  tenchuho = snapshot.data!.name;
                  diachi = snapshot.data!.address;
                  dienthoai = snapshot.data!.phone;
                  hoso = snapshot.data!.hoso;
                  tinh = int.parse(snapshot.data!.tinh);
                  huyen = int.parse(snapshot.data!.huyen);
                  xa = int.parse(snapshot.data!.xa);
                  return Container();
                }else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Container();
              },
            ),
            FutureBuilder(
              future: DBProvider.db.getPhieu01(widget.stt_ho),
              builder: (context, AsyncSnapshot<Phieu01Model> snapshot){
                if(snapshot.hasData){
                  check_data = true;
                  return Container();
                }else {
                  check_data = false;
                  return Container();
                }
              },
            ),
            Container(
              height: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    //clipBehavior: Clip.hardEdge,
                      child: Container(
                        padding: const EdgeInsets.only(right: 4),
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(
                                side: BorderSide(color: mDividerColor, width: 2)
                            )
                        ),
                        child: IconButton(
                          onPressed: () {
                            var codulich =  ischeck==true ? 1 : 2;
                            var phieu01Model = Phieu01Model(
                                stt_ho: widget.stt_ho,
                                hoso: hoso!,
                                tenchuho: tenchuho,
                                diachi: diachi,
                                dienthoai: dienthoai,
                                tinh: tinh!.toString(),
                                huyen: huyen!.toString(),
                                xa: xa!.toString(),
                                codulich: codulich,
                                thamkhao: '',
                                quaylai: null as int,
                                dichvuxau: '',
                                dichvuxau_khac: '',
                                dieutraviendt: '',
                                dieutravien: '',
                                kinhdo: 107.74123,
                                vido: 16.366798,
                                thoigianbd: DateTime.now().toString(),
                                thoigiankt: DateTime.now().toString());
                            check_data == false ? DBProvider.db.setPhieu01(phieu01Model) : DBProvider.db.updateCoDuLich(codulich, widget.stt_ho);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => InformationHouseHold(stt_ho: widget.stt_ho)));
                          },
                          icon: const Icon(
                            Icons.navigate_before,
                            color: mPrimaryColor,
                            size: 35,
                          ),
                        ),
                      )),  //back
                  ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(
                                side: BorderSide(color: mDividerColor, width: 2)
                            )
                        ),
                        child: IconButton(
                          onPressed: () {
                            var codulich =  ischeck==true ? 1 : 2;
                            var phieu01Model = Phieu01Model(
                                stt_ho: widget.stt_ho,
                                hoso: hoso!,
                                tenchuho: tenchuho,
                                diachi: diachi,
                                dienthoai: dienthoai,
                                tinh: tinh!.toString(),
                                huyen: huyen!.toString(),
                                xa: xa!.toString(),
                                codulich: codulich,
                                thamkhao: '',
                                quaylai: null as int,
                                dichvuxau: '',
                                dichvuxau_khac: '',
                                dieutraviendt: "",
                                dieutravien: "",
                                kinhdo: null as double,
                                vido: null as double,
                                thoigianbd: DateTime.now().toString(),
                                thoigiankt: '');
                            check_data == false ? DBProvider.db.setPhieu01(phieu01Model) : DBProvider.db.updateCoDuLich(codulich, widget.stt_ho);
                            ischeck==false?
                            {
                              _showMaterialDialog(),
                            } :
                            {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) =>  Question4(stt_ho: widget.stt_ho,)))
                            };
                          },
                          icon: const Icon(
                            Icons.navigate_next,
                            color: mPrimaryColor,
                            size: 35,
                          ),
                        ),
                      )), //next
                ],
              ),
            )
          ],
        ),
        drawer: NavBar(
          stt_ho: widget.stt_ho,
        ),
    );
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Image(
            width: 130,
            height: 130,
            image: AssetImage("assets/images/success.gif"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: const Text(
                  "Quá trình phỏng vấn kết thúc!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        child: const Text('Quay lại',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: 15)),
                        onPressed: () {
                          DBProvider.db.updateTTDT(widget.stt_ho, 9,1);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => InterviewScreen()));
                        }),
                  ])
            ],
          ),
        ));
  }

  _showStopDialog(){
    showDialog(
        context: context,
        builder: (_) =>AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            title: const Image(
              width: 250,
              height: 250,
              image: AssetImage("assets/images/warning.gif"),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: const Text(
                    "Tạm dừng phỏng vấn?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                          child: const Text('Hủy bỏ',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 15)),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          }),
                      FlatButton(
                          child: const Text('Đồng ý',
                              style: TextStyle(
                                  color: mPrimaryColor, fontSize: 15)),
                          onPressed: () {
                            setState((){
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/interview", (Route<dynamic> route) => false);
                            });
                          }),
                    ])
              ],
            ),
        ));
  }
}
