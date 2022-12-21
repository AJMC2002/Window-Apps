import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../assets/assets.dart';

class EmptyTaskListBackground extends StatelessWidget {
  const EmptyTaskListBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          _EmptyTaskListBackgroundImg(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'На данный момент\nзадачи отсутствуют',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyTaskListBackgroundImg extends StatefulWidget {
  const _EmptyTaskListBackgroundImg();

  @override
  State<_EmptyTaskListBackgroundImg> createState() =>
      _EmptyTaskListBackgroundImgState();
}

class _EmptyTaskListBackgroundImgState
    extends State<_EmptyTaskListBackgroundImg> with TickerProviderStateMixin {
  static const _size = 181.0;
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..forward();
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => ClipPath(
        clipper: _BackgroundClipper(),
        child: Stack(
          children: [
            SvgPicture.asset(Assets.todolistBackground),
            Positioned(
              top: _size,
              child: SlideTransition(
                position: _animation,
                child: SvgPicture.asset(Assets.todolist),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    final path = Path();
    path.lineTo(0, height / 2);
    path.addArc(Rect.fromLTWH(0, 0, width, height), pi, -pi);
    path.lineTo(width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
