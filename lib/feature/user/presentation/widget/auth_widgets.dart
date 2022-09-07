import 'dart:async';

import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ConfirmationCodeTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController? controller;
  final String? errorText;
  final autoFocus;

  const ConfirmationCodeTextField({
    Key? key,
    required bool readOnly,
    this.controller,
    this.errorText,
    this.autoFocus = false,
  })  : readOnly = readOnly,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      readOnly: readOnly,
      keyboardType: TextInputType.number,
      autofocus: autoFocus,
      decoration: const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(errorText: errorText),
    );
  }
}

class LoginButton extends StatefulWidget {
  final VoidCallback? onPressed;

  LoginButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> with SingleTickerProviderStateMixin {
  final _animationDuration = const Duration(milliseconds: 150);
  late final _animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
    lowerBound: 0.95,
    upperBound: 1.0,
  );

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() {});
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
      child: AnimatedBuilder(
        animation: _animationController.view,
        builder: (context, child) {
          return Transform.scale(
            scale: _animationController.value,
            child: child,
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.height,
          height: 48.0,
          child: ElevatedButton(
            onPressed: widget.onPressed != null ? () {
              _onTap();
              widget.onPressed?.call();
            } : null,
            child: Text(context.strings.login),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    _decreaseButton();
    Timer(_animationDuration, () {
      _increaseButton();
    });
  }

  void _increaseButton() {
    _animationController.forward();
  }

  void _decreaseButton() {
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
