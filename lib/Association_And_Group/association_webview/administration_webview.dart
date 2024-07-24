// import 'dart:convert';
// import 'dart:io';

// import 'package:auto_route/auto_route.dart';
// import 'package:easy_loader/easy_loader.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
// import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
// import 'package:faroty_association_1/Theming/color.dart';
// import 'package:faroty_association_1/localStorage/localCubit.dart';
// import 'package:faroty_association_1/pages/home_centrale_screen.dart';
// import 'package:faroty_association_1/routes/app_router.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class AdministrationPageWebview extends StatefulWidget {
//   AdministrationPageWebview({
//     super.key,
//     this.forFirstPage = false,
//     required this.urlPage,
//     required this.forAdmin,
//   });
//   bool? forFirstPage;
//   String urlPage;
//   bool forAdmin;

//   @override
//   State<AdministrationPageWebview> createState() =>
//       _AdministrationPageWebviewState();
// }

// class _AdministrationPageWebviewState extends State<AdministrationPageWebview> {
//   Widget PageScaffold({
//     required BuildContext context,
//     required Widget child,
//     required bool forAdmin,
//     required bool forFirstPage,
//   }) {
//     if (Platform.isIOS) {
//       return CupertinoPageScaffold(
//         backgroundColor: AppColors.white,
//         navigationBar: CupertinoNavigationBar(
//           middle: Text(
//             forAdmin
//                 ? "${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}"
//                 : "${"Créer un groupe ASSO+".tr()}",
//             style: TextStyle(fontSize: 16.sp, color: AppColors.white),
//           ),
//           backgroundColor: AppColors.backgroundAppBAr,
//           leading: InkWell(
//             onTap: () async {
//               if (context.read<AuthCubit>().state.loginInfo != null &&
//                   forFirstPage == true) {
//                 setState(() {
//                   isLoadToGoApp = true;
//                 });

//                 var loginInfo = await context.read<AuthCubit>().state.loginInfo;

//                 await AppCubitStorage()
//                     .updateCodeAssDefaul(loginInfo!.userGroup!.first.urlcode!);
//                 await AppCubitStorage().updateTokenUser(loginInfo.token!);
//                 await AppCubitStorage()
//                     .updatemembreCode(loginInfo.user!.membre_code!);
//                 await AppCubitStorage().updateCodeTournoisDefault(
//                     loginInfo.tournoi!.tournois_code!);
//                 await AppCubitStorage().updateuserNameKey(loginInfo.username!);
//                 await AppCubitStorage().updatepasswordKey(loginInfo.password!);
//                 await context
//                     .read<UserGroupCubit>()
//                     .AllUserGroupOfUserCubit(loginInfo.token);

//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(
//                     builder: (BuildContext context) => HomeCentraleScreen(),
//                   ),
//                   (route) => false,
//                 );
//                 setState(() {
//                   isLoadToGoApp = false;
//                 });
//               } else {
//                 Navigator.pop(context);
//               }
//             },
//             child: Container(
//               color: AppColors.backgroundAppBAr,
//               child: SvgPicture.asset(
//                 "assets/images/closeIcon.svg",
//                 fit: BoxFit.scaleDown,
//                 color: AppColors.white,
//               ),
//             ),
//           ),
//         ),
//         child: child,
//       );
//     }

//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         title: Text(
//           forAdmin
//               ? "${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}"
//               : "${"Créer un groupe ASSO+".tr()}",
//           style: TextStyle(fontSize: 16.sp, color: AppColors.white),
//         ),
//         backgroundColor: AppColors.backgroundAppBAr,
//         elevation: 0,
//         leading: InkWell(
//           onTap: () async {
//             if (context.read<AuthCubit>().state.loginInfo != null &&
//                 forFirstPage == true) {
//               setState(() {
//                 isLoadToGoApp = true;
//               });
//               var loginInfo = await context.read<AuthCubit>().state.loginInfo;
//               print("${loginInfo}");
//               // await AppCubitStorage()
//               //     .updateCodeAssDefaul(loginInfo!.userGroup!.first.urlcode!);
//               // await AppCubitStorage().updateTokenUser(loginInfo.token!);
//               // await AppCubitStorage()
//               //     .updatemembreCode(loginInfo.user!.membre_code!);
//               // await AppCubitStorage()
//               //     .updateCodeTournoisDefault(loginInfo.tournoi!.tournois_code!);
//               // await AppCubitStorage().updateuserNameKey(loginInfo.username!);
//               // await AppCubitStorage().updatepasswordKey(loginInfo.password!);
//               // await context
//               //     .read<UserGroupCubit>()
//               //     .AllUserGroupOfUserCubit(loginInfo.token);

//               // Navigator.of(context).pushAndRemoveUntil(
//               //   MaterialPageRoute(
//               //     builder: (BuildContext context) => HomeCentraleScreen(),
//               //   ),
//               //   (route) => false,
//               // );
//               // setState(() {
//               //   isLoadToGoApp = false;
//               // });
//             } else {
//               var loginInfo = await context.read<AuthCubit>().state.loginInfo;
//               print("${loginInfo}");
//               Navigator.pop(context);
//             }
//           },
//           child: Container(
//             color: AppColors.backgroundAppBAr,
//             child: SvgPicture.asset(
//               "assets/images/closeIcon.svg",
//               fit: BoxFit.scaleDown,
//               color: AppColors.white,
//             ),
//           ),
//         ),
//       ),
//       body: child,
//     );
//   }

//   late final WebViewController _controller;
//   int progression = 0;
//   String userDataFromWebView = 'null';
//   bool isLoadToGoApp = false;

//   Future<void> handleConfirmation(api_token, api_password) async {
//     context
//         .read<AuthCubit>()
//         .loginInfoConnectToWebViewFirst(api_token, api_password);
//     print("object");
//   }

//   String get dataForCookies {
//     if (context.read<AuthCubit>().state.getUid == null) return '';

//     Map<String, dynamic> data = json.decode(userDataFromWebView) ??
//         json.decode(context.read<AuthCubit>().state.getUid!);

//     return json.encode(
//       {
//         "user": {
//           "is_confirm": data['user']['is_confirm'],
//           "is_wallet_confirm": data['user']['is_wallet_confirm'],
//           "hash_id": data['user']['hashid'],
//         },
//         "api_token": data['api_token'],
//         "api_password": data['api_password']
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setOnConsoleMessage(
//         (message) async {
//           print("Le message du logg ${message.message}");
//           if (message.message.startsWith("for-mobile ")) {
//             String userData = message.message.split("for-mobile ")[1];
//             final userDataMap = jsonDecode(userData);
//             // print("====== ${userDataMap["api_token"]}");
//             // print("====== ${userDataMap["api_password"]}");
//             await (
//               userDataMap["api_token"],
//               userDataMap["api_password"],
//             );

//             setState(() {
//               userDataFromWebView = userData;
//             });
//           }
//         },
//       )
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             print("hfhhhhhh${progress}");
//             setState(() {
//               progression = progress;
//             });
//           },
//         ),
//       )
//       ..loadRequest(
//         Uri.parse(
//           widget.forFirstPage! == true
//               ? 'https://auth.faroty.com/hello.html?user_data=${dataForCookies}&callback=https://business.faroty.com/groups&app_mode=mobile'
//               : 'https://auth.faroty.com/hello.html?user_data=${dataForCookies}&group_current_page=${currentUrlCode}&callback=${widget.urlPage}&app_mode=mobile',
//         ),
//       );
//   }

//   String get currentUrlCode {
//     return AppCubitStorage().state.codeAssDefaul ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageScaffold(
//       context: context,
//       forAdmin: widget.forAdmin,
//       forFirstPage: widget.forFirstPage!,
//       child: WillPopScope(
//         // canPop: false,
//         onWillPop: () async {
//           if (context.read<AuthCubit>().state.loginInfo != null &&
//               widget.forFirstPage == true) {
//             setState(() {
//               isLoadToGoApp = true;
//             });
//             var loginInfo = await context.read<AuthCubit>().state.loginInfo;

//             await AppCubitStorage()
//                 .updateCodeAssDefaul(loginInfo!.userGroup!.first.urlcode!);
//             await AppCubitStorage().updateTokenUser(loginInfo.token!);
//             await AppCubitStorage()
//                 .updatemembreCode(loginInfo.user!.membre_code!);
//             await AppCubitStorage()
//                 .updateCodeTournoisDefault(loginInfo.tournoi!.tournois_code!);
//             await AppCubitStorage().updateuserNameKey(loginInfo.username!);
//             await AppCubitStorage().updatepasswordKey(loginInfo.password!);
//             await context
//                 .read<UserGroupCubit>()
//                 .AllUserGroupOfUserCubit(loginInfo.token);

//             Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                 builder: (BuildContext context) => HomeCentraleScreen(),
//               ),
//               (route) => false,
//             );
//             setState(() {
//               isLoadToGoApp = false;
//             });
//             return true;
//           } else {
//             Navigator.pop(context);
//             return true;
//           }
//         },
//         child: progression < 100
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: EasyLoader(
//                         backgroundColor: Color.fromARGB(0, 255, 255, 255),
//                         iconSize: 50.r,
//                         iconColor: AppColors.blackBlueAccent1,
//                         image: AssetImage(
//                           "assets/images/AssoplusFinal.png",
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(left: 20.w, right: 20.w),
//                       child: LinearProgressIndicator(
//                         backgroundColor: AppColors.blackBlueAccent1,
//                         color: AppColors.colorButton,
//                         value: (progression / 100).toDouble(),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : Stack(
//                 children: [
//                   WebViewWidget(controller: _controller),
//                   if (isLoadToGoApp)
//                     Container(
//                       child: EasyLoader(
//                         backgroundColor: Color.fromARGB(0, 255, 255, 255),
//                         iconSize: 50.r,
//                         iconColor: AppColors.blackBlueAccent1,
//                         image: AssetImage(
//                           "assets/images/AssoplusFinal.png",
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
