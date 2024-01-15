part of 'api_key_cubit.dart';

abstract class ApiKeyState extends Equatable {
  final String key ;
  const ApiKeyState(this.key);
}

class ApiKeyInitial extends ApiKeyState {
  const ApiKeyInitial() : super('');

  @override
  List<Object> get props => [key];
}

class ApiKeyUpdate extends ApiKeyState {
  const ApiKeyUpdate(String key): super(key);
  @override
  List<Object> get props => [key];
}