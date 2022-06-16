import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/feature/user/presentation/auth_cubit.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:collection/collection.dart';
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

  void collect<T>(Stream<T> stream, Future onNext(T event), Future onError(Exception error)?) {
    stream.listen((event) {
      onNext(event).then((value) => null);
    }).onError((error) async {
      await onError?.call(error);
      addError(error);
    });
  }

  void launch(Future f(), Future onError(Exception error)?) {
    f.call().onError<Exception>((error, stacktrace) async {
      await onError?.call(error);
      addError(error);
    });
  }

  @protected
  void onInit() {/*NOP*/}

  @protected
  BlocError getErrorTemplate(Exception exception);

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is Exception) {
      emit(state..withError(error));
    }
    super.onError(error, stackTrace);
  }

  @override
  void emit(State state) {
    Log.i("Emit bloc state: $state");
    super.emit(state);
  }
}

class BaseBlocConsumer<B extends BlocBase<S>, S> extends BlocConsumer<B, S> {

  BaseBlocConsumer({
    required BuildContext context,
    required BlocWidgetBuilder<S> builder,
    BaseBlocWidgetListener<S>? listener,
    bool handleBaseErrorMessage = true,
  }) : super(builder: builder, listener: (context, state) {
    final cubit = (context.read<B>() as BaseCubit);
    final error = (state as BlocState).error;
    if (listener?.call(context, state) == true && handleBaseErrorMessage && error != null) {
      showDialog(context: context, builder: (context) {
        final errorTemplate = cubit.getErrorTemplate(error);
        return ErrorDialog(errorTemplate.errorHandler.getErrorMessage(context, errorTemplate.exception));
      });
    }
  });
}

abstract class ErrorHandler {

  static List<ErrorHandler> _errorHandlers = [];
  static String? _message = null;

  static void setDefaultErrorMessage(String message) {
    _message = message;
  }

  static void setErrorHandlers(Iterable<ErrorHandler> errorHandlers) {
    if (_errorHandlers.isNotEmpty) {
      throw Exception("You are shouldn't to init handlers twice");
    }
    _errorHandlers.addAll(errorHandlers);
  }

  String getErrorMessage(BuildContext context, Exception exception) {
    return _errorHandlers.firstWhereOrNull((handler) => handler.getErrorMessage(context, exception).isNotEmpty)
        ?.getErrorMessage(context, exception) ?? _message ?? context.strings.error_unknown;
  }
}

abstract class BlocState {

  Exception? _inError = null;
  Exception? get error => _inError;

  void withError(Exception? error) {
    this._inError = error;
  }
}

class UseContainsMethodException implements Exception {
  @override
  String toString() => "Use state.containsError for checking";
}

class BlocError extends Equatable implements Exception {
  final Exception exception;
  final ErrorHandler errorHandler;

  BlocError(this.exception, this.errorHandler);

  @override
  List<Object?> get props => [exception];
}
