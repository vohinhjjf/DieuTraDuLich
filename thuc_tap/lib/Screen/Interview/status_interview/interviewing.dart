import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/Models/bangkeho_model.dart';

import '../../../Database/database.dart';
import '../../../constant.dart';
import '../questions/TT_household.dart';

class InterviewingScreen extends StatefulWidget{
  const InterviewingScreen({Key? key}) : super(key: key);

  @override
  Body createState() => Body();

}
class Body extends State{
  var _text_find = TextEditingController();
  var value = '';
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
                  "/interview", (Route<dynamic> route) => false)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Danh sách đang phỏng vấn',
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _text_find,
                    onChanged: (text){
                      setState(() {
                        value = text;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: mPrimaryColor)),
                      hintText: "Nhập từ khóa tìm kiếm",
                    ),
                  ),
                ),
                _showList(context)
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
  _showList(BuildContext context){
    try {
      return FutureBuilder(
          future: DBProvider.db.getInterview(2,value),
          initialData: <BangKeHoModel>[],
          builder: (BuildContext context, AsyncSnapshot<List<BangKeHoModel>> snapshot){
            print('Data: '+ snapshot.hasData.toString());
            if (snapshot.hasData) {
              if (snapshot.data?.length == 0) {
                return Container();
              }
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text("Loi " + snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }
      );
    } catch (e, s) {
      print("Khong tim thay");
    }
  }
  Widget buildList(AsyncSnapshot<List<BangKeHoModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return interviewInfo(snapshot.data![index]);
      },
    );
  }

  Widget interviewInfo(BangKeHoModel interview) {
    var name = interview.name;
    var adrress = interview.address;
    var status = 'Chưa phỏng vấn';
    switch (interview.status_dt){
      case 1: status = 'Chưa phỏng vấn'; break;
      case 2: status = 'Đang phỏng vấn'; break;
      case 3: status = 'Hoàn thành phỏng vấn'; break;
    }

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child: Text("${interview.hoso.toString()}. ${name}",
              style: TextStyle(fontSize: mFontSize, fontWeight: FontWeight.bold)),
        ),
        subtitle: Transform.translate(
          offset: const Offset(-16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(adrress,
                  style: TextStyle(fontSize: mFontListTile, color: mDividerColor)),
              Text("Phiếu 01/DLTN: $status",
                  style: TextStyle(fontSize: mFontListTile, color: Colors.yellow.shade700))
            ],
          ),
        ),
        shape: Border(
          bottom: BorderSide(
              width: 1,
              color: Colors.grey[350]!,
              style: BorderStyle.solid),
        ),
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => StatusHouseHold(stt_ho: interview.stt_ho)));
        },
      ),
    );
  }
}