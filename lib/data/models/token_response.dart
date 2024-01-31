import 'package:equatable/equatable.dart';
import 'package:roleapp/data/models/token_model.dart';

class TokenResponse extends Equatable {
  final TokenModel token;

  TokenResponse({required this.token});

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      TokenResponse(token: TokenModel.fromJson(json["token"]));

  @override
  // TODO: implement props
  List<Object?> get props => [token];
}
