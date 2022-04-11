import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<State extends BlocState> extends Cubit<State> {

  BaseCubit(State initialState) : super(initialState) {
    try {
      onInit();
    } on Exception catch(e) {
      addError(e);
    }
  }

  void onInit();

  BlocError getErrorTemplate(String errorMessage);

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(getErrorTemplate(error.toString()) as State);
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
    }
    listener?.call(context, state);
  });
}

abstract class BlocState extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];
}

abstract class BlocError extends BlocState {
  final String errorMessage;

  BlocError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
