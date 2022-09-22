import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:thuc_tap/Screen/Interview/questions/ThongTinHoGiaDinh.dart';
import '../../../Database/database.dart';
import '../../../constant.dart';
import '../interview_screen.dart';

class StatusHouseHold extends StatefulWidget{
  const StatusHouseHold({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;

  @override
  Body createState() => Body();

}
class Body extends State<StatusHouseHold>{
  List<String>data= ["Đang hoạt động","Chuyển khỏi địa bàn","Không liên hệ được"];
  List<String> userChecked = ["Đang hoạt động"];
  int trangthai = 1;
  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        userChecked.add(dataName);
      });
    } else {
      setState(() {
        userChecked.remove(dataName);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    DBProvider.db.getHouseHold(widget.stt_ho).then((value) => {
      trangthai =value.status
    });
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
            'Tình trạng hoạt động hộ gia đình',
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
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return GFCheckboxListTile(
                        title: Text(data[i],style: const TextStyle(
                          fontSize: mFontSize,fontWeight: FontWeight.w500
                        ),),
                        size: 40,
                        activeBgColor: Colors.white,
                        activeBorderColor: Colors.black,
                        type: GFCheckboxType.values[1],
                        activeIcon: const Icon(
                          Icons.check,
                          size: 26,
                          color: mPrimaryColor,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _onSelected(value, data[i]);
                            for (int j = 0; j < data.length; j++){
                              if(j != i){
                                _onSelected(false, data[j]);
                              }

                            }
                            trangthai = i+1;
                          });
                        },
                        value: userChecked.contains(data[i]),
                        inactiveIcon: null,
                        position: GFPosition.start,
                      );
                    }
                    ),
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () {
                      switch (trangthai){
                        case 1:{
                          DBProvider.db.updateInterview(widget.stt_ho, trangthai,2,2);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => InformationHouseHold(stt_ho: widget.stt_ho)));
                        }; break;
                        case 2:{
                          DBProvider.db.updateInterview(widget.stt_ho, trangthai,9,1);
                          _showMaterialDialog();
                        }; break;
                        case 3:{
                          DBProvider.db.updateInterview(widget.stt_ho, trangthai,9,1);
                          _showMaterialDialog();
                        }; break;
                      };
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
          ),
        )
    );
  }
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Image(
            width: 130,
            height: 130,
            image: AssetImage("assets/images/success.gif"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: const Text(
                  "Quá trình phỏng vấn kết thúc!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        child: const Text('Quay lại',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: 15)),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => InterviewScreen()));
                        }),
                  ])
            ],
          ),
        ));
  }
}