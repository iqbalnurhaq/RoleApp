import 'package:equatable/equatable.dart';

class TokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;

  TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json["accesstoken"],
        refreshToken: json["refreshtoken"],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [accessToken, refreshToken];
}
