import 'package:equatable/equatable.dart';
import 'package:roleapp/data/models/token_model.dart';
import 'package:roleapp/data/models/token_response.dart';

class AuthResponse extends Equatable {
  final int code;
  final bool status;
  final String message;
  final TokenResponse data;

  AuthResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: TokenResponse.fromJson(json["data"]),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        code,
        status,
        message,
        data,
      ];
}
