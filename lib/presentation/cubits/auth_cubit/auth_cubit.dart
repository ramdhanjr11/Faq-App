
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faq_app/domain/entities/user.dart';
import 'package:faq_app/domain/usecases/login_usecase.dart';
import 'package:faq_app/domain/usecases/logout_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  late User? _user;
  User? get user => _user;

  AuthCubit(this._loginUseCase, this._logoutUseCase) : super(AuthInitial());

  void login(String email, String password) async {
    emit(LoginLoading());

    final result = await _loginUseCase.execute(email, password);

    result.fold((failure) {
      emit(LoginError(message: failure.message));
    }, (userData) {
      _user = userData;
      emit(LoginSuccess(user: userData));
    });
  }

  void logout(String tokenType, String token) async {
    emit(LogoutLoading());

    final result = await _logoutUseCase.execute(tokenType, token);

    result.fold((failure) {
      emit(LogoutError(message: failure.message));
    }, (logoutMessage) {
      _user = null;
      emit(LogoutSuccess(message: logoutMessage));
    });
  }
}
