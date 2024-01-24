import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    WebViewCookie cookie = WebViewCookie(
      name: "user_data",
      value: {
        "error": false,
        "user": {
          "id": 23586,
          "parent_id": null,
          "admin_id": null,
          "country_id": 1,
          "currency_id": 1,
          "location_id": null,
          "profil_id": null,
          "balance": 1902.88,
          "sms_balance": 0,
          "devise_country_iso3": "cm",
          "token":
              "d6EVQeUik3c:APA91bETkRsEhWhzEJnrfOxkNpWreuQDFqJAr2dXDwThywaDD93tZhTsmCZm6DFXUuOam_jNj5cOics0YTYty7rhO8qavKkaEgXdqWNVoG10avn8tWKXxYsPbHYPrsgkEhUDj0IkSbC8",
          "go_token": null,
          "hashid": "73fade63-de3f-4072-bb97-016df10547fe",
          "phonenumber": "237680474835",
          "phone": "680474835",
          "username": "28fb8679-65e1-4bda-959b-b52c0dbb508e",
          "password": null,
          "wallet_password": "e82c4b19b8151ddc25d4d93baf7b908f",
          "api_password": "6f51b785-0e4f-44d7-93a3-b5d4e0b2558e",
          "api_auth_password": null,
          "name": "Hulot",
          "anniversary": "2002-08-04T23:00:00.000Z",
          "email": "kengnedjoussehulot@gmail.com",
          "localisation": null,
          "biography": null,
          "quartier": null,
          "lang": "fr",
          "utc": 1,
          "gender": -1,
          "profil_photo_base64": null,
          "profil_photo_url": "https://api.faroty.com/images/avatar/avatar.png",
          "create_date": 1676013880,
          "is_confirm": 1,
          "is_wallet_confirm": 1,
          "has_kyc": 1,
          "kyc_date": 1691047960,
          "confirm_date": 1676014031,
          "confirm_wallet_date": null,
          "last_update_time": 1703098167,
          "profil_type": 0,
          "api_fees": 0,
          "versioncode": 986,
          "appname": "android",
          "save_money_date": 1702410361,
          "save_money_password": "e82c4b19b8151ddc25d4d93baf7b908f",
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
          "daily_free_withdrawal_count": 2
        },
        "api_token": "834da76a-246d-4b19-b143-3befd02891a1",
        "api_password": "6f51b785-0e4f-44d7-93a3-b5d4e0b2558e"
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
