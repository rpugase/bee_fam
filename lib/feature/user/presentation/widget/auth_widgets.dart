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

  ConfirmationCodeTextField({
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
      decoration: InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(errorText: errorText),
    );
  }
}

class LoginButton extends StatefulWidget {
  final VoidCallback? onPressed;

  LoginButton(Key? key, VoidCallback? onPressed)
      : onPressed = onPressed,
        super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  late Timer _timer;
  final _animationDuration = Duration(milliseconds: 150);
  double _increaseCoefficient = 1.0;
  late double _width;
  late double _height;

  void _increaseButton() {
    setState(() {
      _increaseCoefficient = 1.0;
    });
  }

  void _decreaseButton() {
    setState(() {
      _increaseCoefficient = 0.98;
    });
  }

  void _onTap() {
    _decreaseButton();
    _timer = Timer(_animationDuration, () {
      _increaseButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width * _increaseCoefficient;
    _height = 48.0 * _increaseCoefficient;
    return GestureDetector(
      onTapUp: (TapUpDetails tapUpDetails) {
        _increaseButton();
      },
      onTapDown: (TapDownDetails tapDownDetails) {
        _decreaseButton();
      },
      child: AnimatedContainer(
        duration: _animationDuration,
        width: _width,
        height: _height,
        padding: EdgeInsets.symmetric(
          vertical: 48.0 - _height,
          horizontal: MediaQuery.of(context).size.width - _width,
        ),
        child: ElevatedButton(
          child: Text(context.strings.login),
          onPressed: () {
            _onTap();
            widget.onPressed?.call();
          },
        ),
      ),
    );
  }
}
