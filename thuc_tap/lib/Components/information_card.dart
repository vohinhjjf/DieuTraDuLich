import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap/constant.dart';
import 'dart:ui' as ui;

class InformationCard extends StatelessWidget {
  final int id;
  late String title;
  final String name;
  final int age;
  late final String gender;
  late final String qualification;
  late final String job;
  final Color startColor;
  final Color endColor;
  final double _borderRadius = 24;
  final VoidCallback? Update;
  final VoidCallback? Delete;

   InformationCard(
      {Key? key,
        required this.id,
        required this.title,
        required this.name,
        required this.age,
        required this.gender,
        required this.qualification,
        required this.job,
        required this.endColor,
        required this.startColor,
        required this.Update,
        required this.Delete
      }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 10),
        child: GestureDetector(
          onTap: Update,
          child: Stack(
            children: <Widget>[
              Container(
                height: 150,
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
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              "Họ và tên: $name",
                              style: TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w400,
                              ),
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
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                 Text(
                                   "$age tuổi",
                                  style: TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                const Text("Giới tính: ",
                                  style: TextStyle(
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text(gender,
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
                                const Text(
                                  "Trình độ: ",
                                  style: TextStyle(
                                      color: mDividerColor,
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  qualification,
                                  style: const TextStyle(
                                      color: mDividerColor,
                                      fontSize: mFontListTile,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Nghề nghiệp: $job",
                            style: TextStyle(
                                fontSize: mFontListTile,
                                fontWeight: FontWeight.w400
                            ),
                          )
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