import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/Screen/Interview/diaban_screen.dart';
import 'package:thuc_tap/Screen/Interview/interview_screen.dart';
import 'package:thuc_tap/Screen/Login/DoiMatKhau.dart';

import '../../Database/customer_api_provider.dart';
import '../../constant.dart';
import '../Login/Login.dart';
import '../Progress/progress_screen.dart';
import '../Sync/sync_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super (key : key);

  @override
  Body createState() => Body();
}
AppBar homeAppBar(BuildContext context) {

  return AppBar(
      backgroundColor: mPrimaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)
          )
      ),
      toolbarHeight: 120,
      title: Align(
        alignment: Alignment.center,
        child: Column(
            children: const <Widget>[
              Text('THU THẬP THÔNG TIN VỀ',
                  style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.bold)),
              Text('CHI TIÊU DU LỊCH TRONG NƯỚC',
                  style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.bold)),
              Text('NĂM 2022',
                  style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Text('ĐTV: D981001.Nguyễn Minh Thái',
                  style: TextStyle(fontSize: mFontListTile)),
            ]
        ),
      )

  );
}

class Body extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => DiaBanScreen()));
                    },
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.white,
                          ]),
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: mPrimaryColor, width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Image(
                            width: 90,
                            height: 90,
                            image: AssetImage("assets/images/search.png"),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "PHỎNG VẤN",
                                style: TextStyle(
                                    fontSize: mFontListTile,
                                    color: mPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),
                ), //phỏng vấn
                const SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SyncScreen()));
                    },
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.white,
                          ]),
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: mPrimaryColor, width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Image(
                            width: 90,
                            height: 90,
                            image: AssetImage("assets/images/restart.png"),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "ĐỒNG BỘ DỮ LIỆU",
                                style: TextStyle(
                                    fontSize: mFontListTile,
                                    color: mPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),
                ), //đồng bộ
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ProgressScreen()));
                    },
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.white,
                          ]),
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: mPrimaryColor, width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Image(
                            width: 90,
                            height: 90,
                            image: AssetImage("assets/images/task.png"),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "TIẾN ĐỘ CÔNG \nVIỆC",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: mFontListTile,
                                    color: mPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),
                ), //tiến độ
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                    },
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.white,
                          ]),
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: mPrimaryColor, width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Image(
                            width: 90,
                            height: 90,
                            image: AssetImage("assets/images/password.png"),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "ĐỔI MẬT KHẨU",
                                style: TextStyle(
                                    fontSize: mFontListTile,
                                    color: mPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),
                ), //đổi mk
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Login()));
                    },
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.white,
                          ]),
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: mPrimaryColor, width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Image(
                            width: 90,
                            height: 90,
                            image: AssetImage("assets/images/shutdown.png"),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "ĐĂNG XUẤT",
                                style: TextStyle(
                                    fontSize: mFontListTile,
                                    color: mPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),
                ), //Đăng xuất
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Container()
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}