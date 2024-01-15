// ignore_for_file: prefer_const_constructors_in_immutables

part of 'generic_cubit.dart';

abstract class GenericState<T> extends Equatable {
  final T data;
  final bool changed;
  final String error;
  const GenericState(this.data, this.changed, this.error);
}

class GenericInitialState<T> extends GenericState<T> {
  GenericInitialState(T data) : super(data, false, "");

  @override
  List<Object> get props => [changed];
}


class GenericUpdateState<T> extends GenericState<T> {
  GenericUpdateState(T data, bool changed, String error) : super(data, changed, error);

  @override
  List<Object> get props => [changed];
}

class GenericFailedState<T> extends GenericState<T> {
  GenericFailedState(T data, bool changed, String error) : super(data, changed, error);

  @override
  List<Object> get props => [changed, error];
}


