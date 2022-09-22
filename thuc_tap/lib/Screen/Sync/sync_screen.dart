import 'package:flutter/material.dart';
import 'package:thuc_tap/Database/database.dart';

import '../../Database/customer_api_provider.dart';
import '../../constant.dart';

class SyncScreen extends StatefulWidget{
  @override
  Body createState() => Body();
}
class Body extends State{
  var customerApiProvider  = CustomerApiProvider();
  int temp =0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          'Đồng bộ dữ liệu điều tra',
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
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            FutureBuilder(
                future: DBProvider.db.getDongBo(1),
                builder: (context,AsyncSnapshot<int> snapshot){
                  if(snapshot.hasData){
                    temp = snapshot.data!;
                    return Text('Có ${snapshot.data} hộ gia đình cần đồng bộ',
                      style: const TextStyle(fontSize: mFontListTile, color: mCompleteColor, fontWeight: FontWeight.bold),);
                  }
                  else if(snapshot.hasError){
                    return Text(snapshot.error.toString(),
                        style: const TextStyle(fontSize: mFontListTile, color: mCompleteColor, fontWeight: FontWeight.bold));
                  }
                  return Container();
                }),
            const SizedBox(height: 5,),
            const Text('Gửi tệp dữ liệu: không', style: TextStyle(fontSize: mFontListTile, color: mThirdColor),),
            Container(
              alignment: Alignment.center,
              margin:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 150,
              child: RaisedButton(
                onPressed: (){
                  if(temp != 0 ) {
                    customerApiProvider.Dongbo().then((value) =>
                    {
                      _showMaterialDialog(value)
                    }).onError((error, stackTrace) =>
                        _showErrorDialog(error.toString()));
                  }
                  else{
                    _showNotificationDialog();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const LinearGradient(colors: [
                        mPrimaryColor,
                        Color(0xFF64B5F6),
                        mPrimaryColor,
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "THỰC HIỆN",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(6),
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
  _showMaterialDialog(String value) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          titlePadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Image(
            width: 130,
            height: 130,
            image: AssetImage("assets/images/notification.gif"),
          ),
          content: Container(
            height: 120,
            child: Column(
              children: <Widget>[
                Container(
                  child:  Text(
                    "Đồng bộ thành công $value hộ",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Divider(height: 20,color: Colors.grey),
                FlatButton(
                    child: const Text('Đóng',
                        style: TextStyle(
                            color: mPrimaryColor, fontSize: mFontListTile)),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                ),
              ],
            ),
          ),
        ));
  }

  _showErrorDialog(String error) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Container(
            child: Column(
              children: [
                const Image(
                  width: 250,
                  height: 250,
                  image: AssetImage("assets/images/warning.gif"),
                ),
                const Text(
                  "Thất bại",
                  style: TextStyle(fontSize: mFontSize, color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Lỗi xử lý yêu cầu đồng bộ: $error",
                  textAlign: TextAlign.center,
                  style:
                  const TextStyle(color: Colors.black, fontSize: mFontSize),
                ),
                const SizedBox(
                  height: 10,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: mPrimaryColor)),
                    color: mPrimaryColor,
                    child: const Text('Quay lại',
                        style:
                        TextStyle(color: Colors.white, fontSize: 15)),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                )
              ],
            ),
          ),
        ));
  }

  _showNotificationDialog(){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          titlePadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          contentPadding: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Column(
            children: const [
              Text('Không có hộ cần động bộ!', style: TextStyle(fontSize: mFontListTile, color: mDividerColor),),
              SizedBox(height: 5,),
              Divider(
                  height: 10,
                  color: Colors.grey),
            ],
          ),
          content: Container(
            height: 20,
            child: Container(
              alignment: Alignment.center,
              child: FlatButton(
                  child: const Text('Đóng',
                      style: TextStyle(
                          color: mPrimaryColor, fontSize: subhead)),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
              ),
            ),
          ),
        ));
  }
}