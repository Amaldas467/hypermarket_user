import 'package:flutter/material.dart';
import 'package:hypermarket_user/repository/api/cart_product_list_screen/model/cart_product_list_model';
import 'package:hypermarket_user/repository/api/cart_product_list_screen/services/cart_product_list_services.dart';
import 'package:hypermarket_user/repository/api/profile_details/model/model.dart';
import 'package:hypermarket_user/repository/api/profile_details/services/Profile_details_model.dart';

class ProfileDetailsScreenController extends ChangeNotifier {
  bool cartitemListLoading = true;
  Data? profiledata;

  // get item
  Future getPersonalDetails() async {
    cartitemListLoading = true;
    notifyListeners();
    final fetchedData = await ProfileDetailsScreenServices().getPersonalData();
    if (fetchedData.error != true) {
      ProfileDetailsResModel personalData = await fetchedData.data;
      profiledata = personalData.personalDetails;
      print(profiledata);
    }

    cartitemListLoading = false;
    notifyListeners();

    print(profiledata);

    return profiledata;
  }
}
