import 'package:app_surtimasas/src/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_surtimasas/src/login/utils/my_colors.dart';
import 'package:flutter/scheduler.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = new LoginController();

  @override
  void initState(){
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -90,
               left: -100,
                child: _circleLogin()
            ),

            Positioned(child: _TextLogin(),
              top: 75,
              left: 25,

            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _imageBanner(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonLogin(),
                  _TextCuenta(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _TextLogin(){
   return Text(
     'SDLC',
     style: TextStyle(
       color: Colors.green,
       fontWeight: FontWeight.bold,
       fontSize: 22,
    ),
   );
  }

  Widget _TextCuenta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Tienes Cuenta?',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            fontSize: 17
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text(''
              'Registra tu Cuenta',
            
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 17
            ),
          ),
        ),
      ],
    );
  }
  Widget _buttonLogin() {
   return Container(
     width: double.infinity,
     margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
     child: ElevatedButton(
          onPressed: _con.login,
          child: Text('INGRESAR',
              style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green
          ), ),

          style: ElevatedButton.styleFrom(

             primary: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
          ),
            padding: EdgeInsets.symmetric(vertical: 15)
          ),
      ),
   );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(
                    Icons.lock,
                    color: MyColors.primaryColor,
                ),
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo Electronico',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _circleLogin(){
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:MyColors.primaryColor
      ),
    );

  }

  Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(
          top: 100,
          bottom: MediaQuery.of(context).size.height * 0.10
      ),
      child: Image.asset(
        'assets/img/logo_surtimasas.jpg',
        width: 250,
        height: 250,

      ),
    );
  }
}
