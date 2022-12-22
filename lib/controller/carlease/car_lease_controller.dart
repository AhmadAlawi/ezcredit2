// ignore_for_file: use_build_context_synchronously

import 'package:ezcredit/api/generalApis/profile_info_api.dart';
import 'package:ezcredit/api/generalApis/vehicle_api.dart';
import 'package:ezcredit/model/country_model.dart';
import 'package:ezcredit/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart';
import '../../model/profile_info_model.dart';
import '../../model/car_lease_model.dart';
import '../../widgets/generalWidgets/common_ui.dart';
import '../../lang/change_lang.dart';
import '../../lang/config.dart';

class CarLeaseController extends ChangeNotifier {
  dynamic result;
  Map pageData = {};
  List<CountryModel>? countries = [];

  ProfileInfoModel? profileInfoModel;
  CarLeaseModel? carLeaseModel;
  String? vehicalBrand;
  String? vehicalModel;
  String? vehicalColor;
  int? vehicalYear;
  int? estimatedPrice;
  int? condtion;
  String? licence;
  String? vinNo;
  String? plateNo;

  Map<String, dynamic> profileMap = {};

  bool isLoading = false;
  bool postLoading = false;
  set setIsloading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  set setPostloading(bool value) {
    postLoading = value;
    notifyListeners();
  }

  String errorMessage = '';

  Future checkProfileData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('fullname_en') == null ||
        prefs.getString('fullname_en') == 'null') {
      profileInfoModel = await getProfileInfoHandler(context);
    }
    notifyListeners();
  }

  Future<ProfileInfoModel?> getProfileInfoHandler(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setIsloading = true;

      if (profileInfoModel != null) {
        await prefs.setString('carmodel', '${carLeaseModel?.vehicleModel}');
        await prefs.setString('fullname_ar', '${carLeaseModel?.vehicleBrand}');
        await prefs.setString('gender', '${carLeaseModel?.vehicleColor}');
        await prefs.setString('birth_date', '${carLeaseModel?.vehicleYear}');

        await prefs.setString('civilId', '${carLeaseModel?.condition}');
        await prefs.setString('phone', '${carLeaseModel?.estimatedPrice}');
        await prefs.setString('cityEn', '${carLeaseModel?.vehicleLicence}');
        await prefs.setString('cityAr', '${carLeaseModel?.vinNo}');
        await prefs.setString('cityAr', '${carLeaseModel?.plateNo}');
        // await prefs.setInt('cityId', carLeaseModel?.cityId ?? 0);
      } else {
        var error = VehicleAPI().errorMessage;
        bool containsMsg = error.containsKey('fields');

        if (containsMsg == true) {
          errorMessage = '${error['fields']['msg_en']}';
          CommonUi.snackBar(context, errorMessage);
        }
      }
      setIsloading = false;
      notifyListeners();

      return profileInfoModel;
    } catch (e) {
      setIsloading = false;

      errorMessage = VehicleAPI().errorMessage;
      CommonUi.snackBar(context, errorMessage);
    }
  }

  Future<Map<String, dynamic>?> addProfileInfoHandler(
      {required String brand,
      required String model,
      required String color,
      required String year,
      required String condition,
      required String estimatedprice,
      required String licence,
      required String vinno,
      required String plateno,
      required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setPostloading = true;
      profileMap = await VehicleAPI().addVehicleInfoEndPoints(
          model: model,
          brand: brand,
          color: color,
          year: year,
          condition: condition,
          estprice: estimatedprice,
          licence: licence,
          vinno: vinno,
          plateno: plateno,
          context: context);

      setPostloading = false;

      if (profileMap['result'] == true) {
        prefs.setString('fullname_en', model);
        prefs.setString('fullname_ar', brand);
        prefs.setString('gender', color);
        prefs.setString('birth_date', year);
        prefs.setString('country_ar', condition);
        prefs.setString('country_en', estimatedprice);
        prefs.setString('phone', licence);
        prefs.setString('civilId', vinno);
        prefs.setString('nationalityId', plateno);

        if (profile == false) {
          CommonUi.simpleToast(message: 'Added Successfully');
        }
      } else {
        var error = profileMap['error'];
        bool containsServer = error.containsKey('server');
        bool containsMsg = error.containsKey('fields');
        if (containsServer == true) {
          errorMessage = '${error['server']['msg_en']}';
        } else if (containsMsg == true) {
          errorMessage = '${error['fields']['msg_en']}';
        }
        CommonUi.snackBar(context, errorMessage);
      }
    } catch (e) {
      postLoading = false;
      //CommonUi.snackBar(context, errorMessage);
    }
  }

  Future getProfileFromSharedPrefrence(BuildContext context) async {
    // setIsloading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    pageData["fullname_ar"] = prefs.getString('fullname_ar') == 'null'
        ? ''
        : '${prefs.getString('fullname_ar')}';

    pageData["fullname_en"] = prefs.getString('fullname_en') == 'null'
        ? ''
        : '${prefs.getString('fullname_en')}';
    pageData["gender"] = prefs.getString('gender') == 'null'
        ? ''
        : '${prefs.getString('gender')}';
    pageData["country_en"] = local == ConfigLanguage.enLocale
        ? prefs.getString('country_en') == 'null'
            ? ''
            : '${prefs.getString('country_en')}'
        : prefs.getString('country_ar') == 'null'
            ? ''
            : '${prefs.getString('country_ar')}';
    pageData["birth_date"] = prefs.getString('birth_date') == 'null'
        ? ''
        : '${prefs.getString('birth_date')}';
    //setIsloading = false;

    notifyListeners();
  }
}
