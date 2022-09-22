import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/Screen/Interview/questions/question9.dart';
import '../../../Components/navigation_bar.dart';
import '../../../Database/database.dart';
import '../../../constant.dart';
import '../interview_screen.dart';
import '../locate_screen.dart';
import 'NguoiKhaiPhieu.dart';

class Question10 extends StatefulWidget{
  const Question10({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();
}

class Body extends State<Question10>{
  Map<String, bool?> lydo = {
    'Cơ sở lưu trú': false,
    'Công ty lữ hành': false,
    'Nhà hàng, quán ăn': false,
    'Điểm thăm quan': false,
    'Vệ sinh môi trường nơi đến': false,
    'Được mời': false,
    'Lý do khác (ghĩ rõ)': false,
  };
  var other = TextEditingController();
  bool show_other=false;
  bool check = false;
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
                  _showStopDialog(context);
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
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("10. Chất lượng dịch vụ nào đã nêu trong câu 7 "
                        "hoặc lý do khác có tác động lớn nhấn khiến Ông/Bà không có ý định quay trở lại?",
                      style: TextStyle(
                          color: mDividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: mFontSize),
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      children: lydo.keys
                          .map((roomName) => FutureBuilder(
                          future: DBProvider.db.getDichVuXau(widget.stt_ho),
                          builder: (context,AsyncSnapshot<String> snapshot){
                            if(snapshot.hasData){
                              if(snapshot.data!.isEmpty){
                                return GFCheckboxListTile(
                                  title: Text(roomName,style: const TextStyle(
                                      fontSize: mFontSize, color: mDividerColor
                                  ),),
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                  value: lydo[roomName]!,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      lydo[roomName] = value;
                                      print(roomName);
                                      if(roomName == 'Lý do khác (ghĩ rõ)' && lydo['Lý do khác (ghĩ rõ)']==true){
                                        show_other=true;
                                      }
                                      else if(lydo['Lý do khác (ghĩ rõ)']==false){
                                        show_other=false;
                                      }
                                    });
                                  },
                                );
                              } else {
                                var list_lydo = snapshot.data!.split(',');
                                List<int> list_int = [];
                                for (int i = 0; i < list_lydo.length; i++) {
                                  list_int.add(
                                      int.parse(list_lydo[i])-1);
                                }
                                if(check==false){
                                  for(int i=0; i<list_int.length; i++){
                                    lydo[lydo.keys.toList()[list_int[i]]]=true;
                                  }
                                }
                                return GFCheckboxListTile(
                                  title: Text(roomName,style: const TextStyle(
                                      fontSize: mFontSize, color: mDividerColor
                                  ),),
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                  value: lydo[roomName]!,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      check = true;
                                      lydo[roomName] = value;
                                      print(roomName);
                                      if(roomName == 'Lý do khác (ghĩ rõ)' && lydo['Lý do khác (ghĩ rõ)']==true){
                                        show_other=true;
                                      }
                                      else if(lydo['Lý do khác (ghĩ rõ)']==false){
                                        show_other=false;
                                      }
                                    });
                                  },
                                );
                              }
                            }
                            else if (snapshot.hasError) {
                              return GFCheckboxListTile(
                                title: Text(roomName,style: const TextStyle(
                                    fontSize: mFontSize, color: mDividerColor
                                ),),
                                padding: EdgeInsets.zero,
                                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                value: lydo[roomName]!,
                                onChanged: (bool? value) {
                                  setState(() {
                                    lydo[roomName] = value;
                                  });
                                },
                              );
                            }
                            return Container();
                          }))
                          .toList(),
                    ),
                    show_other == true
                        ?Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: other,
                            decoration: const InputDecoration(
                                labelText: "Lý do khác",
                                labelStyle: TextStyle(fontSize: mFontListTile,color: mDividerColor)
                            ),
                            // Only numbers can be entered
                            autofocus: true,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Vui lòng nhập lý do khác';
                              }
                              return null;
                            },
                          ),
                        )
                        :Container(),
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
                            var list = lydo.values.toList();
                            String tham_khao = '';
                            for(int i =1; i <= lydo.length; i++){
                              if(list[i-1]==true){
                                tham_khao = tham_khao + i.toString();
                              }
                            }
                            DBProvider.db.updateDichVuXau(tham_khao, other.text, widget.stt_ho);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => Question9(stt_ho: widget.stt_ho)));
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
                            var list = lydo.values.toList();
                            String ly_do = '';
                            for(int i =1; i <= lydo.length; i++){
                              if(list[i-1]==true){
                                ly_do = '$ly_do,$i';
                              }
                            }
                            print(ly_do.replaceFirst(RegExp(r','), ''));
                            DBProvider.db.updateDichVuXau(ly_do.replaceFirst(RegExp(r','), ''), other.text, widget.stt_ho);
                            ly_do == ''?_showRequestDialog(context):  {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => NguoiKhaiPhieuScreen(stt_ho: widget.stt_ho)))
                            };
                          },
                          icon: const Icon(
                            Icons.navigate_next,
                            color: mPrimaryColor,
                            size: 35,
                          ),
                        ),
                      )
                  ), //next
                ],
              ),
            )
          ],
        ),
      drawer: NavBar(stt_ho: widget.stt_ho,),
    );
  }


  _showStopDialog(BuildContext context){
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
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/interview", (Route<dynamic> route) => false);
                        }),
                  ])
            ],
          ),
        ));
  }

  _showRequestDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) =>AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Image(
            width: 250,
            height: 250,
            image: AssetImage("assets/images/notification.gif"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: const Text(
                  "Chưa có thông tin chất lượng dịch vụ không tốt",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: mFontSize,
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
                        child: const Text('Đồng ý',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: 15)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                  ])
            ],
          ),
        ));
  }
}