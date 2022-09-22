import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/Screen/Interview/status_interview/complete_interview.dart';
import 'package:thuc_tap/Screen/Interview/status_interview/interviewing.dart';
import 'package:thuc_tap/Screen/Interview/status_interview/not_interviewed.dart';

import '../../constant.dart';

class InterviewScreen extends StatefulWidget{
  @override
  Body createState() => Body();
}
class Body extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: mPrimaryColor,
              size: mFontSize,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Tình trạng phỏng vấn',
          style: TextStyle(
            fontSize: mFontSize,
            color: mPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: UnderlineInputBorder(),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: mPrimaryColor)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const NotInterviewedScreen()));
                  },
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: mPrimaryColor,
                  child: const Text("Danh sách chưa phỏng vấn",
                      style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: mPrimaryColor)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const InterviewingScreen()));
                  },
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: mPrimaryColor,
                  child: const Text("Danh sách đang phỏng vấn",
                      style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: mPrimaryColor)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const CompleteInterviewScreen()));
                  },
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: mPrimaryColor,
                  child: const Text("Danh sách hoàn thành phỏng vấn",
                      style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.bold)),
                ),
              ),
            ]
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: const LinearGradient(colors: [
              Colors.limeAccent,
              Colors.limeAccent,
            ])
        ),
        child: const Text('Mã ĐTV: D981001',
          style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.bold, color: mPrimaryColor),),
      ),
    );
  }

}