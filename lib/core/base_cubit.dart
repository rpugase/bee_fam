import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/widget/error_dialog.dart';

abstract class BaseCubit<State extends BlocState> extends Cubit<State> {

  BaseCubit(State initialState) : super(initialState) {
    try {
      onInit();
    } on Exception catch(e) {
      addError(e);
    }
  }

  @protected
  void onInit() {/*NOP*/}

  @protected
  BlocError getErrorTemplate(Exception errorMessage);

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is Exception) {
      emit(getErrorTemplate(error) as State);
    }
    super.onError(error, stackTrace);
  }
}

class BaseBlocConsumer<B extends BlocBase<S>, S> extends BlocConsumer<B, S> {

  BaseBlocConsumer({
    required BlocWidgetBuilder<S> builder,
    BlocWidgetListener<S>? listener,
    bool handleBaseErrorMessage = true,
  }) : super(builder: builder, listener: (context, state) {
    if (handleBaseErrorMessage && state is BlocError) {
      showDialog(context: context, builder: (context) {
        return ErrorDialog(state.errorHandler.getErrorMessage(context, state.exception));
      });
    }
    listener?.call(context, state);
  });
}

abstract class ErrorHandler {
  String getErrorMessage(BuildContext context, Exception exception);
}

abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];
}

abstract class BlocError extends BlocState {
  final Exception exception;
  final ErrorHandler errorHandler;

  BlocError(this.exception, this.errorHandler);

  @override
  List<Object?> get props => [errorHandler];
}
