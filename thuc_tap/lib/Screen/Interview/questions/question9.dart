import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:thuc_tap/Database/database.dart';
import 'package:thuc_tap/Screen/Interview/questions/question8.dart';
import 'package:thuc_tap/Screen/Interview/questions/question10.dart';
import '../../../Components/navigation_bar.dart';
import '../../../constant.dart';
import '../interview_screen.dart';

class Question9 extends StatefulWidget{
  const Question9({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();
}

class Body extends State<Question9>{
  bool? ischeck = true;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    DBProvider.db.getPhieu01(widget.stt_ho).then((value) => {
      if(value.quaylai == 1){
        ischeck = true
      }
      else {
        ischeck = false
      },
      print(ischeck)
    });
    print("Checck 1: $ischeck");
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
                onPressed: (){},
                text: "STOP",
                color: Colors.white,
                borderShape: const RoundedRectangleBorder(
                    side:  BorderSide(color: Colors.red,width: 2.0),
                    borderRadius:  BorderRadius.all( Radius.circular(4))),
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
                    const Text("9. Ông/Bà có ý định quay trở lại một trong các địa điểm đã đến trong các chuyến đi này không?",
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
                            setState(() => {ischeck=selected!});
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
                            setState(() => {ischeck=!selected!,print(ischeck)});
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
            Container(
              height: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                      child: Container(
                        padding: const EdgeInsets.only(right: 4),
                        decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(
                                side: BorderSide(color: mDividerColor, width: 2)
                            )
                        ),
                        child: IconButton(
                          onPressed: () {
                            var check ='1';
                            if(ischeck!){
                              check = '1';
                            }else {
                              check = '2';
                            }
                            DBProvider.db.updateQuayLai(check, widget.stt_ho);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => Question8(stt_ho: widget.stt_ho)));
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
                            color: Colors.white,
                            shape: CircleBorder(
                                side: BorderSide(color: mDividerColor, width: 2)
                            )
                        ),
                        child: IconButton(
                          onPressed: () {
                            print("Checck: $ischeck");
                            var check ='1';
                            ischeck==false?
                            {
                            check = '2',
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => Question10(stt_ho: widget.stt_ho)))
                            } :
                            {
                              check = '1',
                              _showMaterialDialog()
                            };
                            DBProvider.db.updateQuayLai(check, widget.stt_ho);
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
        drawer: NavBar(stt_ho: widget.stt_ho,),
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
}