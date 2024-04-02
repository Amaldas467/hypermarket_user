import 'package:hypermarket_user/core/app_utils/app_utils.dart';
import 'package:hypermarket_user/repository/api/profile_details/model/model.dart';
import 'package:hypermarket_user/repository/helper/api_helper.dart';
import 'package:hypermarket_user/repository/helper/api_response.dart';

class ProfileDetailsScreenServices {
  //function to get course detils

  Future<APIResponse> getPersonalData() async {
    try {
      final APIResponse response = await ApiHelper.getData(
          endPoint: "/profile/",
          header:
              ApiHelper.getApiHeader(access: await AppUtils.getAccessKey()));
      if (response.error) {
        print("***************************************ERROR");
        return response;
      } else {
        ProfileDetailsResModel resData =
            ProfileDetailsResModel.fromJson(response.data);
        print("***************************************$resData");
        return APIResponse(data: resData, error: false, errorMessage: '');
      }
    } catch (e) {
      return APIResponse(data: "resData", error: true, errorMessage: '');
    }
  }
}
