import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/constant.dart';
import 'dart:ui' as ui;

import '../Database/database.dart';

class TourCard extends StatelessWidget {
  late String noiden = '';
  final String matinh;
  final String ngay;
  final String dem;
  final String dropdown_time;
  final String dropdown_coso;
  final String dropdown_vehicle;
  final Color startColor;
  final Color endColor;
  final double _borderRadius = 24;
  final VoidCallback? Update;
  final VoidCallback? Delete;

   TourCard(
      {Key? key,
        required this.matinh,
        required this.ngay,
        required this.dem,
        required this.dropdown_time,
        required this.dropdown_coso,
        required this.dropdown_vehicle,
        required this.endColor,
        required this.startColor,
        required this.Update,
        required this.Delete
      }):super(key: key);

  @override
  Widget build(BuildContext context) {
    DBProvider.db.queryTinh(matinh).then((value) => {
      noiden = value
    });
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: GestureDetector(
          onTap: Update,
          child: Stack(
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  gradient: LinearGradient(
                      colors: [startColor, endColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                      color: endColor,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                left: 15,
                top: 20,
                bottom: 20,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                              future: DBProvider.db.queryTinh(matinh),
                              builder: (context ,AsyncSnapshot<String> snapshot){
                                if(snapshot.hasData){
                                  return Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                        fontSize: mFontSize,
                                        fontWeight: FontWeight.w500),
                                  );
                                }
                                else if(snapshot.hasError){
                                  return const Text('');
                                }
                                return Container();
                              }
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                "Thời gian đi: ",
                                style: TextStyle(
                                    fontSize: mFontListTile,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Text(
                                dropdown_time,
                                style: const TextStyle(
                                    fontSize: mFontListTile,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Thời gian chuyến đi: $ngay ngày $dem đêm",
                            style: const TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                "Phương tiện: ",
                                style: TextStyle(
                                    color: mDividerColor,
                                    fontSize: mFontListTile,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                dropdown_vehicle,
                                style: const TextStyle(
                                    color: mDividerColor,
                                    fontSize: mFontListTile,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Loại cs lưu trú: $dropdown_coso",
                            style: const TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w400
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
                    child: IconButton(
                      icon: const Icon(Icons.close,color: mCloseColor,size: 20,),
                      onPressed: Delete,
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}