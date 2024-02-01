import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:roleapp/data/models/auth_response.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/data/models/role_reponse.dart';
import 'package:roleapp/shared/failure.dart';
import 'package:roleapp/shared/shared_preference.dart';

abstract class RoleRemoteDataSource {
  Future<List<RoleModel>> getAllRole();
}

class RoleRemoteDataSourceImpl implements RoleRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.nashta.co.id/v3';

  final http.Client client;

  SharedPref sharedPref = SharedPref();

  RoleRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RoleModel>> getAllRole() async {
    String token = await sharedPref.readString("token");
    final response = await client.get(
        Uri.parse(
            '$BASE_URL/sysparam/role-primaries/get-all?page_size=10000&page=1'),
        headers: {
          "Nashta-Api-Key": "RFT74DPVqBIPCDxj3XPsffY9UBk014bF",
          "Authorization": token,
          "Content-Type": "application/json"
        });

    if (response.statusCode == 200) {
      return RoleResponse.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerFailure(json.decode(response.body)["message"]);
    }
  }
}
