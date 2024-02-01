import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roleapp/data/models/auth_response.dart';
import 'package:roleapp/shared/failure.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(Map<String, dynamic> body);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.nashta.co.id/v3';

  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponse> login(Map<String, dynamic> body) async {
    var data = json.encode(body);

    final response = await client.post(
        Uri.parse('$BASE_URL/sysparam/auth/signin'),
        body: data,
        headers: {
          "Nashta-Api-Key": "RFT74DPVqBIPCDxj3XPsffY9UBk014bF",
          "Content-Type": "application/json"
        });

    if (response.statusCode == 201) {
      return AuthResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerFailure(json.decode(response.body)["message"]);
    }
  }
}
