import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'api_key_state.dart';

class ApiKeyCubit extends Cubit<ApiKeyState> {
  ApiKeyCubit() : super(const ApiKeyInitial());

  void onUpdateKey(String key){
    emit(ApiKeyUpdate(key));
  }

}
