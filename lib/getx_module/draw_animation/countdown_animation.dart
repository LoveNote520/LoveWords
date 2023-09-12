import 'dart:async';
import 'package:flutter/material.dart';

class CountdownAnimation extends StatefulWidget {
  const CountdownAnimation({Key? key}) : super(key: key);

  @override
  State<CountdownAnimation> createState() => _CountdownAnimationState();
}

class _CountdownAnimationState extends State<CountdownAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  int _counter = 60;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    super.initState();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 404,
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(3.14 * _animation.value),
                  alignment: Alignment.bottomCenter,
                  child: child,
                );
              },
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                    color: const Color(0xffE8E9fd),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    border: Border.all(color: const Color(0xffccd8fc), width: 2)),
              ),
            ),
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                  color: const Color(0xffE8E9fd),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  border: Border.all(color: const Color(0xffccd8fc), width: 2)),
            ),
          ],
        ),
      ),
      Positioned(
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
              color: const Color(0xffE8E9fd),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              border: Border.all(color: const Color(0xffccd8fc), width: 2)),
        ),
      ),
      Positioned(
        top:50,
        left: 40,
        child: Text(
          "${_counter}",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 100),
        ),
      ),

    ]);
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_counter > 0) {
        _controller.reset();
        _controller.forward();
        setState(() {
          _counter--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }
}
