import 'package:flutter/material.dart';

import 'package:hypermarket_user/presentation/login_screen/controller/login_controller.dart';
import 'package:hypermarket_user/presentation/personal_deatils/controller/profile_details.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ProfileDetailsScreenController>(context, listen: false)
          .getPersonalDetails();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileDatProvider =
        Provider.of<ProfileDetailsScreenController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text("Name"),
            SizedBox(
              height: 6,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Text(
                  profileDatProvider.profiledata?.fullName ?? "",
                  style:
                      TextStyle(color: const Color.fromARGB(255, 202, 43, 32)),
                )),
            SizedBox(height: 10),
            Text("Mobile Number"),
            SizedBox(
              height: 6,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Text(
                  profileDatProvider.profiledata?.phone ?? "",
                  style:
                      TextStyle(color: const Color.fromARGB(255, 202, 43, 32)),
                )),
            SizedBox(height: 10),
            profileDatProvider.profiledata?.email == null
                ? SizedBox()
                : Text("Email"),
            profileDatProvider.profiledata?.email == null
                ? SizedBox()
                : SizedBox(
                    height: 6,
                  ),
            profileDatProvider.profiledata?.email == null
                ? SizedBox()
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Text(
                      profileDatProvider.profiledata?.email ?? "",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 202, 43, 32)),
                    )),
            SizedBox(height: 10),
            Text("DOB"),
            SizedBox(
              height: 6,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Text(
                  profileDatProvider.profiledata?.dob ?? "",
                  style:
                      TextStyle(color: const Color.fromARGB(255, 202, 43, 32)),
                )),
            SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
