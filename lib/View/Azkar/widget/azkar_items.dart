// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:share_plus/share_plus.dart';

import 'package:muslim/Core/constant/themes.dart';

class AzkarItem extends StatefulWidget {
  final String zekr;
  final String hint;
  final int number;

  const AzkarItem({
    super.key,
    required this.zekr,
    required this.hint,
    required this.number,
  });

  @override
  State<AzkarItem> createState() => _AzkarItemState();
}

class _AzkarItemState extends State<AzkarItem> {
  late int currentNumber;

  @override
  void initState() {
    super.initState();
    currentNumber = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      children: [
        Card(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1.5),
            ),
            child: Column(
              children: [
                Text(
                  widget.zekr,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 2,
                    fontFamily: TextFontType.arefRuqaaFont,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(),
                Column(
                  children: [
                    Text(
                      widget.hint,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: TextFontType.arefRuqaaFont),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: widget.zekr));
                              },
                              icon: const Icon(Icons.copy)),
                          if (currentNumber == 0)
                            CircleAvatar(
                              radius: 15.r,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Icon(
                                Icons.check,
                              ),
                            )
                          else
                            CircleAvatar(
                              radius: 25.r,
                              backgroundColor: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.2),
                              child: InkWell(
                                  onTap: () {
                                    if (currentNumber > 0) {
                                      setState(() {
                                        currentNumber--;
                                        Vibrate.feedback(FeedbackType.success);
                                      });
                                    }
                                  },
                                  child: CustomPaint(
                                    size: Size(50.w, 50.h),
                                    painter: CirclePointer(
                                      primaryColor:
                                          Theme.of(context).primaryColor,
                                      animation: currentNumber / widget.number,
                                      text: currentNumber.toString(),
                                    ),
                                  )),
                            ),
                          IconButton(
                              onPressed: () {
                                Share.share(widget.zekr);
                              },
                              icon: const Icon(Icons.share)),
                        ]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CirclePointer extends CustomPainter {
  final double animation;
  final String text;
  final Color primaryColor;

  CirclePointer({
    required this.animation,
    required this.text,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;
    final radius = min(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = primaryColor // Use primary color here
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw the timer arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(center, center), radius: radius),
      -pi / 2,
      2 * pi * animation,
      false,
      paint,
    );

    // Draw the time text
    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: 15.0.sp,
      ),
      text: text,
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center - tp.width / 2, center - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
