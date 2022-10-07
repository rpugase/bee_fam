abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseStream<Type, Params> {
  Stream<Type> call(Params params);
}


class NoParams {}
