import 'package:equatable/equatable.dart';
import 'package:roleapp/data/models/role_model.dart';

class RoleResponse extends Equatable {
  final int code;
  final bool status;
  final String message;
  final List<RoleModel> data;

  RoleResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory RoleResponse.fromJson(Map<String, dynamic> json) => RoleResponse(
      code: json["code"],
      status: json["status"],
      message: json["message"],
      data: List<RoleModel>.from(
          (json["data"] as List).map((x) => RoleModel.fromJson(x))));

  @override
  List<Object?> get props => [
        code,
        status,
        message,
        data,
      ];
}

class AddRoleResponse extends Equatable {
  final int code;
  final bool status;
  final String message;
  final RoleModel data;

  AddRoleResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddRoleResponse.fromJson(Map<String, dynamic> json) =>
      AddRoleResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: RoleModel.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [
        code,
        status,
        message,
        data,
      ];
}
