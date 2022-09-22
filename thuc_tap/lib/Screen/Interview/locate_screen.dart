import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:thuc_tap/Database/database.dart';
import 'package:thuc_tap/Screen/Interview/questions/DieuTraVien.dart';
import '../../Components/navigation_bar.dart';
import '../../constant.dart';
import 'interview_screen.dart';

class LocateScreen extends StatefulWidget {
  const LocateScreen({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;

  @override
  Body createState() => Body();
}

class Body extends State<LocateScreen> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457
    DBProvider.db.getKD_VD(widget.stt_ho).then((value) => {
      if(value){
        _showNotificationDialog()
      }
      else{
        DBProvider.db.updateKD_VD(position.longitude, position.latitude, widget.stt_ho),
        _showMaterialDialog()
      }
    });
  }

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
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () async {
                    checkGps();
                  },
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: mPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: 70,
                  minWidth: 240,
                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage("assets/icons/GPS.png"),
                        width: 30,
                        height: 30,
                      ),
                      Text(
                        'ĐỊNH VỊ GPS',
                        style: TextStyle(
                            fontSize: mFontListTile,
                            fontWeight: FontWeight.w500,
                            color: mDividerColor),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {
                      _showFinishDialog();
                  },
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: mPrimaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: 70,
                  minWidth: 240,
                  child: Column(
                    children: const [
                      Image(
                        image: AssetImage("assets/icons/finish1.png"),
                        width: 30,
                        height: 30,
                      ),
                      Text(
                        'HOÀN THÀNH PHỎNG VẤN',
                        style: TextStyle(
                            fontSize: mFontListTile,
                            fontWeight: FontWeight.w500,
                            color: mDividerColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 600,
            child: ClipOval(
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
                          builder: (context) => DieuTraVienScreen(stt_ho: widget.stt_ho)));
                    },
                    icon: const Icon(
                      Icons.navigate_before,
                      color: mPrimaryColor,
                      size: 35,
                    ),
                  ),
                )
            ),
          )
        ],
      ),
      drawer: NavBar(
        stt_ho: widget.stt_ho,
      ),
    );
  }

  _showFinishDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Image(
            width: 210,
            height: 210,
            image: AssetImage("assets/images/complete.gif"),
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
                        child: const Text('Hoàn thành',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: 15)),
                        onPressed: () {
                          DBProvider.db.updateTime(widget.stt_ho, DateTime.now().toString());
                          DBProvider.db.updateTTDT(widget.stt_ho, 9,1);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => InterviewScreen()));
                        }),
                  ])
            ],
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
                  "Lấy địa chỉ GPS thành công!",
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
                        child: const Text('Đóng',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: mFontListTile)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ])
            ],
          ),
        ));
  }

  _showNotificationDialog(){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          titlePadding: EdgeInsets.all(20),
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: const Text('Hộ gia đình này đã có GPS!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: mFontListTile, color: mDividerColor,fontWeight: FontWeight.w500),),
          content: Container(
            height: 60,
            alignment: Alignment.center,
            child: FlatButton(
                height: 60,
                minWidth: (MediaQuery.of(context).size.width-80)/2,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black,width: 0.1)
                ),
                child: const Text('Đóng',
                    style: TextStyle(
                        color: mPrimaryColor, fontSize: mFontListTile)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                }
            ),
          ),
        ));
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
