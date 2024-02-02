import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdministrationPage extends StatefulWidget {
  AdministrationPage({super.key, required this.lienDePaiement});
  String lienDePaiement;

  @override
  State<AdministrationPage> createState() => _AdministrationPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Administration".tr(),
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      title: Text(
        "Administration".tr(),
        style: TextStyle(fontSize: 16, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white),
      ),
    ),
    body: child,
  );
}

class _AdministrationPageState extends State<AdministrationPage> {
  // late final WebViewController _controller;
  int progression = 0;
  WebViewController controller = WebViewController();

  final cookieManager = WebviewCookieManager();

  // final String _url = 'https://youtube.com';
  // final String cookieValue = JSON.stringify(list);
  // final String domain = 'faroty.com';
  // final String cookieName = 'some_cookie_name';

  @override
  void initState() {
    super.initState();

    WebViewCookie cookie = WebViewCookie(
      name: "user_data",
      value: {
        "error": false,
        "user": {
          "id": 17799,
          "parent_id": null,
          "admin_id": null,
          "country_id": 1,
          "currency_id": 1,
          "location_id": null,
          "profil_id": null,
          "balance": 879.39,
          "sms_balance": 0,
          "devise_country_iso3": "cm",
          "token": null,
          "go_token": null,
          "hashid": "2d94eb2a-6705-4a3c-8e81-ad4d1c1f1552",
          "phonenumber": "237677438521",
          "phone": "677438521",
          "username": "88afd164-9486-4b81-acf7-c11de760cac7",
          "password": null,
          "wallet_password": "17b3c7061788dbe82de5abe9f6fe22b3",
          "api_password": "9e03e2dd-38fe-4375-9555-91a94d71e2d7",
          "api_auth_password": null,
          "name": "Thibaut TSAGUE",
          "anniversary": "2002-08-04T23:00:00.000Z",
          "email": "",
          "localisation": null,
          "biography": null,
          "quartier": null,
          "lang": "fr",
          "utc": 1,
          "gender": -1,
          "profil_photo_base64": null,
          "profil_photo_url":
              "https://api.rush.faroty.com/images/avatar/avatar.png",
          "create_date": 1661362901,
          "is_confirm": 1,
          "is_wallet_confirm": 1,
          "has_kyc": 1,
          "kyc_date": 1691072008,
          "confirm_date": 1682796374,
          "confirm_wallet_date": null,
          "last_update_time": 1706091361,
          "profil_type": 2,
          "api_fees": 0,
          "versioncode": 980,
          "appname": "android",
          "save_money_date": 1691171723,
          "save_money_password": "17b3c7061788dbe82de5abe9f6fe22b3",
          "save_money_question": null,
          "save_money_answord": null,
          "transaction_suspended": 0,
          "mycollect_suspended": 0,
          "status": 1,
          "nbcontacts": 0,
          "nbfollowers": 0,
          "nbfollows": 0,
          "nbfaroters": 0,
          "last_seen": 2,
          "birthday_seen": 2,
          "status_seen": 2,
          "phonenumber_seen": 2,
          "faroti_seen": 1,
          "faroti_location_seen": 1,
          "faroti_deposit_seen": 2,
          "faroti_media_seen": 3,
          "pin_to_see_balance": 1,
          "ask_pin_every_min": 5,
          "withdrawn_amount_one_time": 100000,
          "cumul_withdrawn_amount_per_day": 250000,
          "cumul_withdrawn_amount_per_week": 1000000,
          "cumul_withdrawn_amount_per_mo": 4000000,
          "daily_free_withdrawal_count": 50
        },
        "api_token": "53c95ac9-deda-463f-b305-0b3306dcf7c4",
        "api_password": "9e03e2dd-38fe-4375-9555-91a94d71e2d7"
      }.toString(),
      domain: "faroty.com",
    );
    WebViewCookieManager().setCookie(cookie);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {
              progression = progress;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://groups.faroty.com/'),
      );

    WebViewWidget(
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child: progression < 100
          ? Center(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: LinearProgressIndicator(
                  value: (progression / 100).toDouble(),
                ),
              ),
            )
          : WebViewWidget(controller: controller),
    );
  }
}
