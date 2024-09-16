import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';

final defaultPinTheme = PinTheme(
  width: 50.w,
  height: 50.w,
  textStyle: TextStyle(
    fontSize: 22.sp,
    color: AppColors.blackBlue,
    fontWeight: FontWeight.bold,
  ),
  decoration: BoxDecoration(
    color: AppColors.colorButton.withOpacity(.2),
    borderRadius: BorderRadius.circular(
      10.r,
    ),
    border: Border.all(
      color: Colors.transparent,
    ),
  ),
);

Future<Map<String, dynamic>> showCodeDialog(BuildContext context) async {
  final TextEditingController _controller = TextEditingController();
  bool isCodeValid = false;

  // Afficher la boîte de dialogue
  final result = await showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible:false,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Saisir votre PIN',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.blackBlue, // Remplacez par votre couleur
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              child: Pinput(
                length: 4,
                autofocus: true,
                obscureText: true,
                separatorBuilder: (index) {
                  return SizedBox(width: 15);
                },
                scrollPadding: EdgeInsets.all(20),
                controller: _controller,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(
                        color: AppColors.colorButton,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                onCompleted: (pin) async {
                  final enteredCode = _controller.text;
                  if (enteredCode == AppCubitStorage().state.passWordTontinePerso) {
                    isCodeValid = true;
                    Navigator.of(context).pop({
                      'isValid': true,
                      'code': enteredCode,
                    });
                  } else {
                    toastification.show(
                      context: context,
                      title: Text(
                        "PIN incorrect".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      autoCloseDuration: Duration(seconds: 2),
                      type: ToastificationType.error,
                      style: ToastificationStyle.minimal,
                    );
            
                    Navigator.of(context).pop({
                      'isValid': false,
                      'code': enteredCode,
                    });
                  }
                },
              ),
            ),
             SizedBox(
            height: 30.h,
            width: MediaQuery.of(context).size.width,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
              Navigator.of(context).pop({
                'isValid': false,
                'code': '',
              });
            },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5.h,
                    bottom: 5.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.colorButton,
                    ),
                  ),
                  child: Text(
                    "Annuler",
                    style: TextStyle(
                      color: AppColors.colorButton,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
              final enteredCode = _controller.text;
              if (enteredCode == '1234') {
                // Remplacez cette condition par la validation réelle du code
                isCodeValid = true;
                Navigator.of(context).pop({
                  'isValid': true,
                  'code': enteredCode,
                });
              } else {
                toastification.show(
                  context: context,
                  title: Text(
                    "PIN incorrect".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.bold),
                  ),
                  autoCloseDuration: Duration(seconds: 2),
                  type: ToastificationType.error,
                  style: ToastificationStyle.minimal,
                );
                Navigator.of(context).pop({
                  'isValid': false,
                  'code': enteredCode,
                });
              }
            },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5.h,
                    bottom: 5.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.colorButton,
                  ),
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        
        
          ],
        ),
      );
    },
  );

  return result ?? {'isValid': false, 'code': ''};
}
