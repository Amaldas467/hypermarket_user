import 'package:flutter/material.dart';
import 'package:hypermarket_user/app_config/app_config.dart';
import 'package:hypermarket_user/core/app_utils/app_utils.dart';
import 'package:hypermarket_user/core/constants/color.dart';
import 'package:hypermarket_user/presentation/bottom_nav_screen/view/bottom_nav_screen.dart';
import 'package:hypermarket_user/presentation/login_screen/controller/login_controller.dart';
import 'package:hypermarket_user/presentation/registration__screen/view/registration_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                _buildTextField(
                  controller: _usernameController,
                  hintText: 'Mobile Number',
                  isPassword: false,
                ),
                SizedBox(height: 20),
                _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    eye: true),
                SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      await Provider.of<LoginScreenController>(context,
                              listen: false)
                          .onLogin(
                              phone: _usernameController.text.trim(),
                              password: _passwordController.text.trim())
                          .then((value) async {
                        print("login value $value");
                        if (value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomNavScreen(),
                              ),
                              (route) => false);
                        } else {
                          AppUtils.oneTimeSnackBar(
                              bgColor: Colors.red,
                              "Enter a vaild user and pass",
                              context: context);
                        }
                        _usernameController.clear();
                        _passwordController.clear();
                      });
                    } else {
                      AppUtils.oneTimeSnackBar(
                          bgColor: Colors.red,
                          "Enter valid user name or password",
                          context: context);
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstant.primaryGreen),
                    child: Center(
                        child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: TextStyle(
                            color: ColorConstant.hyperGrey,
                            fontSize: 14,
                            height: 1.5),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationScreen(),
                              ));
                        },
                        child: Text(
                          "Register",
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      bool isPassword = false,
      bool eye = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: eye == true ? Icon(Icons.remove_red_eye) : null,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
