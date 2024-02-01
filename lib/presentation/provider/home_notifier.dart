import 'package:flutter/material.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/domain/usecases/get_all_role.dart';
import 'package:roleapp/shared/state_enum.dart';

class HomeNotifier extends ChangeNotifier {
  final GetAllRole getAllRole;
  HomeNotifier({
    required this.getAllRole,
  });

  // get all role state
  var _allRole = <RoleModel>[];
  List<RoleModel> get allRole => _allRole;

  RequestState _getAllRoleState = RequestState.Empty;
  RequestState get getAllRoleState => _getAllRoleState;

  String _getAllRoleMessage = '';
  String get getAllRoleMessage => _getAllRoleMessage;

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
}
