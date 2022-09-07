import 'dart:async';

import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/material.dart';

class AnimatedClick extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final int animationDuration;
  final double lowerBound;
  final double upperBound;

  const AnimatedClick({
    Key? key,
    required this.child,
    this.onTap,
    this.animationDuration = 150,
    this.lowerBound = 0.95,
    this.upperBound = 1.0,
  }) : super(key: key);

  @override
  State<AnimatedClick> createState() => _AnimatedClickState();
}

class _AnimatedClickState extends State<AnimatedClick> with SingleTickerProviderStateMixin {
  late final _animationDuration = Duration(milliseconds: widget.animationDuration);
  late final _animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
    lowerBound: widget.lowerBound,
    upperBound: widget.upperBound,
  );

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() {});
    _increaseButton();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails tapUpDetails) {
        _increaseButton();
      },
      onTapDown: (TapDownDetails tapDownDetails) {
        _decreaseButton();
      },
      onTapCancel: () {
        _increaseButton();
      },
      onTap: () {
        _onTap();
        widget.onTap?.call();
      },
      child: AnimatedBuilder(
        animation: _animationController.view,
        builder: (context, child) {
          return Transform.scale(
            scale: _animationController.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }

  void _onTap() {
    Log.i("_onTap");
    _decreaseButton();
    Timer(_animationDuration, () {
      _increaseButton();
    });
  }

  void _increaseButton() {
    Log.i("_increaseButton");
    _animationController.forward();
  }

  void _decreaseButton() {
    Log.i("_decreaseButton");
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
