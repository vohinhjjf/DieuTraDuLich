import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/constant.dart';
import 'dart:ui' as ui;

class ExpenseCard extends StatelessWidget {
  final String location;
  final String matinh;
  final String money_one_people;
  final String money_tour;
  final String money_total;
  final Color startColor;
  final Color endColor;
  final double _borderRadius = 24;
  //final dynamic dialog;

  const ExpenseCard(
      {Key? key,
        required this.location,
        required this.matinh,
        required this.money_one_people,
        required this.money_tour,
        required this.money_total,
        required this.endColor,
        required this.startColor,
        //required this.dialog
      }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  borderRadius: BorderRadius.circular(_borderRadius),
                  gradient: LinearGradient(
                      colors: [startColor, endColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                      color: endColor,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: CustomPaint(
                  size: const Size(100, 100),
                  painter: CustomCardShapePainter(
                      _borderRadius, startColor, endColor),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 0,
                                child: Text(
                                  "Nơi đến: "+location,
                                  style: const TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    "Mã tỉnh: "+matinh,
                                    style: const TextStyle(
                                        fontSize: mFontListTile,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              IconButton(
                                  onPressed: (){

                                  },
                                  icon: Icon(Icons.edit,color: mPrimaryColor,size: mFontListTile,))
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Số tiền bình quân 1 người: "+money_one_people,
                            style: const TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Các khoản mục: "+money_tour,
                            style: const TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Tổng chi tiêu ngoài tour: "+ money_total,
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