import 'package:flutter/material.dart';
import 'package:roleapp/domain/usecases/login.dart';
import 'package:roleapp/shared/state_enum.dart';

class AuthNotifier extends ChangeNotifier {
  final Login login;
  AuthNotifier({
    required this.login,
  });

  // Login Field

  RequestState _loginState = RequestState.Empty;
  RequestState get loginState => _loginState;

  //Logged
  bool _logged = false;
  bool get logged => _logged;

  String _loginMessage = '';
  String get loginMessage => _loginMessage;

  Future<void> authLogin(Map<String, dynamic> body) async {
    _loginState = RequestState.Loading;
    notifyListeners();
    final result = await login.execute(body);

    await result.fold((failure) {
      _loginState = RequestState.Error;
      _loginMessage = failure.message;
      notifyListeners();
    }, (userData) {
      _loginState = RequestState.Loaded;
      _logged = true;
      notifyListeners();
    });
  }
}
