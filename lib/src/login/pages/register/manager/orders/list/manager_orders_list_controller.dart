import 'package:app_surtimasas/src/login/models/user.dart';
import 'package:app_surtimasas/src/login/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagerOrdersListPageController {
  BuildContext context;

  SharedPref _sharedPref = new SharedPref();

  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Function refresh;
  User user;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void goToCategoryCreate(){
    Navigator.pushNamed(context, 'manager/categories/create');
  }

  void goToProductCreate(){
    Navigator.pushNamed(context, 'manager/products/create');
  }


  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}
