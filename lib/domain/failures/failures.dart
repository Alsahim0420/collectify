sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super('Item no encontrado');
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.m = 'Error inesperado']);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
