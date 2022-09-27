import 'package:app_surtimasas/src/login/pages/register/client/products/list/client_products_list_page.dart';
import 'package:app_surtimasas/src/login/pages/register/client/update/client_update_page.dart';
import 'package:app_surtimasas/src/login/pages/register/manager/orders/list/categories/create/manager_categories_create_page.dart';
import 'package:app_surtimasas/src/login/pages/register/manager/orders/list/manager_orders_list_page.dart';
import 'package:app_surtimasas/src/login/pages/register/manager/orders/list/products/create/manager_products_create_page.dart';
import 'package:app_surtimasas/src/login/pages/register/register_page.dart';
import 'package:app_surtimasas/src/login/pages/register/roles/roles_page.dart';
import 'package:app_surtimasas/src/login/pages/register/seller/orders/list/seller_orders_list_page.dart';
import 'package:app_surtimasas/src/login/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_surtimasas/src/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() =>  _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'SURTIMASAS DE LA COSTA SDLC',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/products/list' : (BuildContext context) => ClientProductsListPage(),
        'client/update' : (BuildContext context) => ClientUpdatePage(),
        'manager/orders/list' : (BuildContext context) => ManagerOrdersListPage(),
        'manager/categories/create' : (BuildContext context) => ManagerCategoriesCreatePage(),
        'manager/products/create' : (BuildContext context) => ManagerProductsCreatePage(),
        'seller/orders/list' : (BuildContext context) => SellerOrdersListPage(),

      },

      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
        appBarTheme: AppBarTheme(elevation: 0)
      ),
    );
  }
}
