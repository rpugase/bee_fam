import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberTextField extends StatelessWidget {
  final _readOnly;
  final TextEditingController? controller;
  final String? errorText;
  final autoFocus;

  PhoneNumberTextField({
    Key? key,
    required bool readOnly,
    this.controller,
    this.errorText,
    this.autoFocus = false,
  })  : _readOnly = readOnly,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      readOnly: _readOnly,
      keyboardType: TextInputType.phone,
      autofocus: autoFocus,
      inputFormatters: [
        MaskTextInputFormatter(
          mask: "+38 (###) ###-##-##",
          filter: {"#": RegExp(r'[0-9]')},
        )
      ],
      decoration: InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            errorText: errorText,
            hintText: "+38",
            hintStyle: Theme.of(context)
                .inputDecorationTheme
                .hintStyle!
                .copyWith(color: context.colors.textPrimary),
          ),
    );
  }
}

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

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;

  LoginButton(Key? key, VoidCallback? onPressed)
      : onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 44.0,
      child: ElevatedButton(
        child: Text(context.strings.login),
        onPressed: onPressed,
      ),
    );
  }
}
