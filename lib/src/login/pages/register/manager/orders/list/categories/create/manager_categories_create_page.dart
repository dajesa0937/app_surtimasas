import 'package:app_surtimasas/src/login/pages/register/manager/orders/list/categories/create/manager_categories_create_controller.dart';
import 'package:app_surtimasas/src/login/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class ManagerCategoriesCreatePage extends StatefulWidget {
  const ManagerCategoriesCreatePage({Key key}) : super(key: key);

  @override
  _ManagerCategoriesCreatePageState createState() => _ManagerCategoriesCreatePageState();
}

class _ManagerCategoriesCreatePageState extends State<ManagerCategoriesCreatePage> {
  ManagerCategoriesCreateController _con = new ManagerCategoriesCreateController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NUEVA CATEGORIA'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          _TextFieldName(),
          _TextFieldDescription(),
        ],
      ),
      bottomNavigationBar: _buttonCreate(),

    );
  }

  Widget _TextFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
          hintText: 'Nombre de la Categoria',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          suffixIcon: Icon(
            Icons.list_alt,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _TextFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.descriptionController,
        maxLines: 3,
        maxLength: 255,
        //controller: _con.phoneController,
        decoration: InputDecoration(
          hintText: 'Descripcion de la Categoria',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          suffixIcon: Icon(
            Icons.description,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.createCategory,
        child: Text(
          'CREAR CATEGORIA',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  void refresh(){
    setState(() {});
  }
}

