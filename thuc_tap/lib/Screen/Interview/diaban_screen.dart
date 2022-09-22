import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/Screen/Interview/interview_screen.dart';

import '../../constant.dart';

class DiaBanScreen extends StatefulWidget{
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
            'Danh sách địa bàn',
            style: TextStyle(
              fontSize: mFontSize,
              color: mPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: const UnderlineInputBorder(
            borderSide: BorderSide(color: mPrimaryColor)
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            //height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>  InterviewScreen()));
                },
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Mã xã: 765 - Mã địa bàn: 01",
                        style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.bold, color: mPrimaryColor)),
                    Text('Tên địa bàn: Quận Bình Thạnh',
                      style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),),
                    Divider(height: 20,color: Colors.grey),
                  ],
                )
            ),
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