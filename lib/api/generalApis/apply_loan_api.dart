// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/auth_controller.dart';
import '../../globals.dart';
import '../end_points.dart';

class ApplyLoanAPI {
  static final ApplyLoanAPI _appManager = ApplyLoanAPI._internal();

  factory ApplyLoanAPI() {
    return _appManager;
  }

  ApplyLoanAPI._internal();

  dynamic errorMessage;

  // ************************************* APPLY LAON API *************************************

  Future<Map<String, dynamic>> applyLoanEndPoints(
      {required String preferredBusinessType,
      required String type,
      required int amount,
      required int installmentNum,
      required String fullNameAr,
      required String fullNameEn,
      required String civilId,
      required int nationality,
      required int country,
      required int city,
      required String phoneNumber,
      required String gender,
      required String birthDate,
      required String employmentStatus,
      required String employer,
      required int income,
      required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = jsonEncode({
      "userid": userId,
      "preferred_organization_type": 'banks',
      "preferred_business_type": preferredBusinessType,
      "type": type,
      "amount": amount,
      "installments_number": installmentNum,
      "fullname_ar": fullNameAr,
      "fullname_en": fullNameEn,
      "civil_id": civilId,
      "nationality": nationality,
      "country": country,
      "city": city,
      "currency": "KWD",
      "phone_number": phoneNumber,
      "gender": gender,
      "birth_date": birthDate,
      "employment_status": employmentStatus,
      "employer": employer,
      "income": income
    });

    Map<String, dynamic> applyLoanApiMap = {};

    try {
      var url = Uri.parse('${EndPoints.server}${EndPoints.applyLoan}');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        var date = DateTime.now();
        String dateFormate = DateFormat('yyyy-MM-dd').format(date);
        await prefs.setString('sentLoanDate', dateFormate);
        applyLoanApiMap = {
          'result': json['success'],
          "error": '',
        };
        return applyLoanApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          applyLoanApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      errorMessage = 'Error in apply loan :  $e';
      applyLoanApiMap = {
        'result': false,
        "error": errorMessage,
      };
      debugPrint('Error in get apply loan :  $e');
    }
    return applyLoanApiMap;
  }

  Future<Map<String, dynamic>> loanValidateStep1EndPoints(
      {required String fullNameAr,
      required String fullNameEn,
      required String civilId,
      required int nationality,
      required int country,
      required int city,
      required String phoneNumber,
      required String gender,
      required String birthDate,
      required int status,
      required BuildContext context}) async {
    Map<String, dynamic> loanValidateApiMap = {};
    var body = jsonEncode({
      "userid": userId,
      "fullname_ar": fullNameAr,
      "fullname_en": fullNameEn,
      "civil_id": civilId,
      "nationality": nationality,
      "country": country,
      "city": city,
      "currency": "KWD",
      "phone_number": phoneNumber,
      "gender": gender,
      "birth_date": birthDate,
    });

    try {
      var url = Uri.parse(
          '${EndPoints.server}${EndPoints.loanValidate}?step=$status');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        loanValidateApiMap = {
          'result': json['success'],
          'message': json['message'],
          "error": '',
        };
        return loanValidateApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          loanValidateApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      debugPrint('Error in validate loan :  $e');
    }

    return loanValidateApiMap;
  }

  Future<Map<String, dynamic>> loanValidateStep2EndPoints({
    required String employmentStatus,
    required String employer,
    required int income,
    required int status,
    required BuildContext context,
  }) async {
    Map<String, dynamic> loanValidateApiMap = {};
    var body = jsonEncode({
      "userid": userId,
      "employment_status": employmentStatus,
      "employer": employer,
      "currency": "KWD",
      "income": income
    });

    try {
      var url = Uri.parse(
          '${EndPoints.server}${EndPoints.loanValidate}?step=$status');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        loanValidateApiMap = {
          'result': json['success'],
          'message': json['message'],
          "error": '',
        };
        return loanValidateApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          loanValidateApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      debugPrint('Error in validate loan :  $e');
    }

    return loanValidateApiMap;
  }

  Future<Map<String, dynamic>> loanValidateStep3EndPoints({
    required String preferredBusinessType,
    required String type,
    required int amount,
    required int installmentNum,
    required int status,
    required BuildContext context,
  }) async {
    Map<String, dynamic> loanValidateApiMap = {};
    var body = jsonEncode({
      "userid": userId,
      "preferred_organization_type": 'banks',
      "preferred_business_type": preferredBusinessType,
      "type": type,
      "amount": amount,
      "installments_number": installmentNum,
    });

    try {
      var url = Uri.parse(
          '${EndPoints.server}${EndPoints.loanValidate}?step=$status');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        loanValidateApiMap = {
          'result': json['success'],
          'message': json['message'],
          "error": '',
        };
        return loanValidateApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          loanValidateApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      debugPrint('Error in validate loan :  $e');
    }

    return loanValidateApiMap;
  }

  // ************************************* APPLY CARLease API *************************************

  Future<Map<String, dynamic>> applyCarLeaseEndPoints(
      {required String preferredBusinessType,
      required String type,
      required int amount,
      required int installmentNum,
      required String fullNameAr,
      required String fullNameEn,
      required String civilId,
      required int nationality,
      required int country,
      required int city,
      required String phoneNumber,
      required String gender,
      required String birthDate,
      required String employmentStatus,
      required String employer,
      required int income,
      required int salary,
      required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = jsonEncode({
      "userid": userId,
      "preferred_organization_type": 'banks',
      "preferred_business_type": preferredBusinessType,
      "type": type,
      "amount": amount,
      "installments_number": installmentNum,
      "fullname_ar": fullNameAr,
      "fullname_en": fullNameEn,
      "civil_id": civilId,
      "nationality": nationality,
      "country": country,
      "city": city,
      "currency": "KWD",
      "phone_number": phoneNumber,
      "gender": gender,
      "birth_date": birthDate,
      "employment_status": employmentStatus,
      "employer": employer,
      "income": income,
      "total_liabilities": 2500,
      "loan": 2530,
      "other_liabilities": 500,
      "credit_card": 500,
      "total_monthly_installment": 10,
      "vbrand": "qq",
      "vmodel": "vv",
      "vcolor": "xx",
      "model_year": "2022-06-21 14:22:13.973667",
      "condition": "new",
      "est_price": 1221,
      "vlicense": 20,
      "vin_no": 20,
      "plate_no": 20
    });

    Map<String, dynamic> applyLoanApiMap = {};

    try {
      var url = Uri.parse('${EndPoints.server}${EndPoints.applyLoan}');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        var date = DateTime.now();
        String dateFormate = DateFormat('yyyy-MM-dd').format(date);
        await prefs.setString('sentLoanDate', dateFormate);
        applyLoanApiMap = {
          'result': json['success'],
          "error": '',
        };
        return applyLoanApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          applyLoanApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      errorMessage = 'Error in apply loan :  $e';
      applyLoanApiMap = {
        'result': false,
        "error": errorMessage,
      };
      debugPrint('Error in get apply loan :  $e');
    }
    return applyLoanApiMap;
  }

  Future<Map<String, dynamic>> carLeaseValidateStep1EndPoints(
      {required String fullNameAr,
      required String fullNameEn,
      required String civilId,
      required int nationality,
      required int country,
      required int city,
      required String phoneNumber,
      required String gender,
      required String birthDate,
      required int status,
      required BuildContext context}) async {
    Map<String, dynamic> loanValidateApiMap = {};
    var body = jsonEncode({
      "userid": userId,
      "fullname_ar": fullNameAr,
      "fullname_en": fullNameEn,
      "civil_id": civilId,
      "nationality": nationality,
      "country": country,
      "city": city,
      "currency": "KWD",
      "phone_number": phoneNumber,
      "gender": gender,
      "birth_date": birthDate,
    });

    try {
      var url = Uri.parse(
          '${EndPoints.server}${EndPoints.loanValidate}?step=$status');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        loanValidateApiMap = {
          'result': json['success'],
          'message': json['message'],
          "error": '',
        };
        return loanValidateApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          loanValidateApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      debugPrint('Error in validate loan :  $e');
    }

    return loanValidateApiMap;
  }

  Future<Map<String, dynamic>> carLeaseValidateStep2EndPoints({
    required String employmentStatus,
    required String employer,
    required int income,
    required int status,
    required BuildContext context,
  }) async {
    Map<String, dynamic> loanValidateApiMap = {};
    var body = jsonEncode({
      "userid": userId,
      "employment_status": employmentStatus,
      "employer": employer,
      "currency": "KWD",
      "income": income
    });

    try {
      var url = Uri.parse(
          '${EndPoints.server}${EndPoints.loanValidate}?step=$status');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        loanValidateApiMap = {
          'result': json['success'],
          'message': json['message'],
          "error": '',
        };
        return loanValidateApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          loanValidateApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      debugPrint('Error in validate loan :  $e');
    }

    return loanValidateApiMap;
  }

  Future<Map<String, dynamic>> carLeaseValidateStep3EndPoints({
    required String preferredBusinessType,
    required String type,
    required int amount,
    required int installmentNum,
    required int status,
    required BuildContext context,
  }) async {
    Map<String, dynamic> loanValidateApiMap = {};
    var body = jsonEncode({
      "userid": userId,
      "total_liabilities": 2500,
      "loan": 2530,
      "other_liabilities": 500,
      "credit_card": 500,
      "total_monthly_installment": 10,
    });

    try {
      var url = Uri.parse(
          '${EndPoints.server}${EndPoints.loanValidate}?step=$status');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        loanValidateApiMap = {
          'result': json['success'],
          'message': json['message'],
          "error": '',
        };
        return loanValidateApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          loanValidateApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      debugPrint('Error in validate loan :  $e');
    }

    return loanValidateApiMap;
  }

  Future<Map<String, dynamic>> carLeaseValidateStep4EndPoints({
    required String preferredBusinessType,
    required String type,
    required int amount,
    required int installmentNum,
    required int status,
    required BuildContext context,
  }) async {
    Map<String, dynamic> loanValidateApiMap = {};
    var body = jsonEncode({
      "userid": userId,
      "total_liabilities": 2500,
      "loan": 2530,
      "other_liabilities": 500,
      "credit_card": 500,
      "total_monthly_installment": 10,
    });

    try {
      var url = Uri.parse(
          '${EndPoints.server}${EndPoints.loanValidate}?step=$status');

      http.Response res = await http.post(
        url,
        body: body,
        headers: {'auth': authToken, "Content-Type": "application/json"},
      );

      var json = jsonDecode(res.body);

      if (res.statusCode == 200) {
        loanValidateApiMap = {
          'result': json['success'],
          'message': json['message'],
          "error": '',
        };
        return loanValidateApiMap;
      } else {
        if (json['meta']['https_code'] == 401) {
          errorMessage = json['errors'];
          Authcontroller().logOut(context, errorMessage['server']['msg_en']);
        } else {
          errorMessage = json['errors'];
          loanValidateApiMap = {
            'result': json['success'],
            "error": errorMessage,
          };
        }
      }
    } catch (e) {
      debugPrint('Error in validate loan :  $e');
    }

    return loanValidateApiMap;
  }
}
