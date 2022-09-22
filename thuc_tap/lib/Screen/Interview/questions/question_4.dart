import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/Components/navigation_bar.dart';
import 'package:thuc_tap/Screen/Interview/questions/question5.dart';
import 'package:thuc_tap/Screen/Interview/questions/question_3.dart';
import '../../../Components/information_card.dart';
import '../../../Database/database.dart';
import '../../../Models/danhsach_model.dart';
import '../../../constant.dart';

class Question4 extends StatefulWidget{
  const Question4({Key? key, required this.stt_ho}) : super(key: key);
  final String stt_ho;
  @override
  Body createState() => Body();
}

class Body extends State<Question4>{
  bool? ischeck = true;
  int stt = 0;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
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
        body:Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 25, 10, 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("4. Xin Ông/Bà vui lòng cho biết thông tin về những thành viên này?",
                      style: TextStyle(
                          color: mDividerColor,
                          fontWeight: FontWeight.w500,
                          fontSize: mFontSize),
                    ),
                    _showList(context),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: mPrimaryColor)),
                        onPressed: () {
                          _showAddDialog('','',0,0,0);
                        },
                        color: Colors.white,
                        textColor: mPrimaryColor,
                        child: const Text("Thêm thành viên",
                            style: TextStyle(fontSize: mFontListTile, fontWeight: FontWeight.bold)),
                      ),
                    ),
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
                                builder: (context) =>  Question3(stt_ho: widget.stt_ho,)));
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
                            print(stt);
                            stt==0?{
                              _showRequestDialog(context)
                            }:
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => Question5(stt_ho: widget.stt_ho,)));
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
  _showList(BuildContext context){
    return FutureBuilder(
        future: DBProvider.db.getInformation(widget.stt_ho),
        initialData: const <DanhSachModel>[],
        builder: (BuildContext context, AsyncSnapshot<List<DanhSachModel>> snapshot){
          if (snapshot.hasData) {
            stt = snapshot.data!.length;
            if (snapshot.data!.isEmpty) {
              return Container();
            }
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text("Loi ${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }

  Widget buildList(AsyncSnapshot<List<DanhSachModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        return buildData(snapshot.data![index]);
      },
    );
  }

  Widget buildData(DanhSachModel DanhSachModel) {
    String title = DanhSachModel.id == 1 ? 'Người khai phiếu':'Thành viên';
    String gender = DanhSachModel.gender == 1 ? 'Nam':'Nữ';
    var qualification, job;
    switch(DanhSachModel.qualification){
      case 1: qualification = "Chưa qua đào tạo";break;
      case 2: qualification = "Đào tạo dưới 3 tháng";break;
      case 3: qualification = "Sơ cấp";break;
      case 4: qualification = "Trung cấp";break;
      case 5: qualification = "Cao đẳng";break;
      case 6: qualification = "Đại học";break;
      case 7: qualification = "Thạc sỹ";break;
      case 8: qualification = "Tiến sỹ";break;
      case 9: qualification = "Trình độ khác";break;
    };
    switch(DanhSachModel.job){
      case 1: job = "Thương gia";break;
      case 2: job = "Nhà báo";break;
      case 3: job = "Giáo sư, giáo vi";break;
      case 4: job = "Kiến trúc sư";break;
      case 5: job = "Hưu trí";break;
      case 6: job = "Học sinh, sinh viên";break;
      case 7: job = "Công chức, viên chức";break;
      case 8: job = "Công nhân";break;
      case 9: job = "Nông dân";break;
      case 10: job = "Khác";break;
    };
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: InformationCard(
            id: DanhSachModel.id,
            title: title,
            name: DanhSachModel.name,
            age: DanhSachModel.age,
            gender: gender,
            qualification: qualification,
            job: job,
            startColor: const Color(0xfffdfcfb),
            endColor: mThirdColor,
            Update: (){
              _showUpdateDialog(DanhSachModel,DanhSachModel.name,DanhSachModel.age.toString());
            },
            Delete: (){
              _showDeletelDialog(DanhSachModel.id);
            },
        ));
  }

  _showAddDialog(String _name, String _age, int gender, int qualification, int job) {
    GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
    var name = TextEditingController();
    var age = TextEditingController();
    name.text = _name;
    age.text= _age;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
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
                  "Thông tin thành viên",
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
                    children: [
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          const Text('Họ và tên: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width+10)/2,
                            child: TextFormField(
                              controller: name,
                              decoration: const InputDecoration(),
                              // Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập họ và tên';
                                }
                                else if(value.length <= 3){
                                  return 'Vui lòng nhập trên 3 kí tự';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ), //tên
                      Row(
                        children: [
                          const Text('Tuổi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 190,
                            child: TextFormField(
                              controller: age,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập tuổi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' tuổi', style: TextStyle(fontSize: mFontListTile)),
                        ],
                      ), //tuổi
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Giới tính:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: gender,
                                items: const [
                                  //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Chọn giới tính - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Nam"),
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Nữ"),
                                      value: 2
                                  )
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(name.text, age.text,gender,qualification,job);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Giới tính
                      const SizedBox(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Trình độ:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                alignment: AlignmentDirectional.topStart,
                                value: qualification,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Chọn trình độ - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Chưa qua đào tạo"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Đào tạo dưới 3 tháng")
                                  ),
                                  DropdownMenuItem(
                                      value: 3,
                                      child: Text("Sơ cấp")
                                  ),
                                  DropdownMenuItem(
                                      value: 4,
                                      child: Text("Trung cấp")
                                  ),
                                  DropdownMenuItem(
                                      value: 5,
                                      child: Text("Cao đẳng")
                                  ),
                                  DropdownMenuItem(
                                      value: 6,
                                      child: Text("Đại học")
                                  ),
                                  DropdownMenuItem(
                                      value: 7,
                                      child: Text("Thạc sỹ")
                                  ),
                                  DropdownMenuItem(
                                      value: 8,
                                      child: Text("Tiến sỹ")
                                  ),
                                  DropdownMenuItem(
                                      value: 9,
                                      child: Text("Trình độ khác")
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    qualification = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(name.text, age.text,gender,qualification,job);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //trình độ
                      const SizedBox(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Nghề nghiệp:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: job,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text("- - Nghề nghiệp - -"),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Thương gia"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Nhà báo")
                                  ),
                                  DropdownMenuItem(
                                      value: 3,
                                      child: Text("Giáo sư, giáo viên")
                                  ),
                                  DropdownMenuItem(
                                      value: 4,
                                      child: Text("Kiến trúc sư")
                                  ),DropdownMenuItem(
                                      value: 5,
                                      child: Text("Hưu trí")
                                  ),
                                  DropdownMenuItem(
                                      value: 6,
                                      child: Text("Học sinh, sinh viên")
                                  ),
                                  DropdownMenuItem(
                                      value: 7,
                                      child: Text("Công chức, viên chức")
                                  ),
                                  DropdownMenuItem(
                                      value: 8,
                                      child: Text("Công nhân")
                                  ),
                                  DropdownMenuItem(
                                      value: 9,
                                      child: Text("Nông dân")
                                  ),
                                  DropdownMenuItem(
                                      value: 10,
                                      child: Text("Khác")
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    job = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog(name.text, age.text,gender,qualification,job);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Nghề nghiệp
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      int age1 =int.parse(age.text);
                      setState(() {
                        if(gender == 0 || qualification == 0 || job == 0){
                          var gioitinh = gender ==0?", giới tính":"";
                          var trinhdo = qualification==0 ?", trình độ":"";
                          var congviec = job==0 ?", nghề nghiệp":"";
                          var value = "$gioitinh$trinhdo$congviec";
                          _showNotificationDialog(value.replaceFirst(RegExp(r','), ''));
                        }
                        else {
                          stt++;
                          DanhSachModel ifm = DanhSachModel(
                              id: stt,
                              stt: widget.stt_ho,
                              qualification: qualification,
                              age: age1,
                              name: name.text.toString(),
                              job: job,
                              gender: gender,
                              nguoi_kp: stt==1? 1 : 2,
                              huyen: widget.stt_ho.substring(0,3));
                          DBProvider.db.setInformation(ifm);
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

  _showUpdateDialog(DanhSachModel danhSachModel, String value_name, String value_age) {
    GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
    var _name = TextEditingController();
    var _age = TextEditingController();
    _name.text = value_name;
    _age.text = value_age;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
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
                  "Cập nhật thành viên",
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
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          const Text('Họ và tên: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width+10)/2,
                            child: TextFormField(
                              controller: _name,
                              decoration: const InputDecoration(),
                              // Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập họ và tên';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ), //tên
                      Row(
                        children: [
                          const Text('Tuổi: ', style: TextStyle(fontSize: mFontListTile),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            width: 190,
                            child: TextFormField(
                              controller: _age,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(),
                              keyboardType: TextInputType.number,// Only numbers can be entered
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Vui lòng nhập tuổi';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Text(' tuổi', style: TextStyle(fontSize: mFontListTile)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Giới tính:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: danhSachModel.gender,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Nam"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Nữ")
                                  )
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    danhSachModel.gender = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(danhSachModel,_name.text,_age.text);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Giới tính
                      const SizedBox(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Trình độ:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                alignment: AlignmentDirectional.topStart,
                                value: danhSachModel.qualification,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Chưa qua đào tạo"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Đào tạo dưới 3 tháng")
                                  ),
                                  DropdownMenuItem(
                                      value: 3,
                                      child: Text("Sơ cấp")
                                  ),
                                  DropdownMenuItem(
                                      value: 4,
                                      child: Text("Trung cấp")
                                  ),
                                  DropdownMenuItem(
                                      value: 5,
                                      child: Text("Cao đẳng")
                                  ),
                                  DropdownMenuItem(
                                      value: 6,
                                      child: Text("Đại học")
                                  ),
                                  DropdownMenuItem(
                                      value: 7,
                                      child: Text("Thạc sỹ")
                                  ),
                                  DropdownMenuItem(
                                      value: 8,
                                      child: Text("Tiến sỹ")
                                  ),
                                  DropdownMenuItem(
                                      value: 9,
                                      child: Text("Trình độ khác")
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    danhSachModel.qualification = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(danhSachModel,_name.text,_age.text);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //trình độ
                      const SizedBox(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Nghề nghiệp:",
                            style: TextStyle(
                                color: mDividerColor, fontSize: mFontListTile
                            ),),
                          const SizedBox(width: 10,),
                          Flexible(
                              fit: FlexFit.loose,
                              child: DropdownButton(
                                value: danhSachModel.job,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Thương gia"),
                                  ),
                                  DropdownMenuItem(
                                      value: 2,
                                      child: Text("Nhà báo")
                                  ),
                                  DropdownMenuItem(
                                      value: 3,
                                      child: Text("Giáo sư, giáo viên")
                                  ),
                                  DropdownMenuItem(
                                      value: 4,
                                      child: Text("Kiến trúc sư")
                                  ),DropdownMenuItem(
                                      value: 5,
                                      child: Text("Hưu trí")
                                  ),
                                  DropdownMenuItem(
                                      value: 6,
                                      child: Text("Học sinh, sinh viên")
                                  ),
                                  DropdownMenuItem(
                                      value: 7,
                                      child: Text("Công chức, viên chức")
                                  ),
                                  DropdownMenuItem(
                                      value: 8,
                                      child: Text("Công nhân")
                                  ),
                                  DropdownMenuItem(
                                      value: 9,
                                      child: Text("Nông dân")
                                  ),
                                  DropdownMenuItem(
                                      value: 10,
                                      child: Text("Khác")
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    danhSachModel.job = value!;
                                  });
                                  Navigator.of(context).pop();
                                  _showUpdateDialog(danhSachModel,_name.text,_age.text);
                                },
                                isExpanded: true,
                              ))
                        ],
                      ), //Nghề nghiệp
                      const SizedBox(
                        child: Padding(padding: const EdgeInsets.fromLTRB(0,0,0,20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        DanhSachModel ifm = DanhSachModel(
                            id: danhSachModel.id,
                            stt: widget.stt_ho,
                            qualification: danhSachModel.qualification,
                            age: int.parse(_age.text),
                            name: _name.text.toString(),
                            job: danhSachModel.job,
                            gender: danhSachModel.gender,
                            nguoi_kp: stt==1? 1 : 2, huyen: widget.stt_ho.substring(0,3));
                        DBProvider.db.updateInformation(ifm, danhSachModel.id,widget.stt_ho);
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
                  "Bạn có chắc muốn xóa thông tin thành viên này không?",
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
                        child: const Text('Đồng ý',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: 15)),
                        onPressed: () {
                          setState((){
                            DBProvider.db.deleteInformation(id,widget.stt_ho);
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                        }),
                  ])
            ],
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
                  "Chưa có thông tin thành viên trong hộ đi du lịch",
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