import 'dart:async';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ripple_effect/src/ripple_effect_paint.dart';

class RippleEffect extends StatefulWidget {
  const RippleEffect({super.key,
    required this.parentKey,
    this.color = Colors.red,
    this.backDropFilter,
    this.child,
  });

  final GlobalKey parentKey;
  final Color color;
  final ui.ImageFilter? backDropFilter;
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

  final GlobalKey _key = GlobalKey();

  late GlobalKey _parentKey;
  late Color _color;
  late ui.ImageFilter _filter;
  Widget? _child;
  Size? _size;

  final double _centerRad = 0.5, _circlesRad = 1;
  final Duration _duration = const Duration(milliseconds: 2500);

  @override
  void initState() {
    super.initState();
    _parentKey = widget.parentKey;
    _color = widget.color;
    _filter = ui.ImageFilter.blur(sigmaX: 0, sigmaY: 0, tileMode: TileMode.clamp);
    _child = widget.child;
    firstRippleController = AnimationController(vsync: this, duration: _duration,);

    firstRippleRadiusAnimation = Tween<double>(begin: 0, end: _circlesRad).animate(
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

    secondRippleController = AnimationController(vsync: this, duration: _duration,);

    secondRippleRadiusAnimation = Tween<double>(begin: 0, end: _circlesRad).animate(
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

    thirdRippleController = AnimationController(vsync: this, duration: _duration);

    thirdRippleRadiusAnimation = Tween<double>(begin: 0, end: _circlesRad).animate(
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

    centerCircleController = AnimationController(vsync: this, duration: _duration*0.5);//const Duration(milliseconds: 1250));

    centerCircleRadiusAnimation = Tween<double>(begin: _centerRad*0.6, end: _centerRad).animate(
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

    centerCircleController.forward();
    firstRippleController.forward();
    Timer(
      const Duration(milliseconds: 765),
          () => secondRippleController.forward(),
    );

    Timer(
      const Duration(milliseconds: 1100),//1050
          () => thirdRippleController.forward(),
    );

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
    if(widget.parentKey != oldWidget.parentKey){
      _parentKey = widget.parentKey;
      final RenderBox parentRenderBox = _parentKey.currentContext?.findRenderObject() as RenderBox;
      _size = parentRenderBox.size;
    }
    if(widget.color != oldWidget.color){
      _color = widget.color;
    }
    if(widget.backDropFilter != oldWidget.backDropFilter && widget.backDropFilter != null){
      _filter = widget.backDropFilter!;
    }
    if(widget.child != oldWidget.child){
      _child = widget.child;
    }
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return _size == null ? SizedBox.shrink() : BackdropFilter(filter: _filter,
      child: SizedBox(
        //decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.transparent)),

        height: _size!.height, width: _size!.width,
        child: Center(
          child: CustomPaint(
            key: _key,
            size: _size!,
            painter: RippleEffectPaint(
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