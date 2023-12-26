import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaiementPage extends StatefulWidget {
  PaiementPage({super.key, required this.lienDePaiement});
  String lienDePaiement;

  @override
  State<PaiementPage> createState() => _PaiementPageState();
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
          "Effectuer_le_paiement".tr(),
          style: TextStyle(fontSize: 16, color : AppColors.white),
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
        "Effectuer_le_paiement".tr(),
        style: TextStyle(fontSize: 16, color : AppColors.white),
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

class _PaiementPageState extends State<PaiementPage> {
  late final WebViewController _controller;
  int progression = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print("zzzzzzzzzzz${progress}");
            setState(() {
              progression = progress;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse("https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}"));
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
          : WebViewWidget(controller: _controller),
    );
  }
}
