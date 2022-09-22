import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:thuc_tap/Screen/Interview/questions/question_3.dart';

import '../../../Database/database.dart';
import '../../../Models/bangkeho_model.dart';
import '../../../Models/xa_model.dart';
import '../../../constant.dart';
import 'TT_household.dart';

class InformationHouseHold extends StatefulWidget{
  const InformationHouseHold({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();

}
class Body extends State<InformationHouseHold>{
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
  final  _name_text = TextEditingController();
  final  _tinh_text = TextEditingController();
  final  _huyen_text = TextEditingController();
  final  _xa_text = TextEditingController();
  final _diachi_text = TextEditingController();
  final _sdt_text = TextEditingController();
  final _email_text = TextEditingController();
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
              onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => StatusHouseHold(stt_ho: widget.stt_ho)
              )),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Thông tin hộ gia đình',
            style: TextStyle(
              fontSize: mFontSize,
              color: mPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: const UnderlineInputBorder(
            borderSide: BorderSide(color: mPrimaryColor),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: FutureBuilder(
              future: DBProvider.db.getHouseHold(widget.stt_ho),
              builder: (BuildContext context, AsyncSnapshot<BangKeHoModel> snapshot){
                print('Data: ${snapshot.hasData}');
                if (snapshot.hasData) {
                  return ThongTin(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text("Lỗi lấy thông tin hộ theo id ${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              }
          ),
        )
    );
  }

  Widget ThongTin(BangKeHoModel interview){
    DBProvider.db.queryTinh(interview.tinh).then((value) => _tinh_text.text = '${interview.tinh} - ${value}');
    DBProvider.db.getHuyen(int.parse(interview.tinh)).then((value) => _huyen_text.text = '${interview.huyen} - ${value[0].TenHuyen}');
    DBProvider.db.getXa(int.parse(interview.tinh), int.parse(interview.huyen)).then((value) => _xa_text.text = '${interview.xa} - ${value[0].TenXa}');
    _name_text.text = interview.name;
    _diachi_text.text = interview.address;
    _sdt_text.text = interview.phone.toString();
    return Form(
        key: _formKey,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Tên chủ hộ",
                  style: TextStyle(fontSize: mFontListTile,color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _name_text,
                  keyboardType: TextInputType.name,
                  readOnly: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mSecondaryColor,width: 2.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mPrimaryColor,width: 3.0)),
                  ),
                  validator: (value){
                    if(value!.length < 3){
                      return 'Tên không hợp lệ';
                    }
                  },
                ),),
              const SizedBox(height: 10),
              const Text("Tỉnh, thành phố trực thuộc Trung Ương",
                  style: TextStyle(fontSize: mFontListTile,color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _tinh_text,
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: mSecondPrimaryColor,
                    contentPadding: EdgeInsets.only(left: 10),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mSecondaryColor,width: 2.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mPrimaryColor,width: 3.0)),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text("Huyện/Quận (thị xã, thành phố thuộc tỉnh)",
                style: TextStyle(fontSize: mFontListTile,color: Colors.black, fontWeight: FontWeight.bold),),
              const SizedBox(height: 7),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _huyen_text,
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: mSecondPrimaryColor,
                    contentPadding: EdgeInsets.only(left: 10),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mSecondaryColor,width: 2.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mPrimaryColor,width: 3.0)),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text("Xã/phường/thị trấn",
                  style: TextStyle(fontSize: mFontListTile,color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _xa_text,
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: mSecondPrimaryColor,
                    contentPadding: EdgeInsets.only(left: 10),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mSecondaryColor,width: 2.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mPrimaryColor,width: 3.0)),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text("Thôn, ấp (số nhà, đường phố)",
                  style: TextStyle(fontSize: mFontListTile,color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: _diachi_text,
                  readOnly: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mSecondaryColor,width: 2.0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: mPrimaryColor,width: 3.0)),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text("Số điện thoại",
                  style: TextStyle(fontSize: mFontListTile,color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              TextFormField(
                controller: _sdt_text,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: mSecondaryColor,width: 2.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: mPrimaryColor,width: 3.0)),
                ),
                validator: (value){
                  if(value!.length <10 || value.length >11){
                    return 'Số điện thoại không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              const Text("Email",
                  style: TextStyle(fontSize: mFontListTile,color: Colors.black, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              TextFormField(
                controller: _email_text,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: mSecondaryColor,width: 2.0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: mPrimaryColor,width: 3.0)),
                ),
                validator: (value){
                  if(EmailValidator.validate(value!)== false && value.isNotEmpty){
                    return 'Cú pháp email không hợp lệ';
                  };
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    if(_email_text.text.isEmpty){
                      _showNotificationDialog();
                    }
                    else if(_formKey.currentState!.validate()) {
                      DBProvider.db.updateTTHO(widget.stt_ho, _name_text.text,
                          _diachi_text.text.toString(), _sdt_text.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              Question3(stt_ho: widget.stt_ho)));
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
                      "TIẾP TỤC",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ]
        )
    );
  }
  
  _showNotificationDialog(){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          titlePadding: const EdgeInsets.all(20),
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: const Text('Thông báo: Chưa có thông tin Email',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: mFontListTile, color: mDividerColor,fontWeight: FontWeight.w500),),
          content: Container(
            height: 60,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                    height: 60,
                    minWidth: (MediaQuery.of(context).size.width-80)/2,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black,width: 0.1)
                    ),
                    child: const Text('Nhập lại',
                        style: TextStyle(
                            color: mPrimaryColor, fontSize: mFontListTile)),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                ),
                FlatButton(
                    height: 60,
                    minWidth: (MediaQuery.of(context).size.width-80)/2,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black,width: 0.1)
                    ),
                    child: const Text('Đúng',
                        style: TextStyle(
                            color: mPrimaryColor, fontSize: mFontListTile)),
                    onPressed: () {
                      DBProvider.db.updateTTHO(widget.stt_ho, _name_text.text,
                          _diachi_text.text.toString(), _sdt_text.text);
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              Question3(stt_ho: widget.stt_ho)));
                    }
                )
              ],
            ),
          ),
        ));
  }
}