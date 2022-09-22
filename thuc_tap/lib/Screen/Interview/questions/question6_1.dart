import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:thuc_tap/Database/database.dart';
import 'package:thuc_tap/Models/chiphi_model.dart';
import 'package:thuc_tap/Screen/Interview/questions/question5.dart';
import 'package:thuc_tap/Screen/Interview/questions/question6_2.dart';
import 'package:thuc_tap/Screen/Interview/questions/question7.dart';
import '../../../Components/navigation_bar.dart';
import '../../../Models/tour_model.dart';
import '../../../constant.dart';

class Question6_1 extends StatefulWidget{
  const Question6_1({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();
}

class Body extends State<Question6_1>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final radius = 35.0;
  int temp_tour=0;
  double width =0;
  var noiden ='';
  Map<String, bool?> khoanmuc = {
    'Chi phí vận chuyển': false,
    'Thuê phòng': false,
    'Ăn uống': false,
    'Thăm quan': false,
    'Dịch vụ khác': false
  };

  @override
  void initState() {
    super.initState();
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
              padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 7),
              child: GFButton(
                onPressed: (){
                  _showStopDialog(context);
                },
                text: "STOP",
                color: Colors.white,
                borderShape: const RoundedRectangleBorder(
                    side:BorderSide(color: Colors.red,width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                textStyle: const TextStyle(color: Colors.red,fontSize: mFontSize,fontWeight: FontWeight.w500),
              ),
            )
          ],
          shape: const UnderlineInputBorder(
            borderSide: BorderSide(color: mPrimaryColor),
          ),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("6. Chi tiết về tiêu chí các chuyến đi",
                      style: TextStyle(
                          color: mDividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: mFontSize),
                    ),
                    const Text(" 6.1. Các chuyến đi theo tour",
                      style: TextStyle(
                          color: mDividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: mFontSize),
                    ),
                    FutureBuilder(
                      future: DBProvider.db.getTour_Private(1,widget.stt_ho),
                      initialData: const <TourModel>[],
                      builder: (context, AsyncSnapshot<List<TourModel>> snapshot) {
                        if (snapshot.hasData) {
                          if(snapshot.data!.isEmpty){
                            return Container();
                          }
                          temp_tour = snapshot.data!.length;
                          List<String> list= [];
                          List<String> listTemp = [];
                          for(int i=0; i<snapshot.data!.length;i++){
                            list.add(snapshot.data![i].chuyen.toString());
                          }
                          for(int i=0; i<list.length;i++){
                            if (!listTemp.contains(list[i])) {
                              listTemp.add(list[i]);
                            }
                          }
                          return ListTour(snapshot,listTemp.length,listTemp);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Center(child: Container());
                      },
                    ),
                    //SizedBox(height: 100,),
                  ]
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
                                  builder: (context) =>  Question5(stt_ho: widget.stt_ho,)));
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
                            DBProvider.db.getChiPhi_chuyen(widget.stt_ho, 1).then((value) => {
                              print('$value - $temp_tour'),
                              (value < temp_tour) ? _showRequestDialog(context)
                              :DBProvider.db.getTour_Private(2,widget.stt_ho).then((value) => {
                                if(value.isNotEmpty){
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Question6_2(stt_ho: widget.stt_ho,)))
                                }
                                else {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Question7(stt_ho: widget.stt_ho,)))
                                }
                              }),
                            });
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
        drawer: NavBar(stt_ho: widget.stt_ho,),
    );
  }

  Widget ListTour(AsyncSnapshot<List<TourModel>> snapshot,int tour,List<String> list){
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: tour,
      itemBuilder: (context, index) {
        return buildTour(snapshot,index,list);
      },
    );
  }

  Widget buildTour(AsyncSnapshot<List<TourModel>> snapshot,int index,List<String> list){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              height: 2 * radius+10,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 3),
                    child: const Image(
                      width: 100,
                      height: 100,
                      image: AssetImage("assets/images/tourism.gif"),
                    ),
                  ),
                  Positioned(
                    top: 12.0,
                    left: radius*2+15,
                    right: 10.0,
                    bottom: 12.0,
                    child: RotatedBox(
                      quarterTurns: 4,
                      child: Arc(
                        arcType: ArcType.CONVEY,
                        edge: Edge.LEFT,
                        height: 11.0,
                        child: Container(
                          decoration:  const BoxDecoration(
                            color: mSecondaryColor,
                            borderRadius:  BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            child: Text(
                              "Chuyến đi ${list[index]}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: mFontTitle,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 12),
                    child: ClipOval(
                        child: Container(
                          height: 2*radius+12,
                          width: 2*radius+12,
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(
                                  side: BorderSide(color: mSecondaryColor, width: 5)
                              )
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildList(snapshot, list[index])
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<TourModel>> snapshot, String index1) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        if (snapshot.data![index].chuyen.toString() == index1) {
          DBProvider.db.queryTinh(snapshot.data![index].ma_tinh).then((value) => {
            noiden = value
          });
          return buildData(snapshot.data![index], index);
        }
        return Container();
      },
    );
  }

  Widget buildData(TourModel tourModel, int index) {
    return FutureBuilder(
      future: DBProvider.db.getChiPhi(tourModel.id),
      initialData: const <ChiPhiModel>[],
      builder: (context, AsyncSnapshot<List<ChiPhiModel>> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.isEmpty){
            return Location(tourModel,tourModel.id.toString());
          }
          else {
            if(snapshot.data![0].id_tour == tourModel.id){
              return Information_tour(snapshot, tourModel);
            }
          }
        }
        else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text("Loi ${snapshot.error}");
        }
        return Center(child: Container());
      },
    );
  }

  Widget Location(TourModel tourModel, String herotag){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 00),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Stack(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    //padding: EdgeInsets.only(left: 22),
                    child: RotatedBox(
                      quarterTurns: 4,
                      child: Arc(
                        arcType: ArcType.CONVEY,
                        edge: Edge.RIGHT,
                        height: 15.0,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.73,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft:  Radius.circular(24),
                              bottomLeft:  Radius.circular(24),
                            ),
                            gradient: LinearGradient(
                                colors: [Color(0xffb3e5fc),mThirdColor, mThirdColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: mThirdColor,
                      ),
                      child: IconButton(
                          onPressed: (){
                            setState(() {
                              _showAddDialog(tourModel.ma_tinh.toString(), tourModel.loai_tour,
                                  tourModel.id, tourModel.chuyen);
                            });
                          },
                          icon: const Icon(Icons.edit,color: Colors.white,size: 25,)
                      ),),
                  ),
                ],
              ),
              Positioned.fill(
                left: 10,
                right: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                      future: DBProvider.db.queryTinh(tourModel.ma_tinh),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: mFontSize,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          );
                        }
                        else if (snapshot.hasError) {
                          return Text("Loi ${snapshot.error}");
                        }
                        return Center(child: Container());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget Information_tour(AsyncSnapshot<List<ChiPhiModel>> snapshot,TourModel tourModel){
    var string ='';
    var list = snapshot.data![0].khoan_muc.split(',');
    for(int i=0; i<list.length;i++){
      switch(list[i]){
        case '1': string = '$string, chi phí vận chuyển';break;
        case '2': string = '$string, thuê phòng';break;
        case '3': string = '$string, ăn uống';break;
        case '4': string = '$string, thăm quan';break;
        case '5': string = '$string, dịch vụ khác';break;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: GestureDetector(
            onTap: () {
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                        colors: [Color(0xfffdfcfb), mThirdColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    boxShadow: const [
                      BoxShadow(
                        color: mThirdColor,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  left: 20,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FutureBuilder(
                                  future: DBProvider.db.queryTinh(tourModel.ma_tinh),
                                  builder: (context, AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      noiden = snapshot.data!;
                                      return Text(
                                        snapshot.data!,
                                        style: const TextStyle(
                                            fontSize: mFontListTile,
                                            fontWeight: FontWeight.w500),
                                      );
                                    }
                                    else if (snapshot.hasError) {
                                      return Text("Loi ${snapshot.error}");
                                    }
                                    return Center(child: Container());
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Số tiền bình quân 1 người: ${MoneyFormatter(
                                  amount: snapshot.data![0].money_one_people.toDouble()
                              ).output.withoutFractionDigits} nghìn đồng",
                              style: const TextStyle(
                                  fontSize: mFontListTile,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Các khoản mục:${string.replaceFirst(RegExp(r','), '')}",
                              style: const TextStyle(
                                  fontSize: mFontListTile,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Tổng chi tiêu ngoài tour: ${MoneyFormatter(
                                  amount: snapshot.data![0].money_total.toDouble()
                              ).output.withoutFractionDigits} nghìn đồng",
                              style: const TextStyle(
                                  color: mDividerColor,
                                  fontSize: mFontListTile,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit,color: mThirdColor,size: 20,),
                        onPressed: (){
                          _showUpdateDialog(tourModel.ma_tinh.toString(),
                              snapshot.data![0].id,
                              snapshot.data![0].money_one_people.toString(),
                              snapshot.data![0].khoan_muc,
                              snapshot.data![0].money_total.toString(),
                              snapshot.data![0].money_eating.toString(),
                              snapshot.data![0].money_rent.toString(),
                              snapshot.data![0].money_go.toString(),
                              snapshot.data![0].money_visit.toString(),
                              snapshot.data![0].money_buy.toString(),
                              snapshot.data![0].money_play.toString(),
                              snapshot.data![0].money_medical.toString(),
                              snapshot.data![0].money_other.toString(),
                              snapshot.data![0].people.toString(),
                              tourModel.loai_tour, tourModel.id,tourModel.chuyen
                          );
                        },
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSelectDialog(Map<String, bool?> khoanmuc, TextEditingController khoan_muc){
    showDialog(
        context: context,
        builder: (_)=> AlertDialog(
          insetPadding: EdgeInsets.all(20),
          titlePadding: EdgeInsets.all(10),
          contentPadding: const EdgeInsets.fromLTRB(15, 20, 15, 24),
          title: const Text('Các khoản mục đã bao gồm chi phí trong tour'),
          content: SingleChildScrollView(
            child: Column(
              children: khoanmuc.keys.map((item) => CheckboxListTile(
                        value: khoanmuc[item],
                        title: Text(item),
                        onChanged: (isChecked) {
                          setState(() {
                            khoanmuc[item] = isChecked;
                            Navigator.of(context, rootNavigator: true).pop();
                            _showSelectDialog(khoanmuc,khoan_muc);
                          });
                        },
                      )).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Hủy'),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Đồng ý'),
              onPressed: (){
                var list = khoanmuc.values.toList();
                String thamKhao = '';
                for(int i =1; i <= khoanmuc.length; i++){
                  if(list[i-1]==true){
                    thamKhao = '$thamKhao,$i';
                  }
                }
                khoan_muc.text = thamKhao.replaceFirst(RegExp(r','), '');
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        )
    );
  }

  _showAddDialog(String mt, int loaiTour, int idTour, int tour) {
    var money_one_people = TextEditingController();
    var khoan_muc = TextEditingController();
    var money_total = TextEditingController();
    var money_eating = TextEditingController();
    var money_rent = TextEditingController();
    var money_go = TextEditingController();
    var money_visit = TextEditingController();
    var money_buy = TextEditingController();
    var money_play = TextEditingController();
    var money_medical = TextEditingController();
    var money_other = TextEditingController();
    var people = TextEditingController();
    if( MediaQuery.of(context).size.width >= 350){
      width = 0;
    }
    else {
      width = 40;
    }
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          contentPadding: width == 40
              ?const EdgeInsets.fromLTRB(15, 20, 15, 24)
              :const EdgeInsets.fromLTRB(24, 20, 24, 24),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)),
          ),
          title: Container(
            color: Colors.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close,color: Colors.red,),
                    onPressed: (){
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Thông tin chuyến đi theo tour",
                    style: TextStyle(fontSize: mFontSize, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nơi đến: $noiden",
                            style: const TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Mã tỉnh: $mt",
                            style: const TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w500),
                          ),

                        ],),
                      Row(
                        children: [
                          const Text('Số tiền/1 người:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 105-width,
                            child: TextFormField(
                              controller: money_one_people,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              autofocus: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_one_people.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//Số tiền bq 1 người
                      Row(
                        children: [
                          const Text('Các khoản mục:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 185-width,
                            child: TextFormField(
                              controller: khoan_muc,
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: ()=>_showSelectDialog(khoanmuc,khoan_muc),
                                  child: Ink.image(
                                      height: 35,
                                      width: 40,
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/images/check.gif")
                                  ),
                                )
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng chọn các khoản mục';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ), //các mục
                      Row(
                        children: [
                          const Text('Ăn uống:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 155-width,
                            child: TextFormField(
                              controller: money_eating,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_eating.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //ăn uống
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//ăn uống
                      Row(
                        children: [
                          const Text('Thuê phòng:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 130-width,
                            child: TextFormField(
                              controller: money_rent,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_rent.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //thuê phòng
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//thuê phòng
                      Row(
                        children: [
                          const Text('Đi lại:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 180-width,
                            child: TextFormField(
                              controller: money_go,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_go.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //đi lại
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//đi lại
                      Row(
                        children: [
                          const Text('Thăm quan:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 135-width,
                            child: TextFormField(
                              controller: money_visit,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_visit.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //thăm quan
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),// thăm quan
                      Row(
                        children: [
                          const Text('Mua sắm:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 150-width,
                            child: TextFormField(
                              controller: money_buy,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_buy.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //thăm quan
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//mua sắm
                      Row(
                        children: [
                          const Text('Vui chơi:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 160-width,
                            child: TextFormField(
                              controller: money_play,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_play.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//vui chơi
                      Row(
                        children: [
                          const Text('Y tế:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 190-width,
                            child: TextFormField(
                              controller: money_medical,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_medical.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //y tế
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//y tế
                      Row(
                        children: [
                          const Text('Khác:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 180-width,
                            child: TextFormField(
                              controller: money_other,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_other.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                                money_total.text = MoneyFormatter(
                                    amount:(
                                        double.parse(money_eating.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_rent.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_go.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_visit.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_buy.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_play.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_medical.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(value.replaceAll(RegExp(r','), '')))).output.withoutFractionDigits;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //khác
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//khác
                      Row(
                        children: [
                          const Text('Tổng tiền ngoài tour:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 75-width,
                            child: TextFormField(
                              controller: money_total,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              readOnly: true,
                              onChanged: (value){
                                money_total.text = MoneyFormatter(
                                    amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                ).output.withoutFractionDigits;
                              },
                            ),
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//Tổng số
                      Row(
                        children: [
                          const Text('Số người trên 2 tuổi:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 115-width,
                            child: TextFormField(
                              controller: people,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số người';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' người', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//số người
                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        var chiphi = ChiPhiModel(
                            id: 0,
                            stt_ho: widget.stt_ho,
                            id_tour: idTour,
                            tour: tour,
                            money_one_people: int.parse(money_one_people.text.replaceAll(RegExp(r','), '')),
                            khoan_muc: khoan_muc.text,
                            money_total: int.parse(money_total.text.replaceAll(RegExp(r','), '')),
                            money_eating: int.parse(money_eating.text.replaceAll(RegExp(r','), '')),
                            money_rent: int.parse(money_rent.text.replaceAll(RegExp(r','), '')),
                            money_go: int.parse(money_go.text.replaceAll(RegExp(r','), '')),
                            money_visit: int.parse(money_visit.text.replaceAll(RegExp(r','), '')),
                            money_buy: int.parse(money_buy.text.replaceAll(RegExp(r','), '')),
                            money_play: int.parse(money_play.text.replaceAll(RegExp(r','), '')),
                            money_medical: int.parse(money_medical.text.replaceAll(RegExp(r','), '')),
                            money_other: int.parse(money_other.text.replaceAll(RegExp(r','), '')),
                            people: int.parse(people.text),
                            loai_tour: loaiTour, la_tongso: null as int);
                        DBProvider.db.setChiPhi(chiphi);
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(28) //
                        ),
                        gradient: LinearGradient(colors: [
                          mPrimaryColor,
                          Colors.lightBlueAccent,
                          mPrimaryColor
                        ])
                    ),
                    child: const Center(
                      child: Text(
                        'Thêm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _showUpdateDialog(
      String mt,int id, String tien1Nguoi, String KhoanMuc,
      String tongTien, String anUong, String thuePhong,
      String diLai, String thamQuan, String muaSam,
      String vuiChoi, String yTe, String khac,
      String soNguoi, int loaiTour,  int idTour, int tour) {
    var money_one_people = TextEditingController();
    var khoan_muc = TextEditingController();
    var money_total = TextEditingController();
    var money_eating = TextEditingController();
    var money_rent = TextEditingController();
    var money_go = TextEditingController();
    var money_visit = TextEditingController();
    var money_buy = TextEditingController();
    var money_play = TextEditingController();
    var money_medical = TextEditingController();
    var money_other = TextEditingController();
    var people = TextEditingController();
    money_one_people.text = MoneyFormatter(amount: double.parse(tien1Nguoi)).output.withoutFractionDigits;
    khoan_muc.text = KhoanMuc;
    money_total.text =MoneyFormatter(amount: double.parse(tongTien)).output.withoutFractionDigits;
    money_eating.text = MoneyFormatter(amount: double.parse(anUong)).output.withoutFractionDigits;
    money_rent.text = MoneyFormatter(amount: double.parse(thuePhong)).output.withoutFractionDigits;
    money_go.text = MoneyFormatter(amount: double.parse(diLai)).output.withoutFractionDigits;
    money_visit.text = MoneyFormatter(amount: double.parse(thamQuan)).output.withoutFractionDigits;
    money_buy.text = MoneyFormatter(amount: double.parse(muaSam)).output.withoutFractionDigits;
    money_play.text = MoneyFormatter(amount: double.parse(vuiChoi)).output.withoutFractionDigits;
    money_medical.text = MoneyFormatter(amount: double.parse(yTe)).output.withoutFractionDigits;
    money_other.text = MoneyFormatter(amount: double.parse(khac)).output.withoutFractionDigits;
    people.text = soNguoi;
    if( MediaQuery.of(context).size.width >= 350){
      width = 0;
    }
    else {
      width = 40;
    }
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          contentPadding: width == 40
              ?const EdgeInsets.fromLTRB(15, 20, 15, 24)
              :const EdgeInsets.fromLTRB(24, 20, 24, 24),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)),
          ),
          title: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close,color: Colors.red,),
                  onPressed: (){
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Cập nhật chuyến đi theo tour",
                  style: TextStyle(fontSize: mFontSize, color: Colors.blue),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nơi đến: $noiden",
                            style: const TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Mã tỉnh: $mt",
                            style: const TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w500),
                          ),

                        ],),
                      Row(
                        children: [
                          const Text('Số tiền/1 người:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 105-width,
                            child: TextFormField(
                              controller: money_one_people,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              autofocus: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_one_people.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//Số tiền bq 1 người
                      Row(
                        children: [
                          const Text('Các khoản mục:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 185-width,
                            child: TextFormField(
                              controller: khoan_muc,
                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: ()=>_showSelectDialog(khoanmuc,khoan_muc),
                                    child: Ink.image(
                                        height: 35,
                                        width: 40,
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/images/check.gif")
                                    ),
                                  )
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng chọn các khoản mục';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ), //các mục
                      Row(
                        children: [
                          const Text('Ăn uống:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 155-width,
                            child: TextFormField(
                              controller: money_eating,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_eating.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //ăn uống
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//ăn uống
                      Row(
                        children: [
                          const Text('Thuê phòng:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 130-width,
                            child: TextFormField(
                              controller: money_rent,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_rent.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //thuê phòng
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//thuê phòng
                      Row(
                        children: [
                          const Text('Đi lại:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 180-width,
                            child: TextFormField(
                              controller: money_go,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_go.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //đi lại
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//đi lại
                      Row(
                        children: [
                          const Text('Thăm quan:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 135-width,
                            child: TextFormField(
                              controller: money_visit,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_visit.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //thăm quan
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),// thăm quan
                      Row(
                        children: [
                          const Text('Mua sắm:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 150-width,
                            child: TextFormField(
                              controller: money_buy,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_buy.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //thăm quan
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//mua sắm
                      Row(
                        children: [
                          const Text('Vui chơi:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 160-width,
                            child: TextFormField(
                              controller: money_play,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_play.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//vui chơi
                      Row(
                        children: [
                          const Text('Y tế:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 190-width,
                            child: TextFormField(
                              controller: money_medical,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_medical.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //y tế
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//y tế
                      Row(
                        children: [
                          const Text('Khác:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 180-width,
                            child: TextFormField(
                              controller: money_other,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: const TextInputType.numberWithOptions(signed: true),// Only numbers can be entered
                              onChanged: (value){
                                money_other.value = TextEditingValue(
                                  text: MoneyFormatter(
                                      amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                  ).output.withoutFractionDigits,
                                  selection: TextSelection.collapsed(
                                    offset: MoneyFormatter(
                                        amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                    ).output.withoutFractionDigits.length,
                                  ),
                                );
                                money_total.text = MoneyFormatter(
                                    amount:(
                                        double.parse(money_eating.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_rent.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_go.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_visit.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_buy.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_play.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(money_medical.text.replaceAll(RegExp(r','), ''))
                                            +double.parse(value.replaceAll(RegExp(r','), '')))).output.withoutFractionDigits;
                              },
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số tiền';
                                }
                                return null;
                              },
                            ), //khác
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//khác
                      Row(
                        children: [
                          const Text('Tổng tiền ngoài tour:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 75-width,
                            child: TextFormField(
                              controller: money_total,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              readOnly: true,
                              onChanged: (value){
                                money_total.text = MoneyFormatter(
                                    amount: double.parse(value.replaceAll(RegExp(r','), ''))
                                ).output.withoutFractionDigits;
                              },
                            ),
                          ),
                          const Text(' nghìn đồng', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//Tổng số
                      Row(
                        children: [
                          const Text('Số người trên 2 tuổi:', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 115-width,
                            child: TextFormField(
                              controller: people,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập số người';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' người', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//số người
                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        var chiPhiModel = ChiPhiModel(
                            id: 0,
                            stt_ho: widget.stt_ho,
                            id_tour: idTour,
                            tour: tour,
                            money_one_people: int.parse(money_one_people.text.replaceAll(RegExp(r','), '')),
                            khoan_muc: khoan_muc.text,
                            money_total: int.parse(money_total.text.replaceAll(RegExp(r','), '')),
                            money_eating: int.parse(money_eating.text.replaceAll(RegExp(r','), '')),
                            money_rent: int.parse(money_rent.text.replaceAll(RegExp(r','), '')),
                            money_go: int.parse(money_go.text.replaceAll(RegExp(r','), '')),
                            money_visit: int.parse(money_visit.text.replaceAll(RegExp(r','), '')),
                            money_buy: int.parse(money_buy.text.replaceAll(RegExp(r','), '')),
                            money_play: int.parse(money_play.text.replaceAll(RegExp(r','), '')),
                            money_medical: int.parse(money_medical.text.replaceAll(RegExp(r','), '')),
                            money_other: int.parse(money_other.text.replaceAll(RegExp(r','), '')),
                            people: int.parse(people.text),
                            loai_tour: loaiTour, la_tongso: null as int);
                        DBProvider.db.updateChiPhi(chiPhiModel, id);
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(28) //
                        ),
                        gradient: LinearGradient(colors: [
                          mPrimaryColor,
                          Colors.lightBlueAccent,
                          mPrimaryColor
                        ])
                    ),
                    child: const Center(
                      child: Text(
                        'Cập nhật',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  _showStopDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) =>AlertDialog(
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
                            style: TextStyle(
                                color: Colors.red, fontSize: 15)),
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
                              "/interview", (Route<dynamic> route) => false);
                        }),
                  ])
            ],
          ),
        ));
  }

  _showRequestDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) =>AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Image(
            width: 250,
            height: 250,
            image: AssetImage("assets/images/notification.gif"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: const Text(
                  "Chưa hoàn thành thông tin chi tiêu du lịch !",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: mFontSize,
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
                        child: const Text('Quay lại',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: 15)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                  ])
            ],
          ),
        ));
  }
}