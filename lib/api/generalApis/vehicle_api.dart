// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:ezcredit/model/profile_info_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../controller/auth_controller.dart';
import '../../globals.dart';
import '../end_points.dart';

class VehicleAPI {
  static final VehicleAPI _appManager = VehicleAPI._internal();

  factory VehicleAPI() {
    return _appManager;
  }

  VehicleAPI._internal();

  dynamic errorMessage;

  // ************************************* GET PROFILE INFO API *************************************

  Future<ProfileInfoModel?> getProfileInfoEndPoints(
      BuildContext context) async {
    late ProfileInfoModel profileInfoModel;

    try {
      var url = Uri.parse(
          '${EndPoints.server}${EndPoints.getProfileInfo}?userid=$userId');

      http.Response res = await http.get(
        url,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );
      var json = jsonDecode(res.body);

      print('json == $json');

      if (res.statusCode == 200) {
        profileInfoModel = ProfileInfoModel.fromJson(json['data']);

        return profileInfoModel;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
        }
      }
    } catch (e) {
      debugPrint('Error in get profile info :  $errorMessage');
    }
  }

  // ************************************* ADD PROFILE INFO API *************************************

  Future<Map<String, dynamic>> addVehicleInfoEndPoints({
    required String brand,
    required String model,
    required String color,
    required String year,
    required String condition,
    required String estprice,
    required String licence,
    required String vinno,
    required String plateno,
    required BuildContext context,
  }) async {
    Map<String, dynamic> profileMap = {};

    try {
      var url = Uri.parse('${EndPoints.server}${EndPoints.addProfileInfo}');

      var body = jsonEncode({
        "userid": userId,
        "vbrand": brand,
        "vmodel": model,
        "vcolor": color,
        "model_year": year,
        "condition": condition,
        "est_price": estprice,
        "vlicense": licence,
        "vin_no": vinno,
        "plate_no": plateno,
      });

      http.Response res = await http.post(url,
          headers: {'auth': authToken, "Content-Type": "application/json"},
          body: body);

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        profileMap = {"result": true, "error": ''};
        return profileMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          profileMap = {"result": false, "error": errorMessage};
        }
      }
    } catch (e) {
      profileMap = {
        "result": false,
        "error": "error in add employee Info : $e"
      };
    }
    return profileMap;
  }
}
