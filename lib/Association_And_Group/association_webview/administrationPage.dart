// import 'dart:convert';
// import 'dart:io';

// import 'package:easy_loader/easy_loader.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
// import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
// import 'package:faroty_association_1/Theming/color.dart';
// import 'package:faroty_association_1/localStorage/localCubit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class AdministrationPage extends StatefulWidget {
//   AdministrationPage({
//     super.key,
//     required this.urlPage,
//     required this.forAdmin,
//     this.forFirstPage = false,
//   });
//   String urlPage;
//   bool forAdmin;
//   bool? forFirstPage;

//   @override
//   State<AdministrationPage> createState() => _AdministrationPageState();
// }

// Widget PageScaffold({
//   required BuildContext context,
//   required Widget child,
//   required Function reload,
//   required bool forAdmin,
// }) {
//   if (Platform.isIOS) {
//     return CupertinoPageScaffold(
//       backgroundColor: AppColors.white,

//       navigationBar: CupertinoNavigationBar(
//         backgroundColor: AppColors.backgroundAppBAr,
//         middle: Text(
//           forAdmin
//               ? "${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}"
//               : "Créer un groupe ASSO+".tr(),
//           style: TextStyle(fontSize: 16.sp, color: AppColors.white),
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.close,
//             color: AppColors.white,
//             size: 20.sp,
//           ),
//         ),
//         trailing: GestureDetector(
//           onTap: () {
//             reload();
//           },
//           child: Icon(
//             Icons.abc,
//           ),
//         ),
//       ),
//       // navigationBar: CupertinoNavigationBar(
//       //   middle: Text(
//       //     "Administration".tr(),
//       //     style: TextStyle(fontSize: 16.sp, color: AppColors.white),
//       //   ),
//       //   backgroundColor: AppColors.backgroundAppBAr,
//       // ),
//       child: child,
//     );
//   }

//   return Scaffold(
//     backgroundColor: AppColors.white,
//     appBar: AppBar(
//       title: Text(
//         forAdmin
//             ? "${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}"
//             : "${"Créer un groupe ASSO+".tr()} ${context.read<AuthCubit>().state.detailUser == null ? "| fdf" : "| ${context.read<AuthCubit>().state.detailUser!["first_phone"]}"}",
//         style: TextStyle(fontSize: 16.sp, color: AppColors.white),
//       ),
//       backgroundColor: AppColors.backgroundAppBAr,
//       elevation: 0,
//       leading: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: const Icon(
//           Icons.close,
//           color: AppColors.white,
//         ),
//       ),
//     ),
//     body: child,
//   );
// }

// class _AdministrationPageState extends State<AdministrationPage> {
//   final GlobalKey webViewKey = GlobalKey();

//   bool cookiesSetted = true;
//   bool pageRefreshed = false;

//   String userDataFromWebView = 'null';

//   WebViewController webViewController = WebViewController();

//   InAppWebViewController? inAppWebViewController;

//   InAppWebViewSettings settings = InAppWebViewSettings(
//     isInspectable: kDebugMode,
//     mediaPlaybackRequiresUserGesture: false,
//     allowsInlineMediaPlayback: true,
//     iframeAllow: "camera; microphone",
//     iframeAllowFullscreen: true,
//   );

//   PullToRefreshController? pullToRefreshController;
//   String inAppUrl = "";
//   double inAppProgress = 0;
//   final inAppUrlController = TextEditingController();

//   late final WebViewCookieManager cookieManager = WebViewCookieManager();

// // get the CookieManager instance
//   CookieManager _cookieManager = CookieManager.instance();

//   Future<void> reload() async {
//     return webViewController.reload();
//   }

//   // Future<void> _onSetCookie(context) async {
//   //   // await _onClearCookies(context);
//   //   await cookieManager.setCookie(
//   //     WebViewCookie(
//   //       // name: 'user_data',
//   //       name: 'rush_user_data',
//   //       value:
//   //           // "hhhhh",

//   //           json.encode(
//   //         {
//   //           "user": {
//   //             "id": null,
//   //             "hash_id": "73fade63-de3f-4072-bb97-016df10547fe",
//   //             "parent_id": null,
//   //             "country_id": "1",
//   //             "country_name": "CAMEROON",
//   //             "currency_id": "1",
//   //             "currency_name": "XAF",
//   //             "location_id": null,
//   //             "location_name": "",
//   //             "token": null,
//   //             "go_token": null,
//   //             "api_token": "b5d282dd-0f04-4a36-81cf-1ba63cd49509",
//   //             "phonecode": "237",
//   //             "phone": "680474835",
//   //             "phonenumber": "237680474835",
//   //             "email": "kengnedjoussehulot@gmail.com",
//   //             "username": "28fb8679-65e1-4bda-959b-b52c0dbb508e",
//   //             "password": null,
//   //             "balance": "480.65",
//   //             "sms_balance": "0",
//   //             "withdrawn_amount_one_time": "100000",
//   //             "cumul_withdrawn_amount_per_day": "250000",
//   //             "cumul_withdrawn_amount_today": 0,
//   //             "tx_over_withdraw": "0.003",
//   //             "amount_tx_over_withdraw": "75000",
//   //             "fees_amount_over_withdraw": "450",
//   //             "daily_withdrawal_has_fees": 0,
//   //             "name": "KENGNE DJOUSSE Hulot",
//   //             "anniversary": "2002-08-05",
//   //             "localisation": null,
//   //             "quartier": null,
//   //             "biography": null,
//   //             "lang": "fr",
//   //             "gender": "-1",
//   //             "profil_photo_base64": null,
//   //             "profil_photo_url":
//   //                 "https://api.faroty.com/images/avatar/avatar.png",
//   //             "create_date": "1676013880",
//   //             "is_confirm": "1",
//   //             "is_wallet_confirm": "1",
//   //             "confirm_date": "1676014031",
//   //             "confirm_wallet_date": null,
//   //             "profil": "0",
//   //             "status": "1",
//   //             "nbcontacts": "0",
//   //             "nbfollowers": "0",
//   //             "nbfollows": "0",
//   //             "last_seen": "2",
//   //             "birthday_seen": "2",
//   //             "status_seen": "2",
//   //             "phonenumber_seen": "2",
//   //             "faroti_seen": "1",
//   //             "faroti_location_seen": "1",
//   //             "faroti_deposit_seen": "2",
//   //             "faroti_media_seen": "3",
//   //             "utc": "1",
//   //             "degree": 0,
//   //             "phonenumbers":
//   //                 "237692665224,237656083020,237695605617,237680474835",
//   //             "isOwner": 0,
//   //             "has_kyc": "1",
//   //             "isBlocked": 0,
//   //             "blocked_date": null,
//   //             "isMsgBlocked": 0,
//   //             "msg_blocked_date": null,
//   //             "pin_to_see_balance": "0",
//   //             "ask_pin_every_min": "5",
//   //             "disconnect_user": 0,
//   //             "has_page": 1,
//   //             "pages": ["1hg085k6h"]
//   //           },
//   //           "api_token": "b5d282dd-0f04-4a36-81cf-1ba63cd49509",
//   //           "api_password": "c2f8-0f-405-8046-1c7731",
//   //           "error": false
//   //         },
//   //       ),

//   //       // domain: '.faroty.com',
//   //       domain: '.rush.faroty.com',
//   //       // path: '/anything',
//   //     ),
//   //   );

//   //   // await webViewController.loadRequest(Uri.parse(
//   //   //   'https://group.rush.faroty.com/',
//   //   // ));
//   //   await _onListCookies(context);
//   //   // await reload();
//   // }

//   // Future<void> _onListCookies(BuildContext context) async {
//   //   final String cookies = await webViewController
//   //       .runJavaScriptReturningResult('document.cookie') as String;
//   //   if (context.mounted) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         duration: const Duration(seconds: 60),
//   //         content: Column(
//   //           mainAxisAlignment: MainAxisAlignment.end,
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: <Widget>[
//   //             const Text('Cookies:'),
//   //             _getCookieList(cookies),
//   //           ],
//   //         ),
//   //       ),
//   //     );
//   //   }
//   // }

//   // Future<void> _onClearCookies(BuildContext context) async {
//   //   final bool hadCookies = await cookieManager.clearCookies();
//   //   String message = 'There were cookies. Now, they are gone!';
//   //   if (!hadCookies) {
//   //     message = 'There are no cookies.';
//   //   }
//   //   if (context.mounted) {
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: Text(message),
//   //     ));
//   //   }
//   // }

//   // Widget _getCookieList(String cookies) {
//   //   if (cookies == '""') {
//   //     return Container();
//   //   }
//   //   final List<String> cookieList = cookies.split(';');
//   //   final Iterable<Text> cookieWidgets =
//   //       cookieList.map((String cookie) => Text(cookie));
//   //   return Column(
//   //     mainAxisAlignment: MainAxisAlignment.end,
//   //     mainAxisSize: MainAxisSize.min,
//   //     children: cookieWidgets.toList(),
//   //   );
//   // }

//   @override
//   void initState() {
//     super.initState();

//     print('START --> AppCubitStorage().state.codeAssDefaul');
//     print(AppCubitStorage().state.codeAssDefaul);
//     print('END --> AppCubitStorage().state.codeAssDefaul');

//     pullToRefreshController = kIsWeb
//         ? null
//         : PullToRefreshController(
//             onRefresh: () async {
//               if (defaultTargetPlatform == TargetPlatform.android) {
//                 inAppWebViewController?.reload();
//               } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//                 inAppWebViewController?.loadUrl(
//                   urlRequest: URLRequest(
//                     url: await inAppWebViewController?.getUrl(),
//                   ),
//                 );
//               }
//             },
//           );

//     _cookieManager.deleteCookie(
//       name: 'user_data',
//       // url: Uri.parse('https://faroty.com'),
//       url: WebUri('https://faroty.com'),
//     );

//     if (AppCubitStorage().state.tokenUser != null &&
//         AppCubitStorage().state.codeAssDefaul != null) {
//       // setCookies();
//     } else {
//       print('On efface ici');
//       cookieManager.clearCookies();
//     }

//     if (widget.forAdmin) {
//       print(
//           " AppCubitStorage().state.codeAssDefaul ${AppCubitStorage().state.codeAssDefaul}");
//       print(
//           " AppCubitStorage().state.tokenUser} ${context.read<AuthCubit>().state.getUid!}");
//       print(
//           "AppCubitStorage().state.userNameKey ${AppCubitStorage().state.tokenUser}");
//       print(
//           "AppCubitStorage().state.passwordKey ${AppCubitStorage().state.passwordKey}");
//     }
//   }

//   void setCookies() async {
//     // set the expiration date for the cookie in milliseconds
//     final expiresDate =
//         DateTime.now().add(const Duration(days: 3)).millisecondsSinceEpoch;

//     await _cookieManager.setCookie(
//       expiresDate: expiresDate,
//       // isHttpOnly: true,
//       domain: '.faroty.com',
//       isSecure: true,
//       sameSite: HTTPCookieSameSitePolicy.NONE,
//       // webViewController: inAppWebViewController,
//       // name: 'rush_user_data',
//       name: 'user_data',
//       value: context.read<AuthCubit>().state.getUid!,
//       // domain: '.rush.faroty.com',
//       url: WebUri(widget.urlPage),
//       // url: Uri.parse('https://faroty.com'),
//     );

//     setState(
//       () {
//         cookiesSetted = true;
//       },
//     );
//   }

//   String get dataForCookies {
//     if (context.read<AuthCubit>().state.getUid == null) return '';

//     Map<String, dynamic> data = json.decode(userDataFromWebView) ??
//         json.decode(context.read<AuthCubit>().state.getUid!);

//     // if (data == null) {
//     //   return '';
//     // }

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

//   String get currentUrlCode {
//     return AppCubitStorage().state.codeAssDefaul ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageScaffold(
//       forAdmin: widget.forAdmin,
//       reload: reload,
//       context: context,
//       child: Stack(
//         children: [
//           if (cookiesSetted)
//             InAppWebView(
//               key: webViewKey,
//               initialUrlRequest: URLRequest(
//                 headers: {"token": "${AppCubitStorage().state.tokenUser}"},
//                 url: WebUri(
//                   widget.forFirstPage! == true
//                       ?
//                       // 'https://auth.rush.faroty.com/hello.html?callback=${widget.urlPage}?source=mobile':
//                       // 'https://auth.rush.faroty.com/hello.html?user_data=${dataForCookies}&callback=${widget.urlPage}?source=mobile',
//                       'https://auth.faroty.com/hello.html?user_data=${dataForCookies}&callback=${widget.urlPage}?source=mobile'
//                       : 'https://auth.faroty.com/hello.html?user_data=${dataForCookies}&group_current_page=${currentUrlCode}&callback=${widget.urlPage}?source=mobile',
//                 ),
//               ),
//               initialSettings: settings,
//               pullToRefreshController: pullToRefreshController,
//               onWebViewCreated: (controller) {
//                 inAppWebViewController = controller;

//                 controller.addJavaScriptHandler(
//                     handlerName: 'my_auth_tokens',
//                     callback: (args) {
//                       String userData = args[0];
//                       print('userData');
//                       print(userData);

//                       setState(() {
//                         userDataFromWebView = userData;
//                       });
//                       return {'success': true};
//                     });
//                 // print(
//                 //   '${context.read<AuthCubit>().state.getUid!}',
//                 // );
//               },
//               onLoadStart: (controller, url) {
//                 print('Commence à tourner');
//                 setState(
//                   () {
//                     this.inAppUrl = url.toString();
//                     inAppUrlController.text = this.inAppUrl;
//                   },
//                 );
//               },
//               onPermissionRequest: (controller, request) async {
//                 return PermissionResponse(
//                   resources: request.resources,
//                   action: PermissionResponseAction.GRANT,
//                 );
//               },
//               // shouldOverrideUrlLoading: (controller, navigationAction) async {
//               //   var uri = navigationAction.request.url!;

//               //   if (![
//               //     "http",
//               //     "https",
//               //     "file",
//               //     "chrome",
//               //     "data",
//               //     "javascript",
//               //     "about"
//               //   ].contains(uri.scheme)) {
//               //     if (await canLaunchUrl(uri)) {
//               //       // Launch the App
//               //       await launchUrl(
//               //         uri,
//               //       );
//               //       // and cancel the request
//               //       return NavigationActionPolicy.CANCEL;
//               //     }
//               //   }

//               //   return NavigationActionPolicy.ALLOW;
//               // },

//               onLoadStop: (controller, url) async {
//                 pullToRefreshController?.endRefreshing();
//                 setState(
//                   () {
//                     this.inAppUrl = url.toString();
//                     inAppUrlController.text = this.inAppUrl;
//                   },
//                 );
//               },

//               onReceivedError: (controller, request, error) {
//                 pullToRefreshController?.endRefreshing();
//               },

//               onProgressChanged: (controller, progress) async {
//                 print('Progress $progress');
//                 setState(() {
//                   this.inAppProgress = progress / 100;
//                   inAppUrlController.text = this.inAppUrl;
//                 });
//                 if (progress == 100) {
//                   if (!pageRefreshed) {
//                     await Future.delayed(Duration(seconds: 5));

//                     if (Platform.isAndroid) {
//                       controller.reload();
//                     } else if (Platform.isIOS) {
//                       controller.loadUrl(
//                           urlRequest:
//                               URLRequest(url: await controller.getUrl()));
//                     }
//                     setState(() {
//                       pageRefreshed = true;
//                     });
//                   }

//                   pullToRefreshController?.endRefreshing();
//                 }
//               },

//               onUpdateVisitedHistory: (controller, url, androidIsReload) {
//                 setState(
//                   () {
//                     this.inAppUrl = url.toString();
//                     inAppUrlController.text = this.inAppUrl;
//                   },
//                 );
//               },

//               onConsoleMessage: (controller, consoleMessage) {
//                 if (kDebugMode) {
//                   print(consoleMessage);
//                 }
//               },
//             ),
//           if (inAppProgress < 1 || !pageRefreshed)
//             Positioned(
//               top: 0,
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 color: AppColors.white,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: EasyLoader(
//                         backgroundColor: const Color.fromARGB(0, 255, 255, 255),
//                         iconSize: 50.r,
//                         iconColor: AppColors.blackBlueAccent1,
//                         image: const AssetImage(
//                           "assets/images/AssoplusFinal.png",
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 20, right: 20),
//                       child: LinearProgressIndicator(
//                         backgroundColor: AppColors.blackBlueAccent1,
//                         color: AppColors.colorButton,
//                         value: inAppProgress,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
