import 'package:ezcredit/globals.dart';
import 'package:ezcredit/lang/key_lang.dart';
import 'package:ezcredit/style/assets.dart';
import 'package:ezcredit/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/generalWidgets/points.dart';

class CarLeaseDetailsWidget extends StatefulWidget {
  final String title;
  const CarLeaseDetailsWidget({Key? key, required this.title})
      : super(key: key);

  @override
  State<CarLeaseDetailsWidget> createState() => _CarLeaseDetailsWidget();
}

class _CarLeaseDetailsWidget extends State<CarLeaseDetailsWidget> {
  @override
  void initState() {
    loanTitle = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          image: AssetImage(ImageAssets.bank1),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Text(
            widget.title,
            style: AppColors.fredoka.headline5,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Text(
            "Drive Into the Future",
            style: AppColors.fredoka.bodyText2!
                .copyWith(color: const Color(0xff333333)),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              KeyLang.carleasingdesc1,
            )),
        SizedBox(
          height: 10.h,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(KeyLang.carleasingdesc2)),
        SizedBox(
          height: 100.h,
        ),
      ],
    );
  }
}
