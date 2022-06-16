import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/feature/user/domain/exception/user_exceptions.dart';
import 'package:birthday_gift/main_page.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/resources/images.dart';
import 'package:birthday_gift/core/ui/widget/phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'widget/auth_widgets.dart';

import '../di/user_di.dart';
import 'auth_cubit.dart';

class AuthPage extends StatelessWidget {
  final _phoneNumberController = TextEditingController();
  final _confirmationCodeController = TextEditingController();

  final _phoneNumberKey = UniqueKey();
  final _codeConfirmationKey = UniqueKey();
  final _buttonLoginKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(Images.bgLoginPng, fit: BoxFit.fill, width: MediaQuery.of(context).size.width),
            KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                final screenSize = MediaQuery.of(context).size.height;
                final paddingBottom = isKeyboardVisible ? .0 : screenSize / 4.5;
                return AnimatedContainer(
                  curve: Curves.easeOut,
                  duration: Duration(milliseconds: 400),
                  child: Column(
                    children: [
                      Expanded(child: SizedBox()),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text(
                              '${context.strings.enter_your_phone_number}:',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(height: 20.0),
                            BaseBlocConsumer<AuthCubit, AuthState>(
                              context: context,
                              listener: (ctx, state) {
                                if (state is SuccessCode) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (ctx) => MainPage()),
                                    (route) => false,
                                  );
                                }
                                return !(state is SuccessCode || state.error is UserException);
                              },
                              builder: (ctx, state) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: state is EnterPhoneNumber
                                      ? _onEnterPhoneNumber(ctx, state)
                                      : state is LoadingPhoneNumber
                                          ? _onLoadingPhoneNumber(ctx, state)
                                          : state is EnterCode
                                              ? _onEnterPhoneCode(ctx, state)
                                              : state is LoadingConfirmationCode
                                                  ? _onLoadingConfirmationCode(ctx, state)
                                                  : [],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: paddingBottom),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(BuildContext context, Exception exception) {
    return context.read<AuthCubit>().getErrorTemplate(exception).errorHandler.getErrorMessage(context, exception);
  }

  List<Widget> _onEnterPhoneNumber(BuildContext ctx, AuthState state) => [
        PhoneNumberTextField(
          key: _phoneNumberKey,
          readOnly: false,
          controller: _phoneNumberController,
          errorText: state.error is UserException ? _getErrorMessage(ctx, state.error!) : null,
          autoFocus: true,
        ),
        SizedBox(height: 20),
        LoginButton(
          key: _buttonLoginKey,
          onPressed: _onAuthPressedCallback(ctx, state, true),
        ),
      ];

  List<Widget> _onLoadingPhoneNumber(BuildContext ctx, AuthState state) => [
        PhoneNumberTextField(
          key: _phoneNumberKey,
          readOnly: true,
          controller: _phoneNumberController,
        ),
        SizedBox(height: 20),
        CircularProgressIndicator(),
      ];

  List<Widget> _onEnterPhoneCode(BuildContext ctx, AuthState state) => [
        PhoneNumberTextField(
          key: _phoneNumberKey,
          readOnly: true,
          controller: _phoneNumberController,
        ),
        SizedBox(height: 8),
        ConfirmationCodeTextField(
          key: _codeConfirmationKey,
          readOnly: false,
          controller: _confirmationCodeController,
          errorText: state.error is UserException ? _getErrorMessage(ctx, state.error!) : null,
          autoFocus: true,
        ),
        SizedBox(height: 20),
        LoginButton(
          key: _buttonLoginKey,
          onPressed: _onAuthPressedCallback(ctx, state, true),
        ),
      ];

  List<Widget> _onLoadingConfirmationCode(BuildContext ctx, AuthState state) => [
        PhoneNumberTextField(
          key: _phoneNumberKey,
          readOnly: true,
          controller: _phoneNumberController,
        ),
        SizedBox(height: 8),
        ConfirmationCodeTextField(
          key: _codeConfirmationKey,
          readOnly: true,
          controller: _confirmationCodeController,
        ),
        SizedBox(height: 20),
        CircularProgressIndicator(),
      ];

  VoidCallback? _onAuthPressedCallback(BuildContext ctx, AuthState state, bool enable) {
    return !enable
        ? null
        : () => ctx
            .read<AuthCubit>()
            .onAuth(state is EnterPhoneNumber ? _phoneNumberController.text : _confirmationCodeController.text);
  }
}
