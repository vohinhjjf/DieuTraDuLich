import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Database/customer_api_provider.dart';
import '../../Database/database.dart';
import '../../Models/account_model.dart';
import '../../constant.dart';
import 'Login.dart';

class ChangePasswordScreen extends StatefulWidget{
  @override
  Body createState() => Body();
}
class Body extends State{
  final _password_old = TextEditingController();
  final _password_new = TextEditingController();
  final _password_new_replay = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var customerApiProvider  = CustomerApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffdfcfb),
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
            'Đổi mật khẩu',
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
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _password_old,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Vui lòng nhập mật khẩu';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mPrimaryColor, width: 2.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),

                              hintText: "Mật khẩu hiện tại",
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _password_new,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Vui lòng nhập mật khẩu mới';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mPrimaryColor, width: 2.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              hintText: "Mật khẩu mới",
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _password_new_replay,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Vui lòng nhập mật khẩu mới';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mPrimaryColor, width: 2.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                              ),
                              hintText: "Nhập lại mật khẩu mới",
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  alignment: Alignment.center,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          DBProvider.db.getAccount().then((value) => {
                            print(value!.matkhau),
                            if (_password_old.text.compareTo(value.matkhau) == 0 &&
                                _password_new.text.compareTo( _password_new_replay.text) == 0) {
                                customerApiProvider.DoiMatKhau(_password_new.text).then((value) => {
                                  if(value == null){
                                    _showErrorDialog()
                                  }else {
                                    DBProvider.db.updateAccount(_password_new_replay.text),
                                    _showMaterialDialog()
                                  }
                                })
                            }else {
                              print('2'),
                              _showErrorDialog()
                            }
                          });
                        });
                      }
                      else{
                        print('object');
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
                        "XÁC NHẬN",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: mFontSize),
                      ),
                    ),
                  ),
                ),
              ]
          ),
        )
    );
  }
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title:  const Image(
            width: 130,
            height: 130,
            image: AssetImage("assets/images/success.gif"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Bạn đã đổi mật khẩu thành công!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  child: const Text('Đăng nhập',
                      style: TextStyle(
                          color: Colors.white, fontSize: 15)),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Login()));
                  }
              ),
            ],
          ),
        ));
  }

  _showErrorDialog(){
    showDialog(
        context: context,
        builder: (_) =>AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Image(
            width: 150,
            height: 150,
            image: AssetImage("assets/images/warning.gif"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: const Text(
                  "Đổi mật khẩu thất bại!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: mFontTitle),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  child: const Text('Thử lại',
                      style: TextStyle(
                          color: Colors.white, fontSize: 15)),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  }
              ),
            ],
          ),
        ));
  }
}