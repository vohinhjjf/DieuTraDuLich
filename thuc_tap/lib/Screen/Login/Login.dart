import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Database/customer_api_provider.dart';
import '../../Database/database.dart';
import '../../Models/account_model.dart';
import '../../constant.dart';
import '../DashBoard/Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super (key : key);
  @override
  Body createState() => Body();
}
AppBar homeAppBar(BuildContext context) {

  return AppBar(
    backgroundColor: mPrimaryColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)
        )
    ),
    toolbarHeight: 250,
    leadingWidth: 2,
    title: Container(
      alignment: Alignment.center,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("TỔNG CỤC THỐNG KÊ",
              style: TextStyle(fontSize: mFontTitle, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6,),
            const Text('THU THẬP THÔNG TIN VỀ',
                style: TextStyle(fontSize: mFontListTile)),
            const Text('CHỈ TIÊU CHO DU LỊCH TRONG NƯỚC',
                style: TextStyle(fontSize: mFontListTile)),
            const Text('NĂM 2022',
                style: TextStyle(fontSize: mFontListTile)),
            const SizedBox(height: 10,),
            Expanded(
              flex: 0,
              child: Image.asset('assets/images/logo.png',
                  height: 120,
                  width: 120),
            ),
            //SizedBox(height: 20,),
          ]
      ),
    )
  );
}

class Body extends State {
  final _account_text = TextEditingController();
  final _password_text = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var customerApiProvider  = CustomerApiProvider();
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _account_text,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Vui lòng nhập tài khoản';
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

                          hintText: "Tài khoản đăng nhập",
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: mPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _password_text,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                        obscureText: _showPassword,
                        decoration:  InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: mPrimaryColor, width: 2.0),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: mSecondaryColor, width: 2.0),
                          ),
                          hintText: "Mật khẩu",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: mPrimaryColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: Icon(
                              !_showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: mPrimaryColor,
                            ),
                          ),
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
                      Account account;
                      DBProvider.db.getAccount().then((value) => {
                        if(value == null){
                          customerApiProvider.fetchLogin(
                              _account_text.text, _password_text.text).then((value) => {
                                  if(value == null){
                                      _showErrorDialog()
                                }
                                  else {
                                  account = Account(id: 0, taikhoan: _account_text.text, matkhau: _password_text.text),
                                  DBProvider.db.setAccount(account),
                                  Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => const Home()))
                                  }
                          })
                          //_showNotificationDialog()
                        }
                        else if (_account_text.text == value.taikhoan &&
                          _password_text.text == value.matkhau) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Home()))
                        }else {
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
                    "ĐĂNG NHẬP",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                  "Đăng nhập thất bại!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: mFontTitle),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  child: const Text('OK',
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

  _showNotificationDialog(){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Container(),
          content: Container(
            height: 60,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: customerApiProvider.fetchLogin(
                      _account_text.text, _password_text.text),
                  builder: (context,AsyncSnapshot<String?> snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data == null){
                        _showErrorDialog();
                      }
                      else {
                        Account account = Account(id: 0, taikhoan: _account_text.text, matkhau: _password_text.text);
                        DBProvider.db.setAccount(account);
                        /*Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => Home()));*/
                      }
                      return Container();
                    }
                    else if(snapshot.hasError){
                      return Text('Lỗi ${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  }),
                const SizedBox(width: 15,),
                const Text('Đang đồng bộ dữ liệu!'),

              ],
            ),
          ),
        ));
  }
}