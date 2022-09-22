import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Database/database.dart';
import '../../constant.dart';

class ProgressScreen extends StatefulWidget{
  @override
  Body createState() => Body();
}
class Body extends State{
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfffdfcfb),
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
            'Tiến độ công việc',
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
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "D981001",
                  style: TextStyle(
                      fontSize: mFontSize, color: mDividerColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
                Row(
                  children:  [
                    const Expanded(
                        flex: 5,
                        child: Text(
                          "Số hộ gia đình được phân công",
                          style: TextStyle(
                              fontSize: mFontSize, color: Colors.purple, fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        flex: 1,
                        child: FutureBuilder(
                            future: DBProvider.db.getBangke(),
                            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                              if (snapshot.hasData) {
                                return Text(snapshot.data!.toString(),
                                    style: const TextStyle(fontSize: mFontSize, color: Colors.purple, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.end);
                              } else if (snapshot.hasError) {
                                return const Text("0",
                                    style: TextStyle(fontSize: mFontSize),
                                    textAlign: TextAlign.end);
                              }
                              return const Center(child: CircularProgressIndicator());
                            }
                        )
                    )
                  ],
                ),
                const SizedBox(
                  height: space_height * 2,
                ),
                Row(
                  children:  [
                    const Expanded(
                      flex: 4,
                      child: Text("Số hộ chưa phỏng vấn",
                          style: TextStyle(
                              fontSize: mFontSize, color: mDividerColor)),
                    ),
                    Expanded(
                        flex: 2,
                        child: Interview(context,'1')
                    )
                  ],
                ),
                const SizedBox(
                  height: space_height * 2,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Text("Số hộ đang phỏng vấn",
                          style: TextStyle(
                              fontSize: mFontSize, color: mDividerColor)),
                    ),
                    Expanded(
                        flex: 2,
                        child: Interview(context,'2'))
                  ],
                ),
                const SizedBox(
                  height: space_height * 2,
                ),
                Row(
                  children: [
                    const Expanded(
                        flex: 4,
                        child: Text("Số hộ đã hoàn thành phỏng vấn",
                            style: TextStyle(
                                fontSize: mFontSize, color: mDividerColor, fontWeight: FontWeight.bold))),
                    Expanded(
                        flex: 1,
                        child: Interview(context,'9')
                    )
                  ],
                ),
                const SizedBox(
                  height: space_height * 2,
                ),Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Text("Số hộ đang hoạt động",
                          style: TextStyle(
                              fontSize: mFontSize, color: mDividerColor)),
                    ),
                    Expanded(
                        flex: 2,
                        child: TrangThai(context, '1'))
                  ],
                ),
                const SizedBox(
                  height: space_height * 2,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Text("Số hộ chuyển khỏi địa bàn",
                          style: TextStyle(
                              fontSize: mFontSize, color: mDividerColor)),
                    ),
                    Expanded(
                        flex: 2,
                        child: TrangThai(context, '2'))
                  ],
                ),
                const SizedBox(
                  height: space_height * 2,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Text("Số hộ không liên hệ được",
                          style: TextStyle(
                              fontSize: mFontSize, color: mDividerColor)),
                    ),
                    Expanded(
                        flex: 2,
                        child: TrangThai(context, '3')
                    )
                  ],
                ),
                const SizedBox(
                  height: space_height * 2,
                ),
                Row(
                  children:  [
                    const Expanded(
                        flex: 4,
                        child: Text("Số hộ đã đồng bộ",
                            style: TextStyle(
                                fontSize: mFontSize, color: Colors.purple, fontWeight: FontWeight.bold))),
                    Expanded(
                        flex: 2,
                        child: FutureBuilder(
                            future: DBProvider.db.getDongBo(2),
                            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                              if (snapshot.hasData) {
                                return Text(snapshot.data!.toString(),
                                    style: const TextStyle(fontSize: mFontSize, color: Colors.purple, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.end);
                              } else if (snapshot.hasError) {
                                return const Text("0",
                                    style: TextStyle(fontSize: mFontSize),
                                    textAlign: TextAlign.end);
                              }
                              return const Center(child: CircularProgressIndicator());
                            }
                        )
                    )
                  ],
                ),
              ]
          ),
        )
    );
  }

  Widget Interview(BuildContext context, String tinhtrangdt){
    return FutureBuilder(
        future: DBProvider.db.getLengthInterview(tinhtrangdt),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
          if (snapshot.hasData) {
            if (snapshot.data! == 0) {
              return const Text("0",
                  style: TextStyle(fontSize: mFontSize),
                  textAlign: TextAlign.end);
            }
            return Text(
              snapshot.data!.toString(),
              style: const TextStyle(fontSize: mFontSize),
              textAlign: TextAlign.end,
            );
          } else if (snapshot.hasError) {
            return const Text("0",
                style: TextStyle(fontSize: mFontSize),
                textAlign: TextAlign.end);
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }

  Widget TrangThai(BuildContext context, String trangthai) {
    return FutureBuilder(
        future: DBProvider.db.getTrangThai(trangthai),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
          if (snapshot.hasData) {
            if (snapshot.data! == 0) {
              return const Text("0",
                  style: TextStyle(fontSize: mFontSize),
                  textAlign: TextAlign.end);
            }
            return Text(
              snapshot.data!.toString(),
              style: const TextStyle(fontSize: mFontSize),
              textAlign: TextAlign.end,
            );
          } else if (snapshot.hasError) {
            return const Text("0",
                style: TextStyle(fontSize: mFontSize),
                textAlign: TextAlign.end);
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }
}