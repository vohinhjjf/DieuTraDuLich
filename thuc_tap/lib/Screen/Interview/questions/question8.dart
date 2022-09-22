import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/Database/database.dart';
import 'package:thuc_tap/Models/phieu01_model.dart';
import 'package:thuc_tap/Screen/Interview/questions/question7.dart';
import 'package:thuc_tap/Screen/Interview/questions/question9.dart';
import '../../../Components/navigation_bar.dart';
import '../../../constant.dart';

class Question8 extends StatefulWidget{
  const Question8({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();
}

class Body extends State<Question8>{
  bool check = false, click =false;
  Map<String, bool?> thamkhao = {
    'Bạn bè, người thân': false,
    'Sách báo, tạp chí': false,
    'Internet': false,
    'Công ty du lịch': false,
    'Ti vi': false,
    'Được mời': false,
    'Khác': false,
  };
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
                    const Text("8. Ông(Bà) đã tham khảo từ đâu để quyết định các chuyến du lịch này?",
                      style: TextStyle(
                          color: mDividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: mFontSize),
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      children: thamkhao.keys
                          .map((roomName) => FutureBuilder(
                          future: DBProvider.db.getThamKhao(widget.stt_ho),
                          builder: (context,AsyncSnapshot<String> snapshot){
                            if(snapshot.hasData){
                              check = true;
                              if(snapshot.data!.isEmpty){
                                return GFCheckboxListTile(
                                  title: Text(roomName,style: const TextStyle(
                                      fontSize: mFontSize, color: mDividerColor
                                  ),),
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                  value: thamkhao[roomName]!,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      thamkhao[roomName] = value;
                                    });
                                  },
                                );
                              }
                              else {
                                var list_thamkhao = snapshot.data!.split(',');
                                List<int> list_int = [];
                                for (int i = 0; i < list_thamkhao.length; i++) {
                                  list_int.add(
                                      int.parse(list_thamkhao[i])-1);
                                }
                                if(click == false){
                                  for(int i=0; i<list_int.length; i++){
                                    thamkhao[thamkhao.keys.toList()[list_int[i]]]=true;
                                  }
                                }
                                print(thamkhao.values.toList());
                                return GFCheckboxListTile(
                                  title: Text(roomName,style: const TextStyle(
                                      fontSize: mFontSize, color: mDividerColor
                                  ),),
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                  value: thamkhao[roomName]!,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      click = true;
                                      thamkhao[roomName] = value;
                                    });
                                  },
                                );

                              }
                            }
                            else if (snapshot.hasError) {
                              check = false;
                              return GFCheckboxListTile(
                                title: Text(roomName,style: const TextStyle(
                                    fontSize: mFontSize, color: mDividerColor
                                ),),
                                padding: EdgeInsets.zero,
                                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                value: thamkhao[roomName]!,
                                onChanged: (bool? value) {
                                  setState(() {
                                    thamkhao[roomName] = value;
                                  });
                                },
                              );
                            }
                            return Container();
                          }))
                          .toList(),
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
                            var list = thamkhao.values.toList();
                            String tham_khao = '';
                            for(int i =1; i <= thamkhao.length; i++){
                              if(list[i-1]==true){
                                tham_khao = tham_khao + i.toString();
                              }
                            }
                            DBProvider.db.updateThamKhao(tham_khao, widget.stt_ho);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => Question7(stt_ho: widget.stt_ho)));
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
                            var list = thamkhao.values.toList();
                            String tham_khao = '';
                            for(int i =1; i <= thamkhao.length; i++){
                              if(list[i-1]==true){
                                tham_khao = '$tham_khao,$i';
                              }
                            }
                            DBProvider.db.updateThamKhao(tham_khao.replaceFirst(RegExp(r','), ''), widget.stt_ho);
                            (tham_khao.isEmpty) ? _showRequestDialog(context):
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => Question9(stt_ho: widget.stt_ho)));
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
                  "Chưa có thông tin tham khảo",
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