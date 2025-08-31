import 'dart:async';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ripple_effect/src/ripple_effect_paint.dart';

class RippleEffect extends StatefulWidget {
  const RippleEffect({super.key,
    required this.parentKe,
    this.colo = Colors.red,
    this.backDropFilter,
    this.chil,
  });

  final GlobalKey parentKe;
  final Color colo;
  final ui.ImageFilter? backDropFilter;
  final Widget? chil;

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


  late GlobalKey _parentKey;
  late Color _color;
  late ui.ImageFilter _filter;
  Widget? _child;
  Size? _size;

  @override
  void initState() {
    super.initState();
    _parentKey = widget.parentKe;
    _color = widget.colo;
    _filter = ui.ImageFilter.blur(sigmaX: 0, sigmaY: 0, tileMode: TileMode.clamp);
    _child = widget.chil;
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
      final RenderBox parentRenderBox = _parentKey.currentContext?.findRenderObject() as RenderBox;
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
  void didUpdateWidget(covariant RippleEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.parentKe != oldWidget.parentKe){
      _parentKey = widget.parentKe;
      final RenderBox parentRenderBox = _parentKey.currentContext?.findRenderObject() as RenderBox;
      _size = parentRenderBox.size;
    }
    if(widget.colo != oldWidget.colo){
      _color = widget.colo;
    }
    if(widget.backDropFilter != oldWidget.backDropFilter && widget.backDropFilter != null){
      _filter = widget.backDropFilter!;
    }
    if(widget.chil != oldWidget.chil){
      _child = widget.chil;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return _size == null ? SizedBox.shrink() : BackdropFilter(filter: _filter,
      child: SizedBox(height: _size!.height, width: _size!.width,
        child: Center(
          child: CustomPaint(
            size: _size!,
            painter: MyPainter(
              _color,
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
            child: _child,
          ),
        ),
      ),
    );
  }
}