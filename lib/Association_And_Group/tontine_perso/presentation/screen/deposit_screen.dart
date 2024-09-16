// import 'dart:convert';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:faroty_association_1/Modals/fonction.dart';
// import 'package:faroty_association_1/Theming/color.dart';
// import 'package:faroty_association_1/localStorage/localCubit.dart';
// import 'package:faroty_association_1/network/token_interceptor.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pinput/pinput.dart';
// import 'package:toastification/toastification.dart';

// final Dio dio = Dio()
//   ..interceptors.addAll([
//     TokenInterceptor(),
//   ]);

// final defaultPinTheme = PinTheme(
//   width: 50.w,
//   height: 50.w,
//   textStyle: TextStyle(
//     fontSize: 22.sp,
//     color: AppColors.blackBlue,
//     fontWeight: FontWeight.bold,
//   ),
//   decoration: BoxDecoration(
//     color: AppColors.colorButton.withOpacity(.2),
//     borderRadius: BorderRadius.circular(
//       10.r,
//     ),
//     border: Border.all(
//       color: Colors.transparent,
//     ),
//   ),
// );

// final TextEditingController _controllerPin = TextEditingController();
// bool isCodeValid = false;
// bool isLoading = false;

// class DialogUtils {
//   static void showDepositPopup(BuildContext context, String numero) {
//     if (Navigator.of(context).canPop()) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           final TextEditingController _amountController =
//               TextEditingController();
//           return AlertDialog(
//             title: Text(
//               'Approvisionner votre code',
//               style: TextStyle(
//                 color: AppColors.blackBlue,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14.sp,
//               ),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Numéro de téléphone",
//                     style: TextStyle(
//                       color: AppColors.blackBlue,
//                       fontSize: 12.sp,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5.h),
//                 SizedBox(
//                   height: 40.h,
//                   child: TextField(
//                     enabled: false,
//                     // controller: _amountController,
//                     keyboardType: TextInputType.number,
//                     style: TextStyle(
//                       color: AppColors.blackBlue,
//                       fontSize: 14.sp,
//                       letterSpacing: 2.w,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     cursorColor: AppColors.blackBlue,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: AppColors.white,
//                       contentPadding: EdgeInsets.only(left: 15.w),
//                       hintText: "$numero",
//                       hintStyle: TextStyle(
//                           letterSpacing: 2.w,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.blackBlue),
//                       labelStyle: TextStyle(
//                         color: AppColors.blackBlueAccent1,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: AppColors.colorButton,
//                           width: 1.w,
//                         ),
//                         borderRadius: BorderRadius.circular(7.r),
//                       ),
//                       disabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: AppColors.blackBlueAccent1,
//                           width: 1.w,
//                         ),
//                         borderRadius: BorderRadius.circular(7.r),
//                       ),
//                     ),
//                     autofocus: true,
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Montant",
//                     style: TextStyle(
//                       color: AppColors.blackBlue,
//                       fontSize: 12.sp,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5.h),
//                 SizedBox(
//                   height: 40.h,
//                   child: TextField(
//                     controller: _amountController,
//                     keyboardType: TextInputType.number,
//                     style: TextStyle(
//                       color: AppColors.blackBlue,
//                       fontSize: 14.sp,
//                       letterSpacing: 2.w,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     cursorColor: AppColors.blackBlue,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: AppColors.white,
//                       contentPadding: EdgeInsets.only(left: 15.w),
//                       suffix: Padding(
//                         padding: EdgeInsets.only(right: 10.w),
//                         child: Text(
//                           'FCFA',
//                           style: TextStyle(
//                             color: AppColors.blackBlue,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp,
//                           ),
//                         ),
//                       ),
//                       hintText: "Entrez le montant",
//                       hintStyle: TextStyle(
//                           letterSpacing: 2.w,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.blackBlue.withOpacity(.3)),
//                       labelStyle: TextStyle(
//                         color: AppColors.blackBlueAccent1,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: AppColors.colorButton,
//                           width: 1.w,
//                         ),
//                         borderRadius: BorderRadius.circular(7.r),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: AppColors.blackBlueAccent1,
//                           width: 1.w,
//                         ),
//                         borderRadius: BorderRadius.circular(7.r),
//                       ),
//                     ),
//                     autofocus: true,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30.h,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(
//                           top: 5.h,
//                           bottom: 5.h,
//                           left: 20.w,
//                           right: 20.w,
//                         ),
//                         margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.r),
//                           border: Border.all(
//                             color: AppColors.colorButton,
//                           ),
//                         ),
//                         child: Text(
//                           "Annuler".tr(),
//                           style: TextStyle(
//                             color: AppColors.colorButton,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         final amount = _amountController.text;
//                         Navigator.of(context).pop(); // Close the deposit popup
//                         _showConfirmationPopup(
//                             context, amount, numero); // Show confirmation popup
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(
//                           top: 5.h,
//                           bottom: 5.h,
//                           left: 20.w,
//                           right: 20.w,
//                         ),
//                         margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.r),
//                           color: AppColors.colorButton,
//                         ),
//                         child: Text(
//                           "Continuer".tr(),
//                           style: TextStyle(
//                             color: AppColors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     }
//   }

//   static void _showConfirmationPopup(
//       BuildContext context, String amount, String numero) {
//     if (Navigator.of(context).canPop()) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               'Confirmer le depot',
//               style: TextStyle(
//                 color: AppColors.blackBlue,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14.sp,
//               ),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Approvisonnement à partir de :',
//                         style: TextStyle(
//                           color: AppColors.blackBlue,
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       Text(
//                         numero,
//                         style: TextStyle(
//                           color: AppColors.blackBlue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Montant :',
//                         style: TextStyle(
//                           color: AppColors.blackBlue,
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       Text(
//                         "${formatMontantFrancais(double.parse(amount))} FCFA",
//                         style: TextStyle(
//                           color: AppColors.blackBlue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 100.h,
//                   child: Pinput(
//                     length: 4,
//                     autofocus: true,
//                     obscureText: true,
//                     separatorBuilder: (index) {
//                       return SizedBox(
//                         width: 15.w,
//                       );
//                     },
//                     scrollPadding: EdgeInsets.all(20.r),
//                     controller: _controllerPin,
//                     defaultPinTheme: defaultPinTheme,
//                     focusedPinTheme: defaultPinTheme.copyWith(
//                       decoration: defaultPinTheme.decoration!.copyWith(
//                           border: Border.all(
//                             color: AppColors.colorButton,
//                             width: 2.w,
//                           ),
//                           borderRadius: BorderRadius.circular(10.r)),
//                     ),
//                     onCompleted: (pin) async {
//                       final enteredCode = _controllerPin.text;
//                       if (enteredCode ==
//                           AppCubitStorage().state.passWordTontinePerso) {
//                         try {
//                           isLoading = true;
//                           final payRef = await initiateDeposit(amount);
//                           _controllerPin.text = "";
//                           isLoading = false;
//                           Navigator.of(context).pop();
//                           _showWaitingPopup(context, payRef);
//                         } catch (e) {
//                           _controllerPin.text = "";
//                           isLoading = false;
//                           toastification.show(
//                             context: context,
//                             title: Text(
//                               "Une erreur est survenue veuillez réessayer".tr(),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize: 14.sp,
//                                   color: AppColors.blackBlue,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             autoCloseDuration: Duration(seconds: 3),
//                             type: ToastificationType.error,
//                             style: ToastificationStyle.minimal,
//                           );
//                           Navigator.of(context).pop();
//                         }
//                       } else {
//                         _controllerPin.text = "";
//                         toastification.show(
//                           context: context,
//                           title: Text(
//                             "PIN incorrect".tr(),
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 16.sp,
//                                 color: AppColors.blackBlue,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           autoCloseDuration: Duration(seconds: 3),
//                           type: ToastificationType.error,
//                           style: ToastificationStyle.minimal,
//                         );
//                         Navigator.of(context).pop(false);
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30.h,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(
//                           top: 5.h,
//                           bottom: 5.h,
//                           left: 20.w,
//                           right: 20.w,
//                         ),
//                         margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.r),
//                           border: Border.all(
//                             color: AppColors.colorButton,
//                           ),
//                         ),
//                         child: Text(
//                           "Annuler".tr(),
//                           style: TextStyle(
//                             color: AppColors.colorButton,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                     isLoading
//                         ? CircularProgressIndicator()
//                         : InkWell(
//                             onTap: () async {
//                               if (_controllerPin.text ==
//                                   AppCubitStorage()
//                                       .state
//                                       .passWordTontinePerso) {
//                                 // Navigator.of(context).pop();
//                                 // _showLoadingPopup(context);
//                                 try {
//                                   final payRef = await initiateDeposit(amount);
//                                   _controllerPin.text = "";
//                                   Navigator.of(context).pop();
//                                   _showWaitingPopup(context, payRef);
//                                 } catch (e) {
//                                   _controllerPin.text = "";
//                                   toastification.show(
//                                     context: context,
//                                     title: Text(
//                                       "Une erreur est survenue veuillez réessayer"
//                                           .tr(),
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 14.sp,
//                                           color: AppColors.blackBlue,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     autoCloseDuration: Duration(seconds: 3),
//                                     type: ToastificationType.error,
//                                     style: ToastificationStyle.minimal,
//                                   );
//                                   Navigator.of(context).pop();
//                                 }
//                               } else {
//                                 _controllerPin.text = "";
//                                 toastification.show(
//                                   context: context,
//                                   title: Text(
//                                     "PIN incorrect".tr(),
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontSize: 16.sp,
//                                         color: AppColors.blackBlue,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   autoCloseDuration: Duration(seconds: 3),
//                                   type: ToastificationType.error,
//                                   style: ToastificationStyle.minimal,
//                                 );
//                                 Navigator.of(context).pop(false);
//                               }
//                             },
//                             child: Container(
//                               padding: EdgeInsets.only(
//                                 top: 5.h,
//                                 bottom: 5.h,
//                                 left: 20.w,
//                                 right: 20.w,
//                               ),
//                               margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 color: AppColors.colorButton,
//                               ),
//                               child: Text(
//                                 "Continuer".tr(),
//                                 style: TextStyle(
//                                   color: AppColors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 12.sp,
//                                 ),
//                               ),
//                             ),
//                           ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     }
//   }

//   static void _showLoadingPopup(BuildContext context) {
//     if (Navigator.of(context).canPop()) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Processing'),
//             content: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(width: 20),
//                 Text('Processing your request...'),
//               ],
//             ),
//           );
//         },
//       );
//     }
//   }

//   static void _showWaitingPopup(BuildContext context, String payRef) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             String statusMessage = 'Waiting for deposit validation...';
//             String timeRemaining = '02:30';
//             Timer? countdownTimer;
//             int remainingSeconds = 150;

//             void startCountdown(Duration duration) {
//               remainingSeconds = duration.inSeconds;
//               countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//                 if (remainingSeconds <= 0) {
//                   timer.cancel();
//                   setState(() {
//                     timeRemaining = '00:00';
//                   });
//                   return;
//                 }

//                 setState(() {
//                   remainingSeconds--;
//                   final minutes = remainingSeconds ~/ 60;
//                   final seconds = remainingSeconds % 60;
//                   timeRemaining =
//                       '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//                 });
//               });
//             }

//             startCountdown(Duration(seconds: 150));

//             Future<void> checkStatus() async {
//               final endTime = DateTime.now().add(Duration(seconds: 150));
//               while (DateTime.now().isBefore(endTime)) {
//                 bool status = await checkDepositStatus(payRef);
//                 if (status) {
//                   if (Navigator.of(context).canPop()) {
//                     setState(() {
//                       statusMessage = 'Deposit validated';
//                     });
//                     countdownTimer?.cancel();
//                     return;
//                   }
//                 }
//                 await Future.delayed(Duration(seconds: 5));
//               }
//               if (Navigator.of(context).canPop()) {
//                 setState(() {
//                   statusMessage = 'Deposit not validated within the time limit';
//                 });
//               }
//             }

//             checkStatus();

//             return AlertDialog(
//               title: Text('Deposit Status'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(statusMessage),
//                   SizedBox(height: 20),
//                   Text('Time Remaining: $timeRemaining'),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     countdownTimer?.cancel();
//                   },
//                   child: Text('Close'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   static Future<String> initiateDeposit(String amount) async {
//     final url = 'https://payment.core.faroty.com/api/v1/saving-payrequest';
//     try {
//       final response = await dio.post(
//         url,
//         data: {
//           'phone': "680474835",
//           'amount': amount,
//           'public_ref': "68391A",
//           'shipping': null,
//         },
//         options: Options(headers: {
//           "username": "5d401fef-555f-4d66-b01a-14613b027393",
//           "password": "c1e7-9f-429-8005-8b86e9"
//         }),
//       );

//       return response.data["pay_ref"];
//     } catch (e) {
//       print('Error initiating deposit: $e');
//       throw Exception('Failed to initiate deposit');
//     }
//   }

//   static Future<bool> checkDepositStatus(String payRef) async {
//     final url = 'https://api.faroty.com/index.php/api/paycheck';
//     try {
//       final response = await dio.post(
//         url,
//         data: {'pay_ref': payRef},
//         options: Options(headers: {
//           "username": "5d401fef-555f-4d66-b01a-14613b027393",
//           "password": "c1e7-9f-429-8005-8b86e9"
//         }),
//       );

//       final responseData =
//           jsonDecode(response.data as String) as Map<String, dynamic>;

//       return responseData["error"] == false;
//     } catch (e) {
//       print('Error checking deposit status: $e');
//       throw Exception('Failed to check deposit status');
//     }
//   }
// }
