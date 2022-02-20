import 'package:country_picker/country_picker.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberTextField extends StatefulWidget {
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
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  String phoneCode = "380";
  String countryCode = "UA";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.phone, color: context.colors.textPrimary),
        SizedBox(width: 14),
        GestureDetector(
          onTap: () => showCountryPicker(
            context: context,
            showPhoneCode: true,
            onSelect: (Country country) {
              setState(() {
                phoneCode = country.phoneCode;
                countryCode = country.countryCode;
                widget.controller?.text = "+$phoneCode";
                print(country.e164Key);
              });
            },
          ),
          child: Container(
            width: 70,
            height: 56,
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.border),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Center(
              child: Text(
                getCountryEmoji(countryCode),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: widget.controller,
            maxLines: 1,
            readOnly: widget._readOnly,
            keyboardType: TextInputType.phone,
            autofocus: widget.autoFocus,
            inputFormatters: [
              MaskTextInputFormatter(
                mask: "+$phoneCode (##) ###-##-##",
                filter: {"#": RegExp(r'[0-9]')},
              )
            ],
            decoration: InputDecoration().applyDefaults(Theme.of(context).inputDecorationTheme).copyWith(
                  errorText: widget.errorText,
                  hintText: "+$phoneCode",
                  hintStyle:
                      Theme.of(context).inputDecorationTheme.hintStyle!.copyWith(color: context.colors.textPrimary),
                ),
          ),
        ),
      ],
    );
  }

  String getCountryEmoji(String countryCode) {
    return countryCode
        .toUpperCase()
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }
}
