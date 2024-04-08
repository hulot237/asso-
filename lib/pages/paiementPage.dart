import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaiementPage extends StatefulWidget {
  PaiementPage({super.key, required this.lienDePaiement, required this.msgAppBarPaiementPage});
  String lienDePaiement;
  String msgAppBarPaiementPage;

  @override
  State<PaiementPage> createState() => _PaiementPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
  required String msgAppBarPaiementPage,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "$msgAppBarPaiementPage",
          style: TextStyle(fontSize: 16.sp, color : AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: AppColors.white,
            size: 22.sp,
          ),
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      title: Text(
        "$msgAppBarPaiementPage",
        style: TextStyle(fontSize: 16.sp, color : AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white, size: 16.sp,),
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
            print("hfhhhhhh${progress}");
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50.r,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                        "assets/images/AssoplusFinal.png",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.blackBlueAccent1,
                      color: AppColors.colorButton,
                      value: (progression / 100).toDouble(),
                    ),
                  ),
                ],
              ), 
            
          )
          : WebViewWidget(controller: _controller), msgAppBarPaiementPage: '${widget.msgAppBarPaiementPage}',
    );
  }
}
