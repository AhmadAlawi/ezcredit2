import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../lang/key_lang.dart';
import '../loan_details_screen.dart';
import '../../style/assets.dart';
import '../../theme/app_colors.dart';
import '../../widgets/generalWidgets/menu.dart';
import 'carlease_details_screen.dart';

class CarLeaseTypeWidget extends StatelessWidget {
  const CarLeaseTypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardMenu(
          title: KeyLang.carleasing.tr(),
          icon: SvgAssets.car,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CarLeaseDetailsScreen(
                          title: KeyLang.carleasingserv.tr().toUpperCase(),
                        )));
          },
        ),
        Divider(
          color: AppColors.dividerColor,
        )
        // ,
        // CardMenu(
        //   title: KeyLang.van.tr(),
        //   icon: SvgAssets.homeDrawer,
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => LoanDetailsScreen(
        //                   title: KeyLang.van.tr(),
        //                 )));
        //   },
        // ),
        // Divider(
        //   color: AppColors.dividerColor,
        // ),
        // CardMenu(
        //   title: KeyLang.farming.tr(),
        //   icon: SvgAssets.person,
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => LoanDetailsScreen(
        //                   title: KeyLang.farming.tr(),
        //                 )));
        //   },
        // ),
        // Divider(
        //   color: AppColors.dividerColor,
        // ),
        // CardMenu(
        //   title: KeyLang.fourwheel.tr(),
        //   icon: SvgAssets.car,
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => LoanDetailsScreen(
        //                   title: KeyLang.fourwheel.tr(),
        //                 )));
        //   },
        // ),
        // Divider(
        //   color: AppColors.dividerColor,
        // ),
      ],
    );
  }
}
