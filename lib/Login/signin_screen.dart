import 'package:CFM/Login/reset_password.dart';
import 'package:CFM/Login/signup_screen.dart';
import 'package:CFM/Screen/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screen/Admin/Update_product.dart';
import '../dialog/showdialog.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../router.dart';
import '../utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  void faillogin() {
    Fluttertoast.showToast(
      msg: "Sai thông tin đăng nhập!",
      gravity: ToastGravity.BOTTOM,
      fontSize: 15,
    );
  }
  void successlogin() {
    Fluttertoast.showToast(
      msg: "Đăng nhập thành công",
      gravity: ToastGravity.BOTTOM,
      fontSize: 15,

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text('Đăng nhập',style: TextStyle(color: Colors.white,fontSize: 40),)
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    reusableTextField("Email đăng nhập", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Mật khẩu", Icons.lock_outline, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 5,
                    ),
                    forgetPassword(context),
                    firebaseUIButton(context, "Đăng Nhập", () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) async{
                        await Navigator.of(context).pushReplacementNamed(RouteName.update);

                      }).onError((error, stackTrace) {
                        messageAccess(
                          context,
                          'Sai thông tin đăng nhập',
                          onPressOK: () {
                            Navigator.pop(context);
                          }
                        );
                        print("Error ${error.toString()}");
                      });
                    }),
                    signUpOption()
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 60,left: 20),
              alignment: Alignment.topLeft,
              child: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Bạn chưa có tài khoản ?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Đăng Ký",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Quên mật khẩu ?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}
