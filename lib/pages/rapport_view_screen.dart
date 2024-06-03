import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:device_info_plus/device_info_plus.dart';

class RapportViewScreen extends StatefulWidget {
  RapportViewScreen({
    super.key,
    required this.src,
    required this.nomElement,
  });
  var src;
  String nomElement;

  @override
  State<RapportViewScreen> createState() => _RapportViewScreenState();
}

class _RapportViewScreenState extends State<RapportViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(
            colorIcon: AppColors.white,
          ),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       //You can download a single file
        //       FileDownloader.downloadFile(
        //           url: "${widget.src}",
        //           name: "${"Rapport".tr()} : ${widget.nomElement}", //(optional)
        //           // onProgress: () {
        //           //   // print('FILE fileName HAS PROGRESS $progress');
        //           // },
        //           onProgress: (fileName, progress) {
                    
        //           },
        //           onDownloadCompleted: (String path) {
        //             setState(() {
                      
        //             });
        //             print('FILE DOWNLOADED TO PATH: $path');
        //           },
        //           onDownloadError: (String error) {
        //             print('DOWNLOAD ERROR: $error');
        //           });
        //     },
        //     child: Icon(
        //       Icons.download,
        //     ),
        //   ),
        // ],
        backgroundColor: AppColors.backgroundAppBAr,
        title: Text(
          "${"Rapport".tr()} : ${widget.nomElement}",
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: AppColors.bleuLight,
        child: SfPdfViewer.network(
          "${widget.src}",
        ),
      ),
    );
  }
}
