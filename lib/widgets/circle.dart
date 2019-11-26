import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final Color color;
  final double size;
  MyPainter(this.color, this.size);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    
    canvas.drawCircle(Offset(0.0, 0.0), this.size, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;

  // @override
  // bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}


class BarClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    double x = size.width;
    double y = size.height;
    double d = 10;
    
    path.lineTo(x, 0);
    path.lineTo(x, y);

    path.lineTo(x * 0.3 +d, y * 0.6);
    path.quadraticBezierTo(x * 0.2, y * 0.5, x * 0.1, y * 0.7);
    // path.lineTo(x * 0.2, y * 0.5);

    path.lineTo(0, y-d);
    path.close();
    return path;

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class MyClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path =Path();

    double x = size.width;
    double y = size.height;
    double d = 40;

    path.lineTo(x * 0.8, 0);
    path.lineTo(x-d, y*0.25-d);
    path.quadraticBezierTo(x, y*0.25, x-d, y*0.25+d);
    path.lineTo(x-d, y*0.25+d);
    path.lineTo(x*0.25+d, y-d);
    path.quadraticBezierTo(x*0.25, y, x*0.25-d, y-d);

    path.lineTo(0, y*0.7);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}


