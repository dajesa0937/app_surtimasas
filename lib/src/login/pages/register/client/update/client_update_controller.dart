import 'dart:convert';
import 'dart:io';

import 'package:app_surtimasas/src/login/models/response_api.dart';
import 'package:app_surtimasas/src/login/models/user.dart';
import 'package:app_surtimasas/src/login/provider/users_provider.dart';
import 'package:app_surtimasas/src/login/utils/my_snackbar.dart';
import 'package:app_surtimasas/src/login/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ClientUpdateController {
  BuildContext context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnable = true;
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));

    print('TOKEN ENVIADO: ${user.sessionToken}');
    
    usersProvider.init(context, sessionUser: user);

    nameController.text = user.name;
    lastnameController.text = user.lastname;
    phoneController.text = user.phone;

    refresh();
  }

  void update() async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Debes Ingresar Todos Los Campos');
      return;
    }

   // if (imageFile == null) {
     // MySnackbar.show(context, 'SELECCIONAR UNA IMAGEN');
      //return;
   // }

    _progressDialog.show(max: 100, msg: 'Cargando Datos...');
    isEnable = false;

    User myUser = new User(id: user.id, name: name, lastname: lastname, phone: phone, image: user.image);

    Stream stream = await usersProvider.update(myUser, imageFile);
    stream.listen((res) async {
      _progressDialog.close();

      // ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      // print('RESPUESTA: ${responseApi.toJson()}');

      Fluttertoast.showToast(msg: responseApi.message);

      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {

        user = await usersProvider.getById(myUser.id); // Obteniendo el usuario de la base de datos
        _sharedPref.save('user', user.toJson());
        // Future.delayed(Duration(seconds: 3), () {
        // Navigator.pushReplacementNamed(context, 'login'););
        Navigator.pushNamedAndRemoveUntil(
            context, 'client/products/list', (route) => false);
      } else {
        isEnable = true;
      }
    });
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALLERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA'));
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona Tu Imagen'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context);
  }
}
