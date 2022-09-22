import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thuc_tap/constant.dart';

import '../../Database/database.dart';
import '../DashBoard/Home.dart';
import '../Login/Login.dart';

class BeginScreen extends StatefulWidget{
  const BeginScreen({Key? key}) : super(key: key);

  @override
  Body createState() => Body();
}
class Body extends State {
  @override
  Widget build(BuildContext context) {
    DBProvider.db.initDBInterview();
    return Material(
      color: mSecondPrimaryColor,
      child: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("TỔNG CỤC THỐNG KÊ",
                style: TextStyle(fontSize: mFontTitle, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6,),
              const Text('THU THẬP THÔNG TIN VỀ',
                  style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.w500)),
              const Text('CHỈ TIÊU CHO DU LỊCH TRONG NƯỚC',
                  style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.w500)),
              const Text('NĂM 2022',
                  style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10,),
              Expanded(
                flex: 0,
                child: Image.asset('assets/images/logo.png',
                    height: 200,
                    width: 200),
              ),
              const SizedBox(height: 10,),
              Load(context)
            ]
        ),
      ),
    );
  }

  Widget Load(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      DBProvider.db.checkToken()
          .then((value) =>
      {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const Home())),
        print('Has token')
      })
          .onError((error, stackTrace) =>
      {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const Login())),
        print('Not has token')
      });
    });
    return const CircularProgressIndicator();
  }
}