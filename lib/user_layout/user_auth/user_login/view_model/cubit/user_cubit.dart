import 'package:bloc/bloc.dart';

part 'user_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginState());

  toggleShowPassword() {
    emit(state.copyWith(userPasswordIsSecure: !state.userPasswordIsSecure));
  }

  toggleRememberME() {
    emit(state.copyWith(userRememberMe: !state.userRememberMe));
  }
}
