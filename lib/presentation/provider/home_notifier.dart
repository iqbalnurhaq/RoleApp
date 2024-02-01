import 'package:flutter/material.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/domain/usecases/add_role.dart';
import 'package:roleapp/domain/usecases/get_all_role.dart';
import 'package:roleapp/shared/state_enum.dart';

class HomeNotifier extends ChangeNotifier {
  final GetAllRole getAllRole;
  final AddRole addRole;
  HomeNotifier({
    required this.getAllRole,
    required this.addRole,
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
}
