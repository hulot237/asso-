// import 'dart:convert';
// import 'dart:io';

// import 'package:easy_loader/easy_loader.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:faroty_association_1/Theming/color.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class CreateNewAssPage extends StatefulWidget {
//   CreateNewAssPagePage({super.key, required this.lienDePaiement});
//   String lienDePaiement;

//   @override
//   State<AdministrationPage> createState() => _AdministrationPageState();
// }

// Widget PageScaffold({
//   required BuildContext context,
//   required Widget child,
//   required Function reload,
// }) {
//   if (Platform.isIOS) {
//     return CupertinoPageScaffold(
//       backgroundColor: AppColors.white,

//       navigationBar: CupertinoNavigationBar(
//         backgroundColor: AppColors.backgroundAppBAr,
//         middle: Text(
//           "Nouveau groupe",
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
//       child: child,
//     );
//   }

//   return Scaffold(
//     backgroundColor: AppColors.white,
//     appBar: AppBar(
//       title: Text(
//         "Nouveau groupe",
//         style: TextStyle(fontSize: 16.sp, color: AppColors.white),
//       ),
//       backgroundColor: AppColors.backgroundAppBAr,
//       elevation: 0,
//       leading: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Icon(
//           Icons.close,
//           color: AppColors.white,
//         ),
//       ),
//       actions: [Icon(Icons.r_mobiledata)],
//     ),
//     body: child,
//   );
// }

// class _AdministrationPageState extends State<AdministrationPage> {
//   int progression = 0;
//   WebViewController webViewController = WebViewController();
//   late final WebViewCookieManager cookieManager = WebViewCookieManager();

//   Future<void> reload() async {
//     return webViewController.reload();
//   }

//   Future<void> _onSetCookie(context) async {
//     // await _onClearCookies(context);
//     await cookieManager.setCookie(
//       WebViewCookie(
//         name: 'user_data',
//         value:
//             // "hhhhh",

//             json.encode(
//           {
//             "user": {
//               "id": null,
//               "hash_id": "73fade63-de3f-4072-bb97-016df10547fe",
//               "parent_id": null,
//               "country_id": "1",
//               "country_name": "CAMEROON",
//               "currency_id": "1",
//               "currency_name": "XAF",
//               "location_id": null,
//               "location_name": "",
//               "token": null,
//               "go_token": null,
//               "api_token": "b5d282dd-0f04-4a36-81cf-1ba63cd49509",
//               "phonecode": "237",
//               "phone": "680474835",
//               "phonenumber": "237680474835",
//               "email": "kengnedjoussehulot@gmail.com",
//               "username": "28fb8679-65e1-4bda-959b-b52c0dbb508e",
//               "password": null,
//               "balance": "480.65",
//               "sms_balance": "0",
//               "withdrawn_amount_one_time": "100000",
//               "cumul_withdrawn_amount_per_day": "250000",
//               "cumul_withdrawn_amount_today": 0,
//               "tx_over_withdraw": "0.003",
//               "amount_tx_over_withdraw": "75000",
//               "fees_amount_over_withdraw": "450",
//               "daily_withdrawal_has_fees": 0,
//               "name": "KENGNE DJOUSSE Hulot",
//               "anniversary": "2002-08-05",
//               "localisation": null,
//               "quartier": null,
//               "biography": null,
//               "lang": "fr",
//               "gender": "-1",
//               "profil_photo_base64": null,
//               "profil_photo_url":
//                   "https://api.faroty.com/images/avatar/avatar.png",
//               "create_date": "1676013880",
//               "is_confirm": "1",
//               "is_wallet_confirm": "1",
//               "confirm_date": "1676014031",
//               "confirm_wallet_date": null,
//               "profil": "0",
//               "status": "1",
//               "nbcontacts": "0",
//               "nbfollowers": "0",
//               "nbfollows": "0",
//               "last_seen": "2",
//               "birthday_seen": "2",
//               "status_seen": "2",
//               "phonenumber_seen": "2",
//               "faroti_seen": "1",
//               "faroti_location_seen": "1",
//               "faroti_deposit_seen": "2",
//               "faroti_media_seen": "3",
//               "utc": "1",
//               "degree": 0,
//               "phonenumbers":
//                   "237692665224,237656083020,237695605617,237680474835",
//               "isOwner": 0,
//               "has_kyc": "1",
//               "isBlocked": 0,
//               "blocked_date": null,
//               "isMsgBlocked": 0,
//               "msg_blocked_date": null,
//               "pin_to_see_balance": "0",
//               "ask_pin_every_min": "5",
//               "disconnect_user": 0,
//               "has_page": 1,
//               "pages": ["1hg085k6h"]
//             },
//             "api_token": "b5d282dd-0f04-4a36-81cf-1ba63cd49509",
//             "api_password": "c2f8-0f-405-8046-1c7731",
//             "error": false
//           },
//         ),

//         domain: '.faroty.com',
//         // path: '/anything',
//       ),
//     );

//     // await webViewController.loadRequest(Uri.parse(
//     //   'https://group.rush.faroty.com/',
//     // ));
//     await _onListCookies(context);
//     // await reload();
//   }

//   Future<void> _onListCookies(BuildContext context) async {
//     final String cookies = await webViewController
//         .runJavaScriptReturningResult('document.cookie') as String;
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           duration: Duration(seconds: 60),
//           content: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               const Text('Cookies:'),
//               _getCookieList(cookies),
//             ],
//           ),
//         ),
//       );
//     }
//   }

//   Future<void> _onClearCookies(BuildContext context) async {
//     final bool hadCookies = await cookieManager.clearCookies();
//     String message = 'There were cookies. Now, they are gone!';
//     if (!hadCookies) {
//       message = 'There are no cookies.';
//     }
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(message),
//       ));
//     }
//   }

//   Widget _getCookieList(String cookies) {
//     if (cookies == '""') {
//       return Container();
//     }
//     final List<String> cookieList = cookies.split(';');
//     final Iterable<Text> cookieWidgets =
//         cookieList.map((String cookie) => Text(cookie));
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       mainAxisSize: MainAxisSize.min,
//       children: cookieWidgets.toList(),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     cookieManager.setCookie(
//       WebViewCookie(
//         name: 'user_data',
//         value:
//             // "hhhhh",

//             json.encode(
//           {
//             "user": {
//               "id": null,
//               "hash_id": "73fade63-de3f-4072-bb97-016df10547fe",
//               "parent_id": null,
//               "country_id": "1",
//               "country_name": "CAMEROON",
//               "currency_id": "1",
//               "currency_name": "XAF",
//               "location_id": null,
//               "location_name": "",
//               "token": null,
//               "go_token": null,
//               "api_token": "b5d282dd-0f04-4a36-81cf-1ba63cd49509",
//               "phonecode": "237",
//               "phone": "680474835",
//               "phonenumber": "237680474835",
//               "email": "kengnedjoussehulot@gmail.com",
//               "username": "28fb8679-65e1-4bda-959b-b52c0dbb508e",
//               "password": null,
//               "balance": "480.65",
//               "sms_balance": "0",
//               "withdrawn_amount_one_time": "100000",
//               "cumul_withdrawn_amount_per_day": "250000",
//               "cumul_withdrawn_amount_today": 0,
//               "tx_over_withdraw": "0.003",
//               "amount_tx_over_withdraw": "75000",
//               "fees_amount_over_withdraw": "450",
//               "daily_withdrawal_has_fees": 0,
//               "name": "KENGNE DJOUSSE Hulot",
//               "anniversary": "2002-08-05",
//               "localisation": null,
//               "quartier": null,
//               "biography": null,
//               "lang": "fr",
//               "gender": "-1",
//               "profil_photo_base64": null,
//               "profil_photo_url":
//                   "https://api.faroty.com/images/avatar/avatar.png",
//               "create_date": "1676013880",
//               "is_confirm": "1",
//               "is_wallet_confirm": "1",
//               "confirm_date": "1676014031",
//               "confirm_wallet_date": null,
//               "profil": "0",
//               "status": "1",
//               "nbcontacts": "0",
//               "nbfollowers": "0",
//               "nbfollows": "0",
//               "last_seen": "2",
//               "birthday_seen": "2",
//               "status_seen": "2",
//               "phonenumber_seen": "2",
//               "faroti_seen": "1",
//               "faroti_location_seen": "1",
//               "faroti_deposit_seen": "2",
//               "faroti_media_seen": "3",
//               "utc": "1",
//               "degree": 0,
//               "phonenumbers":
//                   "237692665224,237656083020,237695605617,237680474835",
//               "isOwner": 0,
//               "has_kyc": "1",
//               "isBlocked": 0,
//               "blocked_date": null,
//               "isMsgBlocked": 0,
//               "msg_blocked_date": null,
//               "pin_to_see_balance": "0",
//               "ask_pin_every_min": "5",
//               "disconnect_user": 0,
//               "has_page": 1,
//               "pages": ["1hg085k6h"]
//             },
//             "api_token": "b5d282dd-0f04-4a36-81cf-1ba63cd49509",
//             "api_password": "c2f8-0f-405-8046-1c7731",
//             "error": false
//           },
//         ),

//         domain: '.faroty.com',
//         // path: '/anything',
//       ),
//     );
//     webViewController
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           // onPageFinished: (url) async {
//           //   await _onSetCookie(context);
//           // },
//           onProgress: (int progress) async {
//             print("progress  ${progress}");
//             setState(() {
//               progression = progress;
//             });
//             print("progression  ${progression}");

//             // if (progression == 100) {
//             //   await _onSetCookie(context);
//             //   print(
//             //       "objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject");
//             // }
//           },
//           // onPageStarted: (String url) async {
//           //   debugPrint(
//           //       'Page started loadingrrrrrrrrrrrrrrrrrrrrrrrrrrrrr: $url');
//           // },
//           // onPageFinished: (String url) async {
//           //   await _onSetCookie(context);
//           //   debugPrint(
//           //       'Page finished loading ttttttttttttttttttttttttttt: $url');
//           // },
//           //         onWebResourceError: (WebResourceError error) {
//           //           debugPrint('''
//           // Page resource error:
//           // code: ${error.errorCode}
//           // description: ${error.description}
//           // errorType: ${error.errorType}
//           // isForMainFrame: ${error.isForMainFrame}
//           //         ''');
//           //         },
//           // onNavigationRequest: (NavigationRequest request) {
//           //   if (request.url.startsWith('https://group.rush.faroty.com/')) {
//           //     debugPrint('blocking navigation to ${request.url}');
//           //     return NavigationDecision.prevent;
//           //   }
//           //   debugPrint('allowing navigation to ${request.url}');
//           //   return NavigationDecision.navigate;
//           // },
//           // onUrlChange: (UrlChange change) {
//           //   debugPrint('url change to ${change.url}');
//           // },
//           // onHttpAuthRequest: (HttpAuthRequest request) {
//           //   openDialog(request);
//           // },
//         ),
//       )
//       // ..addJavaScriptChannel(
//       //   'Toaster',
//       //   onMessageReceived: (JavaScriptMessage message) {
//       //     ScaffoldMessenger.of(context).showSnackBar(
//       //       SnackBar(content: Text(message.message)),
//       //     );
//       //   },
//       // )
//       ..loadRequest(
//         Uri.parse('https://groups.faroty.com'),
//         // Uri.parse('https://business.faroty.com/group'),
//         // headers: {
//         //   "password": "96efca8d-1a7c-48dd-8c26-1f82dfbd7c49",
//         //   "username": "834da76a-246d-4b19-b143-3befd02891a1"
//         // },
//       );
//     cookieManager.setCookie(
//       WebViewCookie(
//         name: 'user_data',
//         value:
//             // "hhhhh",

//             json.encode(
//           {
//             "user": {
//               "id": 23586,
//               "parent_id": null,
//               "admin_id": null,
//               "country_id": 1,
//               "currency_id": 1,
//               "location_id": null,
//               "profil_id": null,
//               "balance": 2242.46,
//               "sms_balance": 0,
//               "devise_country_iso3": "cm",
//               "token":
//                   "d6EVQeUik3c:APA91bETkRsEhWhzEJnrfOxkNpWreuQDFqJAr2dXDwThywaDD93tZhTsmCZm6DFXUuOam_jNj5cOics0YTYty7rhO8qavKkaEgXdqWNVoG10avn8tWKXxYsPbHYPrsgkEhUDj0IkSbC8",
//               "go_token": null,
//               "hashid": "73fade63-de3f-4072-bb97-016df10547fe",
//               "phonenumber": "237680474835",
//               "phone": "680474835",
//               "username": "28fb8679-65e1-4bda-959b-b52c0dbb508e",
//               "password": null,
//               "wallet_password": "e82c4b19b8151ddc25d4d93baf7b908f",
//               "api_password": "96efca8d-1a7c-48dd-8c26-1f82dfbd7c49",
//               "api_auth_password": null,
//               "name": "Hulot",
//               "anniversary": "2002-08-04T23:00:00.000Z",
//               "email": "kengnedjoussehulot@gmail.com",
//               "localisation": null,
//               "biography": null,
//               "quartier": null,
//               "lang": "fr",
//               "utc": 1,
//               "gender": -1,
//               "profil_photo_base64": null,
//               "profil_photo_url":
//                   "https://api.faroty.com/images/avatar/avatar.png",
//               "create_date": 1676013880,
//               "is_confirm": 1,
//               "is_wallet_confirm": 1,
//               "has_kyc": 1,
//               "kyc_date": 1691047960,
//               "confirm_date": 1676014031,
//               "confirm_wallet_date": null,
//               "last_update_time": 1708584390,
//               "profil_type": 0,
//               "api_fees": 0,
//               "versioncode": 986,
//               "appname": "android",
//               "save_money_date": 1702410361,
//               "save_money_password": "e82c4b19b8151ddc25d4d93baf7b908f",
//               "save_money_question": null,
//               "save_money_answord": null,
//               "transaction_suspended": 0,
//               "mycollect_suspended": 0,
//               "status": 1,
//               "nbcontacts": 0,
//               "nbfollowers": 0,
//               "nbfollows": 0,
//               "nbfaroters": 0,
//               "last_seen": 2,
//               "birthday_seen": 2,
//               "status_seen": 2,
//               "phonenumber_seen": 2,
//               "faroti_seen": 1,
//               "faroti_location_seen": 1,
//               "faroti_deposit_seen": 2,
//               "faroti_media_seen": 3,
//               "pin_to_see_balance": 1,
//               "ask_pin_every_min": 5,
//               "withdrawn_amount_one_time": 100000,
//               "cumul_withdrawn_amount_per_day": 250000,
//               "cumul_withdrawn_amount_per_week": 1000000,
//               "cumul_withdrawn_amount_per_mo": 4000000,
//               "daily_free_withdrawal_count": 2
//             },
//             "api_token": "834da76a-246d-4b19-b143-3befd02891a1",
//             "api_password": "96efca8d-1a7c-48dd-8c26-1f82dfbd7c49"

//             // "user": {
//             //   "id": 487326,
//             //   "parent_id": null,
//             //   "admin_id": null,
//             //   "country_id": 1,
//             //   "currency_id": 1,
//             //   "location_id": null,
//             //   "profil_id": null,
//             //   "balance": 0,
//             //   "sms_balance": 0,
//             //   "devise_country_iso3": "CM",
//             //   "token": null,
//             //   "go_token": null,
//             //   "hashid": "855b0026-652e-4371-b1cf-ac8289bca519",
//             //   "phonenumber": "237650728284",
//             //   "phone": "650728284",
//             //   "username": "9e45a7bf-c90b-4ebc-b1b4-9439e79727b3",
//             //   "password": null,
//             //   "wallet_password": null,
//             //   "api_password": "d76c-55-476-802b-af6e47",
//             //   "api_auth_password": null,
//             //   "name": "NANFACK STALLONE",
//             //   "anniversary": "2000-06-16T23:00:00.000Z",
//             //   "email": "",
//             //   "localisation": null,
//             //   "biography": null,
//             //   "quartier": null,
//             //   "lang": "fr",
//             //   "utc": 1,
//             //   "gender": -1,
//             //   "profil_photo_base64": null,
//             //   "profil_photo_url":
//             //       "https://api.faroty.com/images/avatar/avatar.png",
//             //   "create_date": 1706892350,
//             //   "is_confirm": 1,
//             //   "is_wallet_confirm": 0,
//             //   "has_kyc": 0,
//             //   "kyc_date": null,
//             //   "confirm_date": 1706892425,
//             //   "confirm_wallet_date": null,
//             //   "last_update_time": 1706892425,
//             //   "profil_type": 0,
//             //   "api_fees": 0,
//             //   "versioncode": null,
//             //   "appname": null,
//             //   "save_money_date": null,
//             //   "save_money_password": null,
//             //   "save_money_question": null,
//             //   "save_money_answord": null,
//             //   "transaction_suspended": 0,
//             //   "mycollect_suspended": 0,
//             //   "status": 1,
//             //   "nbcontacts": 0,
//             //   "nbfollowers": 0,
//             //   "nbfollows": 0,
//             //   "nbfaroters": 0,
//             //   "last_seen": 2,
//             //   "birthday_seen": 2,
//             //   "status_seen": 2,
//             //   "phonenumber_seen": 2,
//             //   "faroti_seen": 1,
//             //   "faroti_location_seen": 1,
//             //   "faroti_deposit_seen": 2,
//             //   "faroti_media_seen": 3,
//             //   "pin_to_see_balance": 0,
//             //   "ask_pin_every_min": 5,
//             //   "withdrawn_amount_one_time": 150000,
//             //   "cumul_withdrawn_amount_per_day": 250000,
//             //   "cumul_withdrawn_amount_per_week": 1000000,
//             //   "cumul_withdrawn_amount_per_mo": 4000000,
//             //   "daily_free_withdrawal_count": 50
//             // },
//             // "api_token": "2e81b219-e453-49a9-938e-dbe1fb81c944",
//             // "api_password": "d76c-55-476-802b-af6e47"

//             // "user": {
//             //   "id": 23586,
//             //   "parent_id": null,
//             //   "admin_id": null,
//             //   "country_id": 1,
//             //   "currency_id": 1,
//             //   "location_id": null,
//             //   "profil_id": null,
//             //   "balance": 2242.46,
//             //   "sms_balance": 0,
//             //   "devise_country_iso3": "cm",
//             //   "token": null,
//             //   "go_token": null,
//             //   "hashid": "73fade63-de3f-4072-bb97-016df10547fe",
//             //   "phonenumber": "237680474835",
//             //   "phone": "680474835",
//             //   "username": "28fb8679-65e1-4bda-959b-b52c0dbb508e",
//             //   "password": null,
//             //   "wallet_password": "e82c4b19b8151ddc25d4d93baf7b908f",
//             //   "api_password": "96efca8d-1a7c-48dd-8c26-1f82dfbd7c49",
//             //   "api_auth_password": null,
//             //   "name": "Hulot",
//             //   "anniversary": "2002-08-04T23:00:00.000Z",
//             //   "email": "kengnedjoussehulot@gmail.com",
//             //   "localisation": null,
//             //   "biography": null,
//             //   "quartier": null,
//             //   "lang": "fr",
//             //   "utc": 1,
//             //   "gender": -1,
//             //   "profil_photo_base64": null,
//             //   "profil_photo_url":
//             //       "https://api.faroty.com/images/avatar/avatar.png",
//             //   "create_date": 1676013880,
//             //   "is_confirm": 1,
//             //   "is_wallet_confirm": 1,
//             //   "has_kyc": 1,
//             //   "kyc_date": 1691047960,
//             //   "confirm_date": 1676014031,
//             //   "confirm_wallet_date": null,
//             //   "last_update_time": 1708528363,
//             //   "profil_type": 0,
//             //   "api_fees": 0,
//             //   "versioncode": 986,
//             //   "appname": "android",
//             //   "save_money_date": 1702410361,
//             //   "save_money_password": "e82c4b19b8151ddc25d4d93baf7b908f",
//             //   "save_money_question": null,
//             //   "save_money_answord": null,
//             //   "transaction_suspended": 0,
//             //   "mycollect_suspended": 0,
//             //   "status": 1,
//             //   "nbcontacts": 0,
//             //   "nbfollowers": 0,
//             //   "nbfollows": 0,
//             //   "nbfaroters": 0,
//             //   "last_seen": 2,
//             //   "birthday_seen": 2,
//             //   "status_seen": 2,
//             //   "phonenumber_seen": 2,
//             //   "faroti_seen": 1,
//             //   "faroti_location_seen": 1,
//             //   "faroti_deposit_seen": 2,
//             //   "faroti_media_seen": 3,
//             //   "pin_to_see_balance": 1,
//             //   "ask_pin_every_min": 5,
//             //   "withdrawn_amount_one_time": 100000,
//             //   "cumul_withdrawn_amount_per_day": 250000,
//             //   "cumul_withdrawn_amount_per_week": 1000000,
//             //   "cumul_withdrawn_amount_per_mo": 4000000,
//             //   "daily_free_withdrawal_count": 2
//             // },
//             // "api_token": "834da76a-246d-4b19-b143-3befd02891a1",
//             // "api_password": "96efca8d-1a7c-48dd-8c26-1f82dfbd7c49"
//           },
//         ),

//         domain: '.faroty.com',
//         // path: '/anything',
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageScaffold(
//       reload: reload,
//       context: context,
//       child: progression < 100
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     child: EasyLoader(
//                       backgroundColor: Color.fromARGB(0, 255, 255, 255),
//                       iconSize: 50,
//                       iconColor: AppColors.blackBlueAccent1,
//                       image: AssetImage(
//                         'assets/images/Groupe_ou_Asso.png',
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 20, right: 20),
//                     child: LinearProgressIndicator(
//                       backgroundColor: AppColors.blackBlueAccent1,
//                       color: AppColors.colorButton,
//                       value: (progression / 100).toDouble(),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : WebViewWidget(controller: webViewController),
//     );
//   }
// }
