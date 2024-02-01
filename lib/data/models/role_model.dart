import 'package:equatable/equatable.dart';

class RoleModel extends Equatable {
  final String id;
  final String createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String roleName;
  final bool isAdmin;
  final bool isSuperadmin;

  RoleModel({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.roleName,
    required this.isAdmin,
    required this.isSuperadmin,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        roleName: json["role_name"],
        isAdmin: json["is_admin"],
        isSuperadmin: json["is_superadmin"],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        createdBy,
        updatedBy,
        deletedBy,
        createdAt,
        updatedAt,
        deletedAt,
        roleName,
        isAdmin,
        isSuperadmin,
      ];
}
