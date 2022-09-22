import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:thuc_tap/Screen/Interview/questions/question6_2.dart';
import 'package:thuc_tap/Screen/Interview/questions/question8.dart';
import '../../../Components/navigation_bar.dart';
import '../../../Database/database.dart';
import '../../../Models/danhgia_model.dart';
import '../../../Models/tinh_model.dart';
import '../../../Models/tour_model.dart';
import '../../../constant.dart';

class Question7 extends StatefulWidget{
  const Question7({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();
}

class Body extends State<Question7>{
  bool? ischeck = true;
  int temp=0, temp_tour=0;

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
                borderShape: RoundedRectangleBorder(
                    side:new  BorderSide(color: Colors.red,width: 2.0),
                    borderRadius: new BorderRadius.all(new Radius.circular(4))),
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
              padding: const EdgeInsets.fromLTRB(20, 25, 10, 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("7. Xin Ông/Bà đánh giá về chất lượng một số dịch vụ cơ bản tại nơi đến",
                      style: TextStyle(
                          color: mDividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: mFontSize),
                    ),
                    const SizedBox(height: 10,),
                    FutureBuilder(
                      future: DBProvider.db.getTour(widget.stt_ho),
                      initialData: const <TourModel>[],
                      builder: (context, AsyncSnapshot<List<TourModel>> snapshot) {
                        if (snapshot.hasData) {
                            temp_tour = snapshot.data!.length;
                            return ListTour(snapshot);
                        }
                        else if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Text("Loi ${snapshot.error}");
                        }
                        return Center(child: Container());
                      },
                    )
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
                                builder: (context) => Question6_2(stt_ho: widget.stt_ho)));
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
                            DBProvider.db.getDanhGia(widget.stt_ho).then((value) => {
                                print('${value.length} - $temp_tour'),
                                (value.length < temp_tour) ? _showRequestDialog(context)
                                : Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Question8(stt_ho: widget.stt_ho))),
                            });
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
        drawer: NavBar(stt_ho: widget.stt_ho,),
    );
  }

  Widget ListTour(AsyncSnapshot<List<TourModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return buildTour(snapshot.data![index]);
      },
    );
  }

  Widget buildTour(TourModel tourModel){
    return FutureBuilder(
      future: DBProvider.db.getDanhGia_MATINH(widget.stt_ho, tourModel.ma_tinh),
      builder: (context, AsyncSnapshot<List<DanhGiaModel>> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.isEmpty){
            return Location(tourModel);
          }
          else {
            return buildList(snapshot);
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

  Widget Location(TourModel tourModel){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
          child: Stack(
            children: <Widget>[
              Stack(
                children: [
                  RotatedBox(
                    quarterTurns: 4,
                    child: Arc(
                      arcType: ArcType.CONVEY,
                      edge: Edge.RIGHT,
                      height: 15.0,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:  Radius.circular(24),
                            bottomLeft:  Radius.circular(24),
                          ),
                          gradient: LinearGradient(
                              colors: [Color(0xffb3e5fc),mThirdColor, mThirdColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 50,
                      child: FloatingActionButton(
                          heroTag: 'herotag',
                          backgroundColor: mThirdColor,
                          onPressed: (){
                            setState(() {
                              _showAddDialog(tourModel.ma_tinh,0,0,0,0,0);
                            });
                          },
                          child: const Icon(Icons.edit,color: Colors.white,size: 25,)
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
                            "${snapshot.data!}",
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

  Widget buildList(AsyncSnapshot<List<DanhGiaModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
          return buildData(snapshot.data![index]);
      },
    );
  }

  Widget buildData(DanhGiaModel danhgiaModel) {
    var coso, congty, nhahang, thamquan, moitruong;
    switch(danhgiaModel.co_so){
      case 1: coso = "Rất tốt";break;
      case 2: coso = "Tốt";break;
      case 3: coso = "Bình thường";break;
      case 4: coso = "Không tốt";break;
      case 5: coso = "Rất không tốt";break;
      default: coso = "";break;
    };
    switch(danhgiaModel.cong_ty){
      case 1: congty = "Rất tốt";break;
      case 2: congty = "Tốt";break;
      case 3: congty = "Bình thường";break;
      case 4: congty = "Không tốt";break;
      case 5: congty = "Rất không tốt";break;
      default: congty = "";break;
    };
    switch(danhgiaModel.nhahang_quanan){
      case 1: nhahang = "Rất tốt";break;
      case 2: nhahang = "Tốt";break;
      case 3: nhahang = "Bình thường";break;
      case 4: nhahang = "Không tốt";break;
      case 5: nhahang = "Rất không tốt";break;
      default: nhahang = "";break;
    };
    switch(danhgiaModel.tham_quan){
      case 1: thamquan = "Rất tốt";break;
      case 2: thamquan = "Tốt";break;
      case 3: thamquan = "Bình thường";break;
      case 4: thamquan = "Không tốt";break;
      case 5: thamquan = "Rất không tốt";break;
      default: thamquan = "";break;
    };
    switch(danhgiaModel.moi_truong){
      case 1: moitruong = "Rất tốt";break;
      case 2: moitruong = "Tốt";break;
      case 3: moitruong = "Bình thường";break;
      case 4: moitruong = "Không tốt";break;
      case 5: moitruong = "Rất không tốt";break;
      default: moitruong = "";break;
    };
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
            onTap: () {
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: 200,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FutureBuilder(
                                  future: DBProvider.db.queryTinh(danhgiaModel.ma_tinh),
                                  builder: (context, AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        style: const TextStyle(
                                            fontSize: mFontSize,
                                            fontWeight: FontWeight.w500,
                                            color: mDividerColor),
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
                            Row(
                              children: [
                                const Text(
                                  "Cơ sở lưu trú: ",
                                  style: TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  coso,
                                  style: const TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "Công ty lữ hành: ",
                                  style: TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  congty,
                                  style: const TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "Nhà hàng, quán ăn: ",
                                  style: TextStyle(
                                      color: mDividerColor,
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  nhahang,
                                  style: const TextStyle(
                                      color: mDividerColor,
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "Điểm thăm quan: ",
                                  style: TextStyle(
                                      color: mDividerColor,
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  thamquan,
                                  style: const TextStyle(
                                      color: mDividerColor,
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "Nhà hàng, quán ăn: ",
                                  style: TextStyle(
                                      color: mDividerColor,
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  moitruong,
                                  style: const TextStyle(
                                      color: mDividerColor,
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
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
                          _showUpdateDialog(danhgiaModel, danhgiaModel.ma_tinh.toString());
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

  List<DropdownMenuItem<int>> itemTinh (List<TinhModel> listTinh){
    List<DropdownMenuItem<int>> list = [];
    for(int i =0; i < listTinh.length;i++){
      list.add(DropdownMenuItem(value: int.parse(listTinh[i].Ma_Tinh), child: Text('${listTinh[i].TenTinh}')));
    }
    return list;
  }

  _showAddDialog(String matinh, int dropdown_coso, int dropdown_congty, 
      int dropdown_nhahang, int dropdown_thamquan, int dropdown_moitruong) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: MediaQuery.of(context).size.width < 350
              ?const EdgeInsets.fromLTRB(15, 20, 15, 24)
              :const EdgeInsets.fromLTRB(24, 20, 24, 24),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)),
          ),
          title: Container(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: const Text(
              "Đánh giá chất lượng dịch vụ",
              style: TextStyle(fontSize: mFontSize, color: Colors.blue),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                                  "Nơi đến: ",
                                  style: TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w500),
                                ),
                          FutureBuilder(
                            future: DBProvider.db.queryTinh(matinh),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: const TextStyle(
                                      fontSize: mFontListTile,
                                      color: mDividerColor,
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
                      ),//Nơi đến
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Cơ sở lưu trú:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                alignment: AlignmentDirectional.topCenter,
                                value: dropdown_coso,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Cơ sở - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    dropdown_coso = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(matinh,dropdown_coso,dropdown_congty,
                                      dropdown_nhahang,dropdown_thamquan,dropdown_moitruong);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Cơ sở lưu trú
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Công ty lữ hành:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: dropdown_congty,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Lữ hành - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    dropdown_congty = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(matinh,dropdown_coso,dropdown_congty,
                                      dropdown_nhahang,dropdown_thamquan,dropdown_moitruong);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Công ty lữ hành
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Nhà hàng, quán ăn:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: dropdown_nhahang,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Nhà hàng - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    dropdown_nhahang = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(matinh,dropdown_coso,dropdown_congty,
                                      dropdown_nhahang,dropdown_thamquan,dropdown_moitruong);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Nhà hàng, quán ăn
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Điểm thăm quan:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: dropdown_thamquan,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Thăm quan - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    dropdown_thamquan = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(matinh,dropdown_coso,dropdown_congty,
                                      dropdown_nhahang,dropdown_thamquan,dropdown_moitruong);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Điểm thăm quan
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Vệ sinh môi trường:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                alignment: AlignmentDirectional.center,
                                value: dropdown_moitruong,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Vệ sinh - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    dropdown_moitruong = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(matinh,dropdown_coso,dropdown_congty,
                                      dropdown_nhahang,dropdown_thamquan,dropdown_moitruong);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Vệ sinh môi trường
                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        if(dropdown_coso == 0 || dropdown_congty == 0 || dropdown_nhahang == 0
                            || dropdown_thamquan == 0 || dropdown_moitruong == 0){
                          var coso = dropdown_coso ==0?", cơ sở lưu trú":"";
                          var congty = dropdown_congty==0 ?", công ty lữ hành":"";
                          var nhahang = dropdown_nhahang==0 ?", nhà hàng quán ăn":"";
                          var thamquan = dropdown_thamquan==0 ?", điểm thăm quan":"";
                          var moitruong = dropdown_moitruong==0 ?", vệ sinh môi trường":"";
                          var value = "$coso$congty$nhahang$thamquan$moitruong";
                          _showNotificationDialog(value.replaceFirst(RegExp(r','), ''));
                        }
                        else {
                          var danhgiaModel = DanhGiaModel(
                              stt_ho: widget.stt_ho,
                              ma_tinh: matinh,
                              co_so: dropdown_coso,
                              cong_ty: dropdown_congty,
                              nhahang_quanan: dropdown_nhahang,
                              tham_quan: dropdown_thamquan,
                              moi_truong: dropdown_moitruong);
                          DBProvider.db.setDanhGia(danhgiaModel);
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

  _showUpdateDialog(DanhGiaModel danhgiaModel, String mt) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)),
          ),
          title: Container(
            padding: const EdgeInsets.only(left: 20),
            child: const Text(
              "Cập nhật chất lượng dịch vụ",
              style: TextStyle(fontSize: mFontSize, color: Colors.blue),
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
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Nơi đến: ",
                            style: TextStyle(
                                fontSize: mFontListTile,),
                          ),
                          FutureBuilder(
                            future: DBProvider.db.queryTinh(mt),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: const TextStyle(
                                      fontSize: mFontListTile,
                                      color: mDividerColor),
                                );
                              }
                              else if (snapshot.hasError) {
                                return Text("Loi ${snapshot.error}");
                              }
                              return Center(child: Container());
                            },
                          ),
                        ],
                      ), //Nơi đến
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Cơ sở lưu trú:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: danhgiaModel.co_so,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Cơ sở - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    danhgiaModel.co_so = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(danhgiaModel, mt);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Cơ sở lưu trú
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Công ty lữ hành:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: danhgiaModel.cong_ty,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    danhgiaModel.cong_ty = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(danhgiaModel, mt);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Công ty lữ hành
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Nhà hàng, quán ăn:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: danhgiaModel.nhahang_quanan,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    danhgiaModel.nhahang_quanan = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(danhgiaModel, mt);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Nhà hàng, quán ăn
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Điểm thăm quan:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: danhgiaModel.tham_quan,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Thăm quan - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    danhgiaModel.tham_quan = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(danhgiaModel, mt);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Điểm thăm quan
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Vệ sinh môi trường:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: danhgiaModel.moi_truong,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Vệ sinh - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Rất tốt"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Tốt")
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text("Bình thường"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text("Không tốt"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text("Rất không tốt"),
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    danhgiaModel.moi_truong = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(danhgiaModel, mt);
                                },
                                isExpanded: true,
                              )),
                        ],
                      ), //Vệ sinh môi trường
                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        var danhgiaModel1 = DanhGiaModel(
                            stt_ho: widget.stt_ho,
                            ma_tinh: mt.toString(),
                            co_so: danhgiaModel.co_so,
                            cong_ty: danhgiaModel.cong_ty,
                            nhahang_quanan: danhgiaModel.nhahang_quanan,
                            tham_quan: danhgiaModel.tham_quan,
                            moi_truong: danhgiaModel.moi_truong);
                        DBProvider.db.updateDanhGia(danhgiaModel1);
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
        ));
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
                  "Chưa hoàn thành thông tin đánh giá !",
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