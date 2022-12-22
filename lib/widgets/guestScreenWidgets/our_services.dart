import 'package:ezcredit/globals.dart';
import 'package:ezcredit/lang/key_lang.dart';
import 'package:ezcredit/widgets/guestScreenWidgets/credit_widget.dart';
import 'package:ezcredit/widgets/guestScreenWidgets/loan_widget.dart';
import 'package:ezcredit/widgets/guestScreenWidgets/our_services_widgets/buy_loan_widget.dart';
import 'package:ezcredit/widgets/guestScreenWidgets/our_services_widgets/investment_fund_loan_widget.dart';
import 'package:ezcredit/widgets/guestScreenWidgets/services.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../screen/sign_up_screen.dart';
import '../../style/assets.dart';
import '../../theme/app_colors.dart';
import '../generalWidgets/main_button.dart';
import 'our_services_widgets/car_leasing_widget.dart';
import 'our_services_widgets/deposite_widget.dart';
import 'our_services_widgets/flash_loan_widget.dart';

class OurServicesWidget extends StatefulWidget {
  const OurServicesWidget({Key? key}) : super(key: key);

  @override
  State<OurServicesWidget> createState() => _OurServicesWidgetState();
}

class _OurServicesWidgetState extends State<OurServicesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            KeyLang.ourServices.tr(),
            style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          ServicesList(
              icon: SvgAssets.loan,
              subTitle: KeyLang.leonsMsg.tr(),
              title: KeyLang.leons.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  LoanServicesWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.carleasing,
              title: KeyLang.carleasing.tr(),
              subTitle: KeyLang.carleasing.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CarLeasingWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.loan,
              subTitle: KeyLang.deposits.tr(),
              title: KeyLang.deposits.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DepositeWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.loan,
              title: KeyLang.creditCard.tr(),
              subTitle: KeyLang.creditCardMsg.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CreditServicesWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.loan,
              subTitle: KeyLang.flashloan.tr(),
              title: KeyLang.flashloan.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  FlashLoanWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.loan,
              subTitle: KeyLang.buyloan.tr(),
              title: KeyLang.buyloan.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  BuyLoanWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.loan,
              subTitle: KeyLang.investmentfundloan.tr(),
              title: KeyLang.investmentfundloan.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  InvestmentFundLoanWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.buynowpaylater,
              subTitle: KeyLang.buynowpaylater.tr(),
              title: KeyLang.buynowpaylater.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CreditServicesWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.creditCard,
              subTitle: KeyLang.openingnewacc.tr(),
              title: KeyLang.openingnewacc.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CreditServicesWidget.id,
                );
              }),
          ServicesList(
              icon: SvgAssets.bestInterest,
              subTitle: KeyLang.bestInterestMsg.tr(),
              title: KeyLang.bestInterest.tr(),
              onTap: () {
                Navigator.pushNamed(context, CreditServicesWidget.id,
                    arguments: {'title': KeyLang.deposits.tr()});
              }),
          user == "guest"
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: MainButton(
                    textStyle: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    radius: 8.r,
                    text: KeyLang.joinNow.tr(),
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    width: double.infinity,
                    color: AppColors.buttonColor,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
