import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:thuc_tap/Database/database.dart';
import 'package:thuc_tap/Models/bangkeho_model.dart';
import 'package:thuc_tap/Screen/Interview/questions/DieuTraVien.dart';
import 'package:thuc_tap/Screen/Interview/questions/question10.dart';
import '../../../Components/navigation_bar.dart';
import '../../../constant.dart';

class NguoiKhaiPhieuScreen extends StatefulWidget {
  const NguoiKhaiPhieuScreen({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;

  @override
  Body createState() => Body();
}

class Body extends State<NguoiKhaiPhieuScreen> {
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();

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
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: GFButton(
              onPressed: () {
                _showStopDialog(context);
              },
              text: "STOP",
              color: Colors.white,
              borderShape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              textStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: mFontSize,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
        shape: const UnderlineInputBorder(
          borderSide: BorderSide(color: mPrimaryColor),
        ),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: DBProvider.db.getHouseHold(widget.stt_ho),
                      builder: (context, AsyncSnapshot<BangKeHoModel> snapshot) {
                        if(snapshot.hasData){
                          _name.text = snapshot.data!.name;
                          _phone.text = snapshot.data!.phone;
                          return Container();
                        }
                        else if(snapshot.hasError){
                          return Text('Loi ${snapshot.error}');
                        }
                        return Container();
                      }
                  ),
                  const Text("- Họ và tên người khai phiếu",
                    style: TextStyle(
                        color: mDividerColor,
                        fontWeight: FontWeight.w500,
                        fontSize: mFontSize),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _name,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Vui lòng nhập tên người khai phiếu';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                      FilteringTextInputFormatter.deny(RegExp('[abFeG]')),
                    ],
                    autofocus: true,
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
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("- Số điện thoại người khai phiếu",
                    style: TextStyle(
                        color: mDividerColor,
                        fontWeight: FontWeight.w500,
                        fontSize: mFontSize),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _phone,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Vui lòng nhập số điện thoại';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autofocus: true,
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
                    ),
                  ),
                ],
              ),
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
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => Question10(stt_ho: widget.stt_ho)));
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
                          if(_formKey.currentState!.validate()) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DieuTraVienScreen(
                                            stt_ho: widget.stt_ho)));
                          }
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
      drawer: NavBar(
        stt_ho: widget.stt_ho,
      ),
    );
  }

  _showStopDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
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
                            style:
                            TextStyle(color: Colors.red, fontSize: 15)),
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
                              "/interview",
                                  (Route<dynamic> route) => false);
                        }),
                  ])
            ],
          ),
        ));
  }
}