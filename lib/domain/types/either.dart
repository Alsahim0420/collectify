/// Tipo algebraico Either para representar éxito (Right) o error (Left).
/// Sustituye el uso de DartZ con una implementación propia mantenible.
sealed class Either<L, R> {
  const Either();

  /// Ejecuta [onLeft] si es Left, o [onRight] si es Right.
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);
}

final class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) =>
      onLeft(value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Left<L, R> && value == other.value);

  @override
  int get hashCode => Object.hash(0, value);
}

final class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) =>
      onRight(value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Right<L, R> && value == other.value);

  @override
  int get hashCode => Object.hash(1, value);
}
