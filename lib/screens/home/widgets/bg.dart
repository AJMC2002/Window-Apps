import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          _TaskListImg(),
          Flexible(
            child: Text(
              'На данный момент задачи отсутствуют',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskListImg extends StatefulWidget {
  const _TaskListImg({super.key});

  @override
  State<_TaskListImg> createState() => _TaskListImgState();
}

class _TaskListImgState extends State<_TaskListImg>
    with TickerProviderStateMixin {
  final double _size = 181;
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(() {})
      ..forward();
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));
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
      builder: ((context, child) => ClipPath(
            clipper: _BackgroundClipper(),
            child: Stack(
              children: [
                SvgPicture.asset('assets/todolist_background.svg'),
                Positioned(
                  top: _size,
                  child: SlideTransition(
                    position: _animation,
                    child: SvgPicture.asset('assets/todolist.svg'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height / 2);
    path.addArc(Rect.fromLTWH(0, 0, width, height), pi, -pi);
    path.lineTo(width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
