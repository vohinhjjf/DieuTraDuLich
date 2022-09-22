import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:thuc_tap/Database/database.dart';
import 'package:thuc_tap/Models/danhsach_model.dart';
import 'package:thuc_tap/Screen/Interview/questions/question6_1.dart';
import 'package:thuc_tap/Screen/Interview/questions/question6_2.dart';
import 'package:thuc_tap/Screen/Interview/questions/question_4.dart';
import '../../../Components/navigation_bar.dart';
import '../../../Components/tour_card.dart';
import '../../../Models/chuyen_model.dart';
import '../../../Models/tinh_model.dart';
import '../../../Models/tour_model.dart';
import '../../../constant.dart';

class Question5 extends StatefulWidget{
  const Question5({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();
}

class Body extends State<Question5>{
  bool? ischeck = true;
  int tour=0, temp=0, temp_chuyen=1;
  List<int> list= [];
  int length=0, max =0;
  double width =0;

  
  getlengthList() async {
    return await DBProvider.db.getInformation(widget.stt_ho).then((value) => length=value.length);
  }
  @override
  void initState() {
    getlengthList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if( MediaQuery.of(context).size.width >= 350){
      width = 40;
    }
    else {
      width = 30;
    }
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
                  print(12.toString().length);
                  _showStopDialog(context);
                },
                text: "STOP",
                color: Colors.white,
                borderShape: const RoundedRectangleBorder(
                    side:  BorderSide(color: Colors.red,width: 2.0),
                    borderRadius:  BorderRadius.all( Radius.circular(4))),
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
              padding:  EdgeInsets.fromLTRB(width/2, 25, width/2, 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("5. Chi tiết về đặc điểm các chuyến đi",
                      style: TextStyle(
                          color: mDividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: mFontSize),
                    ),
                    FutureBuilder(
                      future: DBProvider.db.getTour(widget.stt_ho),
                      initialData: const <TourModel>[],
                      builder: (context, AsyncSnapshot<List<TourModel>> snapshot) {
                        if (snapshot.hasData) {
                          if(snapshot.data!.isEmpty){
                            return ListTour();
                          }
                          for(int i=0; i<snapshot.data!.length;i++){
                            list.add(snapshot.data![i].chuyen);
                          }
                          temp_chuyen = snapshot.data!.length;
                          for(int i=0; i<list.length;i++){
                            if (max < list[i]) {
                              max = list[i];
                            }
                          }
                          return ListTour();
                        } else if (snapshot.hasError) {
                          return Text('AB ${snapshot.error}');
                        }
                        return Center(child: Container());
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: mPrimaryColor)),
                        onPressed: () {
                          setState(() {
                            tour = max + 1;
                            print(tour);
                          });
                        },
                        padding: const EdgeInsets.all(10.0),
                        color: Colors.white,
                        textColor: mPrimaryColor,
                        child: const Text("Thêm chuyến đi",
                            style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.bold)),
                      ),
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
                                builder: (context) => Question4(stt_ho: widget.stt_ho,)));
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
                            if (temp==0 || tour == 0){
                              _showRequestDialog(context);
                            }else {
                              DBProvider.db.getTour_Private(1,widget.stt_ho).then((value) => {
                                if(value.isNotEmpty){
                                  Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Question6_1(stt_ho: widget.stt_ho,)))
                                }
                                else {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Question6_2(stt_ho: widget.stt_ho,)))
                                }
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.navigate_next,
                            color: mPrimaryColor,
                            size: 35,
                          ),
                        ),
                      )), //next
                ],
              ),
            )
          ],
        ),
        drawer: NavBar(
        stt_ho: widget.stt_ho
      ),
    );
  }

  Widget ListTour(){
    print('Tour: $tour');
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: tour,
      itemBuilder: (context, index) {
        return buildTour(index);
      },
    );
  }

  Widget buildTour(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            child: Row(
              children: <Widget>[
                RotatedBox(
                  quarterTurns: 4,
                  child: Arc(
                    arcType: ArcType.CONVEY,
                    edge: Edge.RIGHT,
                    height: 10.0,
                    child: Container(
                      width: width*6+8,
                      height: 50,
                      decoration:  const BoxDecoration(
                        color: mSecondaryColor,
                        borderRadius:  BorderRadius.only(
                          topLeft:  Radius.circular(10),
                          bottomLeft:  Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Text(
                          "Chuyến đi ${index+1}",
                          style: const TextStyle(
                              fontSize: mFontSize,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: "btn1",
                  backgroundColor: mSecondaryColor,
                  onPressed: (){
                    setState(() {
                      _showAddDialog(index,00,'','','','',0,0,0,0,0,0);
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(),
          FutureBuilder(
            future: DBProvider.db.getTour(widget.stt_ho),
            initialData: const <TourModel>[],
            builder: (context, AsyncSnapshot<List<TourModel>> snapshot) {
              if (snapshot.hasData) {
                temp = snapshot.data!.length;
                return buildList(snapshot, index+1);
              } else if (snapshot.hasError) {
                print(snapshot.toString());
                return Text('BC ${snapshot.error}');
              }
              return Center(child: Container());
            },
          )
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<TourModel>> snapshot, int index1) {
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            if (snapshot.data![index].chuyen == index1) {
              return buildData(snapshot.data![index], index);
            }
            return Container();
          },
        );
  }

  Widget buildData(TourModel tourModel, int index) {
    var loai_cs, phuong_tien;
    switch(tourModel.loai_cs){
      case 1: loai_cs = "KS một sao";break;
      case 2: loai_cs = "KS hai sao";break;
      case 3: loai_cs = "KS ba sao";break;
      case 4: loai_cs = "KS bốn sao";break;
      case 5: loai_cs = "KS năm sao";break;
      case 6: loai_cs = "KS chưa xếp sao";break;
      case 7: loai_cs = "Nhà nghỉ, nhà khách";break;
      case 8: loai_cs = "Biệt thự kinh doanh DL";break;
      case 9: loai_cs = "Làng du lịch";break;
      case 10: loai_cs = "Căn hộ kinh doanh DL";break;
      case 11: loai_cs = "Khác";break;
    };
    switch(tourModel.phuong_tien){
      case 1: phuong_tien = "Máy bay";break;
      case 2: phuong_tien = "Ô tô";break;
      case 3: phuong_tien = "Tàu thủy";break;
      case 4: phuong_tien = "Tàu hỏa";break;
      case 5: phuong_tien = "Khác";break;
    };
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 00),
        child: TourCard(
          startColor: const Color(0xfffdfcfb),
          endColor: mThirdColor,
          matinh: tourModel.ma_tinh.toString(),
          dropdown_time: 'tháng ${tourModel.thang.toString()}',
          ngay: tourModel.so_ngay.toString(),
          dem: tourModel.so_dem.toString(),
          dropdown_coso: loai_cs,
          dropdown_vehicle: phuong_tien,
          Update: (){
            _showUpdateDialog(tourModel, int.parse(tourModel.ma_tinh), tourModel.so_ngay.toString(),
                tourModel.so_dem.toString(), tourModel.so_nguoi.toString(), tourModel.stt_nguoi, tourModel.loai_tour);
          },
          Delete: (){
            _showDeletelDialog(tourModel.id);
          },
        ));
  }

  List<DropdownMenuItem<int>> itemTinh (List<TinhModel> listTinh){
    List<DropdownMenuItem<int>> list = [];
    for(int i =0; i < listTinh.length;i++){
      list.add(DropdownMenuItem(value: int.parse(listTinh[i].Ma_Tinh), child: Text(listTinh[i].TenTinh)));
    }
    return list;
  }

  _showAddDialog(int index,int tinh,String _ngay, String _dem,String _numberpeople,String _stt, int month,
      int quatrinh, int coso, int phuongtien, int mucdich, int loaicd) {
    GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
    var ngay = TextEditingController();
    var dem = TextEditingController();
    var numberpeople = TextEditingController();
    var stt = TextEditingController();
    ngay.text = _ngay;
    dem.text = _dem;
    numberpeople.text = _numberpeople;
    stt.text = _stt;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
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
                  "Thông tin chuyến đi",
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
                        children: [
                          const Text('Nơi đến: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 5,),
                          Flexible(
                            fit: FlexFit.loose,
                            child: FutureBuilder(
                              future: DBProvider.db.getTinh(),
                              builder: (context1,AsyncSnapshot<List<TinhModel>> snapshot){
                                if(snapshot.hasData){
                                  return DropdownButton(
                                    value: tinh,
                                    menuMaxHeight: 400,
                                    autofocus: true,
                                    items: itemTinh(snapshot.data!),
                                    onChanged: (int? value) {
                                      setState(() {
                                        tinh = value!;
                                      });
                                      Navigator.of(context).pop();
                                      _showAddDialog(index,tinh,ngay.text,dem.text,numberpeople.text,
                                      stt.text,month,quatrinh,coso,phuongtien,mucdich,loaicd);
                                    },
                                    isExpanded: true,
                                  );
                                }
                                else if(snapshot.hasError){
                                  return Text(snapshot.error.toString());
                                }
                                return Container();
                              },
                            ),
                          ),
                        ],
                      ),//Nơi đến
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Thời gian đi:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: month,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Chọn tháng - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Tháng 1"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tháng 2")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child:  Text("Tháng 3"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child:  Text("Tháng 4"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child:  Text("Tháng 5"),
                                  ),
                                  DropdownMenuItem(
                                    value: 6,
                                    child:  Text("Tháng 6"),
                                  ),
                                  DropdownMenuItem(
                                    value: 7,
                                    child:  Text("Tháng 7"),
                                  ),
                                  DropdownMenuItem(
                                    value: 8,
                                    child:  Text("Tháng 8"),
                                  ),
                                  DropdownMenuItem(
                                    value: 9,
                                    child:  Text("Tháng 9"),
                                  ),
                                  DropdownMenuItem(
                                    value: 10,
                                    child:  Text("Tháng 10"),
                                  ),
                                  DropdownMenuItem(
                                    value: 11,
                                    child:  Text("Tháng 11"),
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Tháng 12"),
                                    value: 12,
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    month = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(index,tinh,ngay.text,dem.text,numberpeople.text,
                                      stt.text,month,quatrinh,coso,phuongtien,mucdich,loaicd);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Thời gian đi
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Quá trình ở:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: quatrinh,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Chọn quá trình ở- -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Nghỉ đêm"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Trong ngày")
                                  )
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    quatrinh = value!;
                                    if(quatrinh == 2){
                                      ngay.text = 1.toString();
                                    }
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(index,tinh,ngay.text,dem.text,numberpeople.text,
                                      stt.text,month,quatrinh,coso,phuongtien,mucdich,loaicd);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ),
                      quatrinh != 2
                          ? Row(
                        children: [
                          const Text('Độ dài chuyến đi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 5,),
                          SizedBox(
                            width: width,
                            child: TextFormField(
                              controller: ngay,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập thời gian chuyến đi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' ngày', style: TextStyle(fontSize: mFontListTile)),
                          const SizedBox(width: 5,),
                          SizedBox(
                            width: width,
                            child: TextFormField(
                              controller: dem,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập thời gian chuyến đi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' đêm', style: TextStyle(fontSize: mFontListTile))
                        ],
                      )
                          : Row(
                            children: [
                              const Text('Độ dài chuyến đi: ', style: TextStyle(fontSize: mFontListTile),),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: width*3,
                                child: TextFormField(
                                  controller: ngay,
                                  textAlign: TextAlign.end,
                                  decoration: const InputDecoration(),
                                  keyboardType: TextInputType.number,// Only numbers can be entered
                                  readOnly: true,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Vui lòng nhập thời gian chuyến đi';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Text(' ngày', style: TextStyle(fontSize: mFontListTile)),
                        ],
                      ), //Độ dài chuyến đi
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Cs lưu trú:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: coso,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Chọn cơ sở --"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("KS một sao"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("KS hai sao")
                                  ),
                                  DropdownMenuItem(
                                      value: 3,
                                      child: Text("KS ba sao")
                                  ),
                                  DropdownMenuItem(
                                      value: 4,
                                      child: Text("KS bốn sao")
                                  ),
                                  DropdownMenuItem(
                                      value: 5,
                                      child: Text("KS năm sao")
                                  ),
                                  DropdownMenuItem(
                                      value: 6,
                                      child: Text("KS chưa xếp sao")
                                  ),
                                  DropdownMenuItem(
                                      value: 7,
                                      child: Text("Nhà nghỉ, nhà khách")
                                  ),
                                  DropdownMenuItem(
                                      value: 8,
                                      child: Text("Biệt thự kinh doanh DL")
                                  ),
                                  DropdownMenuItem(
                                      value: 9,
                                      child: Text("Làng du lịch")
                                  ),
                                  DropdownMenuItem(
                                      value: 10,
                                      child: Text("Căn hộ kinh doanh DL")
                                  ),
                                  DropdownMenuItem(
                                      value: 11,
                                      child: Text("Khác")
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    coso = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(index,tinh,ngay.text,dem.text,numberpeople.text,
                                      stt.text,month,quatrinh,coso,phuongtien,mucdich,loaicd);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Loại cơ sở
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Phương tiện chính:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: phuongtien,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("--Phương tiện--"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Máy bay"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Ô tô")
                                  ),
                                  DropdownMenuItem(
                                      value: 3,
                                      child: Text("Tàu thủy")
                                  ),
                                  DropdownMenuItem(
                                      value: 4,
                                      child: Text("Tàu hỏa")
                                  ),DropdownMenuItem(
                                      value: 5,
                                      child: Text("Khác")
                                  )
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    phuongtien = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(index,tinh,ngay.text,dem.text,numberpeople.text,
                                      stt.text,month,quatrinh,coso,phuongtien,mucdich,loaicd);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //phương tiện
                      Row(
                        children: [
                          const Text('Số người của hộ đi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: width*2.5,
                            child: TextFormField(
                              controller: numberpeople,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              readOnly: true,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập tổng số người của hộ gia đình đi';
                                }
                                if(int.parse(value) > length) {
                                  return 'Không hợp lệ';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' người', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//Số người
                      Row(
                        children: [
                          const Text('STT của người đi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: width*4,
                            child: TextFormField(
                              controller: stt,
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () => _showMemberDialog(stt,numberpeople),
                                  icon: const Icon(
                                    Icons.people_alt,
                                    color: mPrimaryColor,
                                  ),
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập stt';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),//STT
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Mục đích:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: mucdich,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Chọn mục đích - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Du lịch, nghỉ ngơi"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Thông tin báo chí")
                                  ),
                                  DropdownMenuItem(
                                      value: 3,
                                      child: Text("Hội nghị, hội thảo")
                                  ),
                                  DropdownMenuItem(
                                      value: 4,
                                      child: Text("Thăm họ hàng, bạn bè")
                                  ),
                                  DropdownMenuItem(
                                      value: 5,
                                      child: Text("Thương mại")
                                  ),
                                  DropdownMenuItem(
                                      value: 6,
                                      child: Text("Chữa bệnh")
                                  ),
                                  DropdownMenuItem(
                                      value: 7,
                                      child: Text("Khác")
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    mucdich = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(index,tinh,ngay.text,dem.text,numberpeople.text,
                                      stt.text,month,quatrinh,coso,phuongtien,mucdich,loaicd);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Mục đích
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Loại chuyến đi:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: loaicd,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("--Loại chuyến đi--"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Theo tour"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tự sắp xếp")
                                  )
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    loaicd = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(index,tinh,ngay.text,dem.text,numberpeople.text,
                                      stt.text,month,quatrinh,coso,phuongtien,mucdich,loaicd);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Theo tour hoặc tự sắp xếp
                      const SizedBox(
                        child: Padding(padding: EdgeInsets.fromLTRB(0,0,0,20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      dem.text = quatrinh == 1? dem.text : '0';
                      setState(() {
                        if(tinh==00 || month == 0 || quatrinh == 0 || coso == 0 || phuongtien ==0 || mucdich == 0 || loaicd == 0){
                          var tinh_error = tinh==0? ", tỉnh" : "";
                          var month_error = month == 0? ", tháng" : "";
                          var quatrinh_error = quatrinh==0? ", quá trình đi":"";
                          var coso_error = coso == 0? ", cơ sở":"";
                          var phuongtien_error= phuongtien==0? ", phương tiện":'';
                          var mucdich_error= mucdich==0? ', mục đích':'';
                          var loaicd_error= loaicd==0? ', loại chuyến đi':"";
                          var value = '$tinh_error$month_error$quatrinh_error$coso_error$phuongtien_error$mucdich_error$loaicd_error';
                          _showNotificationDialog(value.replaceFirst(RegExp(r','), ''));
                        }else {
                          TourModel tour = TourModel(
                              id: 0,
                              so_ngay: int.parse(ngay.text),
                              so_dem: int.parse(dem.text),
                              loai_tour: loaicd,
                              stt_nguoi: stt.text.toString(),
                              ngay_dem: quatrinh,
                              thang: month,
                              loai_cs: coso,
                              phuong_tien: phuongtien,
                              muc_dich: mucdich,
                              ma_tinh: tinh.toString().length==1?"0$tinh":"$tinh",
                              so_nguoi: int.parse(numberpeople.text),
                              chuyen: (index + 1),
                              stt_ho: widget.stt_ho);
                          DBProvider.db.setTour(tour);
                          Navigator.of(context, rootNavigator: true).pop();
                        }
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

  _showUpdateDialog(TourModel tourModel, int maTinh, String ngay,String dem, String songuoi, String stt, int loaitour) {
    GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
    var _ngay = TextEditingController();
    var _dem = TextEditingController();
    var _songuoi = TextEditingController();
    var _stt = TextEditingController();
    _ngay.text = ngay;
    _dem.text = dem;
    _songuoi.text = songuoi;
    _stt.text = stt;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
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
                  "Cập nhật chuyến đi",
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
                        children: [
                          const Text('Nơi đến: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 5,),
                          Flexible(
                            fit: FlexFit.loose,
                            child: FutureBuilder(
                              future: DBProvider.db.getTinh(),
                              builder: (context1,AsyncSnapshot<List<TinhModel>> snapshot){
                                if(snapshot.hasData){
                                  return DropdownButton(
                                    value: maTinh,
                                    menuMaxHeight: 400,
                                    autofocus: true,
                                    items: itemTinh(snapshot.data!),
                                    onChanged: (int? value) {
                                      setState(() {
                                        maTinh = value!;
                                      });
                                      Navigator.of(context).pop();
                                      _showUpdateDialog(tourModel,maTinh
                                          ,_ngay.text,_dem.text,_songuoi.text,_stt.text, loaitour);
                                    },
                                    isExpanded: true,
                                  );
                                }
                                else if(snapshot.hasError){
                                  return Text(snapshot.error.toString());
                                }
                                return Container();
                              },
                            ),
                          ),
                        ],
                      ),//Nơi đến
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Thời gian đi:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: tourModel.thang,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Tháng 1"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tháng 2")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Tháng 3"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Tháng 4"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Tháng 5"),
                                  ),
                                  DropdownMenuItem(
                                    value: 6,
                                    child: Text("Tháng 6"),
                                  ),
                                  DropdownMenuItem(
                                    value: 7,
                                    child: Text("Tháng 7"),
                                  ),
                                  DropdownMenuItem(
                                    value: 8,
                                    child: Text("Tháng 8"),
                                  ),
                                  DropdownMenuItem(
                                    value: 9,
                                    child: Text("Tháng 9"),
                                  ),
                                  DropdownMenuItem(
                                    value: 10,
                                    child: Text("Tháng 10"),
                                  ),
                                  DropdownMenuItem(
                                    value: 11,
                                    child: Text("Tháng 11"),
                                  ),
                                  DropdownMenuItem(
                                    value: 12,
                                    child: Text("Tháng 12"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    tourModel.thang = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(tourModel,maTinh
                                      ,_ngay.text,_dem.text,_songuoi.text,_stt.text, loaitour);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Thời gian đi
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Quá trình ở:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: tourModel.ngay_dem,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    child: Text("Nghỉ đêm"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Trong ngày"),
                                      value: 2
                                  )
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    tourModel.ngay_dem = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(tourModel,maTinh
                                      ,_ngay.text,_dem.text,_songuoi.text,_stt.text, loaitour);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //quá trình
                      tourModel.ngay_dem == 1
                      ?Row(
                        children: [
                          const Text('Độ dài chuyến đi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 5,),
                          SizedBox(
                            width: width,
                            child: TextFormField(
                              controller: _ngay,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập thời gian chuyến đi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' ngày', style: TextStyle(fontSize: mFontListTile)),
                          const SizedBox(width: 5,),
                          SizedBox(
                            width: width,
                            child: TextFormField(
                              controller: _dem,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập thời gian chuyến đi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' đêm', style: TextStyle(fontSize: mFontListTile))
                        ],
                      )
                      :Row(
                        children: [
                          const Text('Độ dài chuyến đi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 5,),
                          SizedBox(
                            width: width*3,
                            child: TextFormField(
                              controller: _ngay,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập thời gian chuyến đi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' ngày', style: TextStyle(fontSize: mFontListTile)),
                        ],
                      ),//Độ dài chuyến đi
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Cs lưu trú:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: tourModel.loai_cs,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    child: Text("KS một sao"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                      child: Text("KS hai sao"),
                                      value: 2
                                  ),
                                  DropdownMenuItem(
                                      child: Text("KS ba sao"),
                                      value: 3
                                  ),
                                  DropdownMenuItem(
                                      child: Text("KS bốn sao"),
                                      value: 4
                                  ),
                                  DropdownMenuItem(
                                      child: Text("KS năm sao"),
                                      value: 5
                                  ),
                                  DropdownMenuItem(
                                      child: Text("KS chưa xếp sao"),
                                      value: 6
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Nhà nghỉ, nhà khách"),
                                      value: 7
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Biệt thự kinh doanh DL"),
                                      value: 8
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Làng du lịch"),
                                      value: 9
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Căn hộ kinh doanh DL"),
                                      value: 10
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Khác"),
                                      value: 11
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    tourModel.loai_cs = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(tourModel,maTinh
                                      ,_ngay.text,_dem.text,_songuoi.text,_stt.text, loaitour);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Loại cơ sở
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Phương tiện chính:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: tourModel.phuong_tien,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    child: Text("Máy bay"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Ô tô"),
                                      value: 2
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Tàu thủy"),
                                      value: 3
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Tàu hỏa"),
                                      value: 4
                                  ),DropdownMenuItem(
                                      child: Text("Khác"),
                                      value: 5
                                  )
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    tourModel.phuong_tien = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(tourModel,maTinh
                                      ,_ngay.text,_dem.text,_songuoi.text,_stt.text, loaitour);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //phương tiện
                      Row(
                        children: [
                          const Text('Số người của hộ đi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: width*2.5,
                            child: TextFormField(
                              controller: _songuoi,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              readOnly: true,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập tổng số người của hộ gia đình';
                                }
                                if(int.parse(value) > length) {
                                  return 'Lỗi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' người', style: TextStyle(fontSize: mFontListTile))
                        ],
                      ),//Số người
                      Row(
                        children: [
                          const Text('STT của người đi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: width*4,
                            child: TextFormField(
                              controller: _stt,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () => _showMemberDialog(_stt,_songuoi),
                                  icon: const Icon(
                                    Icons.people_alt,
                                    color: mPrimaryColor,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập stt';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),//STT
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Mục đích:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: tourModel.muc_dich,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    child: Text("Du lịch, nghỉ ngơi"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Thông tin báo chí"),
                                      value: 2
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Hội nghị, hội thảo"),
                                      value: 3
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Thăm họ hàng, bạn bè"),
                                      value: 4
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Thương mại"),
                                      value: 5
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Chữa bệnh"),
                                      value: 6
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Khác"),
                                      value: 7
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    tourModel.muc_dich = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(tourModel,maTinh
                                      ,_ngay.text,_dem.text,_songuoi.text,_stt.text, loaitour);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Mục đích
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Loại chuyến đi:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: loaitour,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Theo tour"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tự sắp xếp")
                                  )
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    loaitour = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(tourModel,maTinh
                                      ,_ngay.text,_dem.text,_songuoi.text,_stt.text, loaitour);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Theo tour hoặc tự sắp xếp
                      const SizedBox(
                        child: Padding(padding: EdgeInsets.fromLTRB(0,0,0,20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        TourModel tour = TourModel(
                            id: tourModel.id,
                            so_ngay: int.parse(_ngay.text),
                            so_dem: int.parse(_dem.text),
                            loai_tour: loaitour,
                            stt_nguoi: _stt.text.toString(),
                            ngay_dem: tourModel.ngay_dem,
                            thang: tourModel.thang,
                            loai_cs: tourModel.loai_cs,
                            phuong_tien: tourModel.phuong_tien,
                            muc_dich: tourModel.muc_dich,
                            ma_tinh: maTinh.toString(),
                            so_nguoi: int.parse(_songuoi.text),
                            chuyen: tourModel.chuyen,
                            stt_ho: widget.stt_ho);
                        DBProvider.db.updateTour(tour, tourModel.id);
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

  _showDeletelDialog(int id) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Image(
            width: 200,
            height: 200,
            image: AssetImage("assets/images/deleted.gif"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: const Text(
                  "Bạn có chắc muốn xóa thông tin địa điểm này không?",
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
                        child: const Text('Hủy bỏ',
                            style: TextStyle(
                                color: Colors.red, fontSize: 15)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                    FlatButton(
                        child:  const Text('Đồng ý',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: 15)),
                        onPressed: () {
                          setState((){
                            DBProvider.db.deleteTour(id);
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                        }),
                  ])
            ],
          ),
        ));
  }

  _showMemberDialog(TextEditingController _stt, TextEditingController _numberpeople){
    List<int> listStt = [];
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
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
                  "Vui lòng chọn thành viên",
                  style: TextStyle(fontSize: mFontSize, color: Colors.blue),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
            children: [
                FutureBuilder(
                  future: DBProvider.db.getInformation(widget.stt_ho),
                  initialData: const <DanhSachModel>[],
                  builder: (BuildContext context,AsyncSnapshot<List<DanhSachModel>> snapshot){
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      return buildListInformation(snapshot,listStt);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    setState(() {
                      listStt.sort();
                      String sothutu='';
                       if(listStt.isNotEmpty){
                         for(int i =0; i< listStt.length; i++){
                           sothutu = sothutu +','+ listStt[i].toString();
                         }
                       }
                       _stt.text = sothutu.replaceFirst(RegExp(r','), '');
                       _numberpeople.text = listStt.length.toString();
                      Navigator.of(context, rootNavigator: true).pop();
                    });
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
              ]
            )
          ),
        )
    );
  }

  Widget buildListInformation(AsyncSnapshot<List<DanhSachModel>> snapshot,List<int> listStt) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      height: 160 * snapshot.data!.length.toDouble(),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: snapshot.data?.length,
        itemBuilder: (context, index) {
          if(listStt.isNotEmpty){
            if(index+1 == listStt[0]){
              ischeck = false;
            }
          }
          return buildDataInformation(ischeck!,snapshot.data![index],listStt);
        },
      ),
    );
  }

  Widget buildDataInformation(bool check ,DanhSachModel informationModel,List<int> listStt) {
    var title = informationModel.id == 1 ? "Người khai phiếu" : 'Thành viên';
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 0),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 150,
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
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: mFontSize,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  const Text(
                                    "Họ và tên: ",
                                    style: TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    informationModel.name,
                                    style: const TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  const Text(
                                    "Tuổi: ",
                                    style: TextStyle(
                                        fontSize: mFontListTile,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    informationModel.age.toString()+" tuổi",
                                    style: const TextStyle(
                                        fontSize: mFontListTile,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ]),
                            const SizedBox(height: 5),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  const Text("Giới tính: ",
                                    style: TextStyle(
                                        fontSize: mFontListTile,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    informationModel.gender == 1? "Nam" : "Nữ",
                                    style: const TextStyle(
                                        fontSize: mFontListTile,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                ],
                              ),
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
                      child: RoundCheckBox(
                        isChecked: !check,
                        onTap: (selected) {
                          setState(() => {
                            ischeck= selected!,
                            if(ischeck!){
                              listStt.add(informationModel.id)
                            }else {
                              listStt.remove(informationModel.id)
                            }
                          });
                        },
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        checkedColor: Colors.white,
                        checkedWidget: const Icon(Icons.check, color: mPrimaryColor),
                        uncheckedWidget: null,
                        animationDuration: const Duration(
                          seconds: 1,
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  "Chưa có thông tin chuyến đi",
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

  _showNotificationDialog(String value){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title:  Text('Thông báo: Chưa có thông tin$value',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: mFontListTile, color: mDividerColor,fontWeight: FontWeight.w400),),
          content: Container(
            height: 50,
            alignment: Alignment.center,
            child: MaterialButton(
                height: 50,
                minWidth: (MediaQuery.of(context).size.width-80),
                shape: const Border(
                    top: BorderSide(color: mDividerColor)
                ),
                child: const Text('Nhập lại',
                    style: TextStyle(
                        color: mPrimaryColor, fontSize: mFontListTile)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                }
            ),
          ),
        ));
  }
}
