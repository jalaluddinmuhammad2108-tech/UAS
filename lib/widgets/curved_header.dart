import 'package:flutter/material.dart';

class CurvedHeader extends StatelessWidget {
  final String title;

  const CurvedHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CurveClipper(),
      child: Container(
        height: 210,
        color: Color(0xFF5C4DFF),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
