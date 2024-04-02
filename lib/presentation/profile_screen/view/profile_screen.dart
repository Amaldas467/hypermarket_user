import 'package:flutter/material.dart';
import 'package:hypermarket_user/app_config/app_config.dart';
import 'package:hypermarket_user/global_widgets/alert_popup.dart';
import 'package:hypermarket_user/presentation/personal_deatils/view/personal_details_screen.dart';
import 'package:hypermarket_user/repository/helper/helper_fincitons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var data;
  void getdata() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    data = sharedPreferences.getString(AppConfig.LOGIN_DATA);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalDetails(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 20),
                      Text("Personal Details")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    //the return value will be from "Yes" or "No" options
                    context: context,
                    builder: (context) => CustomAlertPopup(
                        title: 'Do you want to LogOut?',
                        onyesPressed: () {
                          HelperFunctions.logOut(context);

                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => GetStartedScreen(),
                          //   ),
                          // );
                        }),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 20),
                      Text("LogOut")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
