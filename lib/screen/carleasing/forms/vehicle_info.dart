// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:ezcredit/controller/apply_controller.dart';
import 'package:ezcredit/widgets/generalWidgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/general_controller.dart';
import '../../../globals.dart';
import '../../../lang/change_lang.dart';
import '../../../lang/config.dart';
import '../../../lang/key_lang.dart';
import '../../../model/car_model.dart';
import '../../../service/generalServices/enums_value.dart';
import '../../../service/generalServices/update_status.dart';
import '../../../style/form_style.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/generalWidgets/drop_down.dart';
import '../../../controller/carlease/car_lease_controller.dart';

const List<String> list = <String>['Used', 'New'];

class VehicleinfoField extends StatefulWidget {
  final int? status;

  const VehicleinfoField({Key? key, this.status}) : super(key: key);

  @override
  State<VehicleinfoField> createState() => _VehicleinfoField();
}

class _VehicleinfoField extends State<VehicleinfoField> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController licenceController = TextEditingController();
  final TextEditingController condtionController = TextEditingController();
  final TextEditingController platenoController = TextEditingController();
  final TextEditingController vinnoController = TextEditingController();

  final TextEditingController esitimatedpriceController =
      TextEditingController();

  String? ConditionValue;

  void updateClicks(BuildContext context) {
    Provider.of<ClickStatus>(context, listen: false).updateClick();
  }

  Future getProfileFromMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!mounted) return;
    await Provider.of<GeneralController>(context, listen: false)
        .getVehicalsHandler(context);
    final apply = Provider.of<ApplyController>(context, listen: false);
    if (apply.applyLoanMap.values.isEmpty) {
      await apply.initializeData(context);
    }

    setState(() {
      brandController.text = apply.applyLoanMap['brand'];
      modelController.text = apply.applyLoanMap['model'];
      colorController.text = apply.applyLoanMap['color'];
      yearController.text = apply.applyLoanMap['year'];
      esitimatedpriceController.text = apply.applyLoanMap['estimatedprice'];
    });
  }

  Color? colorBorder;

  @override
  void initState() {
    getProfileFromMap();

    super.initState();
  }

  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  ScrollController scrollController = ScrollController();
  FocusNode brandtxt = new FocusNode();
  FocusNode colortxt = new FocusNode();
  FocusNode modeltxt = new FocusNode();
  FocusNode yeartxt = new FocusNode();
  FocusNode conditiontxt = new FocusNode();
  FocusNode licencetxt = new FocusNode();
  FocusNode estimatedpricetext = new FocusNode();
  FocusNode platenotxt = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(KeyLang.vehiclebrand.tr()),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                autofocus: false,
                focusNode: brandtxt,
                style: const TextStyle(color: Colors.black),
                controller: brandController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return KeyLang.enterValue.tr();
                  }

                  return null;
                },
                decoration: AppStyles.formStyle(KeyLang.vehiclebrand.tr(),
                    radius: 8.r,
                    borderColor: AppColors.formBorderColor,
                    focusBorderColor: AppColors.formBorderColor,
                    enabledBorderColor: AppColors.formBorderColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(KeyLang.vehiclemodel.tr()),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                autofocus: false,
                focusNode: modeltxt,
                style: const TextStyle(color: Colors.black),
                controller: modelController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return KeyLang.enterValue.tr();
                  }

                  return null;
                },
                decoration: AppStyles.formStyle(KeyLang.vehiclemodel.tr(),
                    radius: 8.r,
                    borderColor: AppColors.formBorderColor,
                    focusBorderColor: AppColors.formBorderColor,
                    enabledBorderColor: AppColors.formBorderColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(KeyLang.vehiclecolor.tr()),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                autofocus: false,
                focusNode: colortxt,
                style: const TextStyle(color: Colors.black),
                controller: colorController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return KeyLang.enterValue.tr();
                  }

                  return null;
                },
                decoration: AppStyles.formStyle(KeyLang.vehiclecolor.tr(),
                    radius: 8.r,
                    borderColor: AppColors.formBorderColor,
                    focusBorderColor: AppColors.formBorderColor,
                    enabledBorderColor: AppColors.formBorderColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(KeyLang.modelyear.tr()),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                autofocus: false,
                focusNode: yeartxt,
                style: const TextStyle(color: Colors.black),
                controller: yearController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return KeyLang.enterValue.tr();
                  }

                  return null;
                },
                decoration: AppStyles.formStyle(KeyLang.modelyear.tr(),
                    radius: 8.r,
                    borderColor: AppColors.formBorderColor,
                    focusBorderColor: AppColors.formBorderColor,
                    enabledBorderColor: AppColors.formBorderColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(KeyLang.condition.tr()),
              SizedBox(
                height: 8.h,
              ),
              ConditionValue == ''
                  ? MainDropDownMenu(
                      items: list,
                      hint: KeyLang.select.tr(),
                      focusNode: conditiontxt,
                      //value: nationalityValue ?? 'Jordan',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return KeyLang.enterValue.tr();
                        }
                        return null;
                      },
                      onChanged: (value) async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        int index = vehicalsStrings!.indexWhere((element) {
                          return element == value;
                        });

                        pref.setInt('nationalityId', nationalityID);
                      })
                  : MainDropDownMenu(
                      items: list,
                      hint: KeyLang.select.tr(),
                      value: ConditionValue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return KeyLang.enterValue.tr();
                        }
                        return null;
                      },
                      onChanged: (value) async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        int index = vehicalsStrings!.indexWhere((element) {
                          return element == value;
                        });

                        pref.setInt('vehicalCondition', vehicalCondition);
                      }),
              SizedBox(
                height: 20.h,
              ),
              Text(KeyLang.estimatedprice.tr()),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                autofocus: false,
                focusNode: estimatedpricetext,
                style: const TextStyle(color: Colors.black),
                controller: esitimatedpriceController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return KeyLang.enterValue.tr();
                  }

                  return null;
                },
                decoration: AppStyles.formStyle(KeyLang.estimatedprice.tr(),
                    radius: 8.r,
                    borderColor: AppColors.formBorderColor,
                    focusBorderColor: AppColors.formBorderColor,
                    enabledBorderColor: AppColors.formBorderColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(KeyLang.vehiclelicense.tr()),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                autofocus: false,
                focusNode: licencetxt,
                style: const TextStyle(color: Colors.black),
                controller: licenceController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return KeyLang.enterValue.tr();
                  }

                  return null;
                },
                decoration: AppStyles.formStyle(KeyLang.vehiclelicense.tr(),
                    radius: 8.r,
                    borderColor: AppColors.formBorderColor,
                    focusBorderColor: AppColors.formBorderColor,
                    enabledBorderColor: AppColors.formBorderColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(KeyLang.plateno.tr()),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                autofocus: false,
                focusNode: platenotxt,
                style: const TextStyle(color: Colors.black),
                controller: platenoController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return KeyLang.enterValue.tr();
                  }

                  return null;
                },
                decoration: AppStyles.formStyle(KeyLang.plateno.tr(),
                    radius: 8.r,
                    borderColor: AppColors.formBorderColor,
                    focusBorderColor: AppColors.formBorderColor,
                    enabledBorderColor: AppColors.formBorderColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<ApplyController>(
                      builder: (context, applyController, child) {
                    return MainButton(
                      text: '${KeyLang.next.tr()} >>',
                      color: AppColors.buttonColor,
                      radius: 10.r,
                      width: 120.w,
                      isDisabled: applyController.isLoading,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          profile = true;

                          colorBorder = AppColors.formBorderColor;
                          await applyController.saveDataHandlerData(applyMap: {
                            //'fullname_en': nameENController.text,
                            //'fullname_ar': nameARController.text,
                          }).then((value) async {
                            Map<String, dynamic>? validateOneMap = {};
                            validateOneMap =
                                await applyController.loanValidateStep1Handler(
                                    status: widget.status ?? 0,
                                    context: context);

                            if (validateOneMap?['result'] == true) {
                              if (!mounted) return;
                              Provider.of<CarLeaseController>(
                                      context,
                                      listen: false)
                                  .addProfileInfoHandler(
                                      brand: brandController.text,
                                      model: modelController.text,
                                      color: colorController.text,
                                      year: yearController.text,
                                      condition: condtionController.text,
                                      estimatedprice:
                                          esitimatedpriceController.text,
                                      licence: licenceController.text,
                                      vinno: vinnoController.text,
                                      plateno: platenoController.text,
                                      context: context);
                              updateClicks(context);
                            }
                          });
                        } else {
                          autoValidate = AutovalidateMode.onUserInteraction;
                          if (brandController.text.isEmpty) {
                            brandtxt.requestFocus();
                          } else if (modelController.text.isEmpty) {
                            modeltxt.requestFocus();
                          } else if (colorController.text.isEmpty) {
                            colortxt.requestFocus();
                          } else if (yearController.text.isEmpty) {
                            yeartxt.requestFocus();
                          } else if (esitimatedpriceController.text.isEmpty) {
                            estimatedpricetext.requestFocus();
                          } else if (licenceController.text.isEmpty) {
                            licencetxt.requestFocus();
                          } else if (platenoController.text.isEmpty) {
                            platenotxt.requestFocus();
                          } else if (condtionController.text.isEmpty) {
                            conditiontxt.requestFocus();
                          }
                          setState(() {});
                        }
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
