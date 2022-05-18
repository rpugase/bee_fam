import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/widget/error_dialog.dart';

typedef BaseBlocWidgetListener<S> = bool Function(BuildContext context, S state);

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
  BlocError getErrorTemplate(Exception exception);

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is Exception) {
      emit(getErrorTemplate(error) as State);
    }
    super.onError(error, stackTrace);
  }

  @override
  void emit(State state) {
    print(state);
    super.emit(state);
  }
}

class BaseBlocConsumer<B extends BlocBase<S>, S> extends BlocConsumer<B, S> {

  BaseBlocConsumer({
    required BlocWidgetBuilder<S> builder,
    BaseBlocWidgetListener<S>? listener,
    bool handleBaseErrorMessage = true,
  }) : super(builder: builder, listener: (context, state) {
    if (listener?.call(context, state) == true && handleBaseErrorMessage && state is BlocError) {
      showDialog(context: context, builder: (context) {
        return ErrorDialog(state.errorHandler.getErrorMessage(context, state.exception));
      });
    }
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
  List<Object?> get props => [exception];
}
