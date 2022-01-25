import 'package:birthday_gift/auth/di/auth_di.dart';
import 'package:birthday_gift/auth/presentation/auth_cubit.dart';
import 'package:birthday_gift/person/presentation/person/list/person_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget/auth_widgets.dart';

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
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (ctx, state) {
            if (state is SuccessCode) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => PersonListPage()),
                (route) => false,
              );
            }
          },
          builder: (ctx, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state is EnterPhoneNumber ? _onEnterPhoneNumber(ctx, state) :
                state is ErrorOnEnterPhoneNumber ? _onEnterPhoneNumber(ctx, state, state.error) :
                state is LoadingPhoneNumber ? _onLoadingPhoneNumber(ctx, state) :
                state is EnterCode ? _onEnterPhoneCode(ctx, state) :
                state is ErrorOnEnterCodeNumber ? _onEnterPhoneCode(ctx, state, state.error) :
                state is LoadingConfirmationCode ? _onLoadingConfirmationCode(ctx, state) : [],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _onEnterPhoneNumber(BuildContext ctx, AuthState state,
          [String? errorText]) =>
      [
        PhoneNumberTextField(
          key: _phoneNumberKey,
          readOnly: false,
          controller: _phoneNumberController,
          errorText: errorText,
          autoFocus: true,
        ),
        SizedBox(height: 16),
        LoginButton(_buttonLoginKey, _onAuthPressedCallback(ctx, state, true)),
      ];

  List<Widget> _onLoadingPhoneNumber(BuildContext ctx, AuthState state) => [
        PhoneNumberTextField(
          key: _phoneNumberKey,
          readOnly: false,
          controller: _phoneNumberController,
        ),
        SizedBox(height: 16),
        LoginButton(_buttonLoginKey, _onAuthPressedCallback(ctx, state, false)),
      ];

  List<Widget> _onEnterPhoneCode(BuildContext ctx, AuthState state,
          [String? errorText]) =>
      [
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
          errorText: errorText,
          autoFocus: true,
        ),
        SizedBox(height: 16),
        LoginButton(_buttonLoginKey, _onAuthPressedCallback(ctx, state, true)),
      ];

  List<Widget> _onLoadingConfirmationCode(BuildContext ctx, AuthState state) =>
      [
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
        SizedBox(height: 16),
        LoginButton(_buttonLoginKey, _onAuthPressedCallback(ctx, state, false)),
      ];

  VoidCallback? _onAuthPressedCallback(
      BuildContext ctx, AuthState state, bool enable) {
    return !enable
        ? null
        : () => BlocProvider.of<AuthCubit>(ctx).onAuth(
            state is EnterPhoneNumber || state is ErrorOnEnterPhoneNumber
                ? _phoneNumberController.text
                : _confirmationCodeController.text);
  }
}
