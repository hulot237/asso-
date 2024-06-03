import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/pages/rapport_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonRapport extends StatelessWidget {
  ButtonRapport(
      {super.key, required this.nomElement, required this.rapportUrl});

  final String nomElement;
  final String rapportUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RapportViewScreen(
              src: rapportUrl,
              nomElement: nomElement,
            ),
          ),
        );
        // SfPdfViewer.network('${currentDetailSeance["rapport"]}');
        print("object");
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 7.h,
        ),
        padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.blackBlue.withOpacity(.3),
              spreadRadius: 0.5,
              blurRadius: 1,
            ),
          ],
          color: AppColors.colorButton,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Text(
          "Le rapport est disponible".tr(),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
