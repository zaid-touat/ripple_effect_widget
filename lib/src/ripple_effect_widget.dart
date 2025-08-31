import 'dart:async';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ripple_effect/src/ripple_effect_paint.dart';

class RippleEffect extends StatefulWidget {
  const RippleEffect({super.key,
    this.color = Colors.red,
    required this.parentKey,
    this.child,
  });

  final Color color;
  final GlobalKey parentKey;
  final Widget? child;

  @override
  State<RippleEffect> createState() => _RippleEffectState();
}

class _RippleEffectState extends State<RippleEffect> with TickerProviderStateMixin {
  late AnimationController firstRippleController;
  late AnimationController secondRippleController;
  late AnimationController thirdRippleController;
  late AnimationController centerCircleController;
  late Animation<double> firstRippleRadiusAnimation;
  late Animation<double> firstRippleOpacityAnimation;
  late Animation<double> firstRippleWidthAnimation;
  late Animation<double> secondRippleRadiusAnimation;
  late Animation<double> secondRippleOpacityAnimation;
  late Animation<double> secondRippleWidthAnimation;
  late Animation<double> thirdRippleRadiusAnimation;
  late Animation<double> thirdRippleOpacityAnimation;
  late Animation<double> thirdRippleWidthAnimation;
  late Animation<double> centerCircleRadiusAnimation;

  Size? _size;

  @override
  void initState() {
    super.initState();
    firstRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    firstRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          firstRippleController.forward();
        }
      });

    firstRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
          () {
        setState(() {});
      },
    );

    firstRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
          () {
        setState(() {});
      },
    );

    secondRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    secondRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          secondRippleController.forward();
        }
      });

    secondRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
          () {
        setState(() {});
      },
    );

    secondRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
          () {
        setState(() {});
      },
    );

    thirdRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    thirdRippleRadiusAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          thirdRippleController.forward();
        }
      });

    thirdRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
          () {
        setState(() {});
      },
    );

    thirdRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
          () {
        setState(() {});
      },
    );

    centerCircleController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    centerCircleRadiusAnimation = Tween<double>(begin: 35, end: 50).animate(
      CurvedAnimation(
        parent: centerCircleController,
        curve: Curves.fastOutSlowIn,
      ),
    )
      ..addListener(
            () {
          setState(() {});
        },
      )
      ..addStatusListener(
            (status) {
          if (status == AnimationStatus.completed) {
            centerCircleController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            centerCircleController.forward();
          }
        },
      );

    firstRippleController.forward();
    Timer(
      const Duration(milliseconds: 765),
          () => secondRippleController.forward(),
    );

    Timer(
      const Duration(milliseconds: 1050),
          () => thirdRippleController.forward(),
    );

    centerCircleController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_){
      final RenderBox parentRenderBox = widget.parentKey.currentContext?.findRenderObject() as RenderBox;
      _size = parentRenderBox.size;
      setState(() {});
    });

  }

  @override
  void dispose() {
    firstRippleController.dispose();
    secondRippleController.dispose();
    thirdRippleController.dispose();
    centerCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return _size == null ? SizedBox.shrink() : BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2, tileMode: TileMode.clamp),
      child: SizedBox(height: _size!.height*0.5, width: _size!.width,
        child: Center(
          child: CustomPaint(
            painter: MyPainter(
              widget.color,
              firstRippleRadiusAnimation.value,
              firstRippleOpacityAnimation.value,
              firstRippleWidthAnimation.value,
              secondRippleRadiusAnimation.value,
              secondRippleOpacityAnimation.value,
              secondRippleWidthAnimation.value,
              thirdRippleRadiusAnimation.value,
              thirdRippleOpacityAnimation.value,
              thirdRippleWidthAnimation.value,
              centerCircleRadiusAnimation.value,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}