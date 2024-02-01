import 'package:flutter/material.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/domain/usecases/add_role.dart';
import 'package:roleapp/domain/usecases/delete_role.dart';
import 'package:roleapp/domain/usecases/edit_role.dart';
import 'package:roleapp/domain/usecases/get_all_role.dart';
import 'package:roleapp/shared/state_enum.dart';

class HomeNotifier extends ChangeNotifier {
  final GetAllRole getAllRole;
  final AddRole addRole;
  final EditRole editRole;
  final DeleteRole deleteRole;
  HomeNotifier({
    required this.getAllRole,
    required this.addRole,
    required this.editRole,
    required this.deleteRole,
  });

  // get all role state
  var _allRole = <RoleModel>[];
  List<RoleModel> get allRole => _allRole;

  RequestState _getAllRoleState = RequestState.Empty;
  RequestState get getAllRoleState => _getAllRoleState;

  String _getAllRoleMessage = '';
  String get getAllRoleMessage => _getAllRoleMessage;

  // add  role state
  RequestState _addRoleState = RequestState.Empty;
  RequestState get addRoleState => _addRoleState;

  String _addRoleMessage = '';
  String get addRoleMessage => _addRoleMessage;

  bool _getAddRole = false;
  bool get getAddRole => _getAddRole;

  // delete  role state
  RequestState _deleteRoleState = RequestState.Empty;
  RequestState get deleteRoleState => _deleteRoleState;

  String _deleteRoleMessage = '';
  String get deleteRoleMessage => _deleteRoleMessage;

  bool _deleteRole = false;
  bool get getDeleteRole => _deleteRole;

  // add  role state
  RequestState _editRoleState = RequestState.Empty;
  RequestState get editRoleState => _editRoleState;

  String _editRoleMessage = '';
  String get editRoleMessage => _editRoleMessage;

  bool _getEditRole = false;
  bool get getEditRole => _getEditRole;

  Future<void> fetchAllRole() async {
    _getAllRoleState = RequestState.Loading;
    notifyListeners();
    final result = await getAllRole.execute();

    await result.fold((failure) {
      _getAllRoleState = RequestState.Error;
      _getAllRoleMessage = failure.message;
      notifyListeners();
    }, (roleData) {
      _allRole = roleData;
      _getAllRoleState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> postAddRole(Map<String, dynamic> body) async {
    _addRoleState = RequestState.Loading;
    notifyListeners();
    final result = await addRole.execute(body);

    await result.fold((failure) {
      _getAddRole = false;
      _addRoleState = RequestState.Error;
      _addRoleMessage = failure.message;
      notifyListeners();
    }, (roleData) {
      _getAddRole = true;
      _addRoleState = RequestState.Loaded;
      notifyListeners();
      fetchAllRole();
    });
  }

  Future<void> putEditRole(Map<String, dynamic> body, String id) async {
    _editRoleState = RequestState.Loading;
    notifyListeners();
    final result = await editRole.execute(body, id);

    await result.fold((failure) {
      _getEditRole = false;
      _editRoleState = RequestState.Error;
      _editRoleMessage = failure.message;
      notifyListeners();
    }, (roleData) {
      _getEditRole = true;
      _editRoleState = RequestState.Loaded;
      notifyListeners();
      fetchAllRole();
    });
  }

  Future<void> patchDeleteRole(String id) async {
    _deleteRoleState = RequestState.Loading;
    notifyListeners();
    final result = await deleteRole.execute(id);

    await result.fold((failure) {
      _deleteRole = false;
      _deleteRoleState = RequestState.Error;
      _deleteRoleMessage = failure.message;
      notifyListeners();
    }, (roleData) {
      _deleteRole = true;
      _deleteRoleState = RequestState.Loaded;
      notifyListeners();
      fetchAllRole();
    });
  }
}
