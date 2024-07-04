import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaiementSanctionWidget extends StatefulWidget {

  PaiementSanctionWidget({
    super.key,
    // required this.infoUserController,
    required this.nom,
    required this.codeSanction,
    required this.codeMembre,
    required this.resteAPayer,
    required this.typeSanction,
    required this.objectSanction,
    required this.codeTournoi,
  });
  var nom;

  var codeSanction;

  var codeMembre;

  var resteAPayer;

  var typeSanction;

  var objectSanction;
  var codeTournoi;

  @override
  State<PaiementSanctionWidget> createState() => _PaiementSanctionWidgetState();
}

class _PaiementSanctionWidgetState extends State<PaiementSanctionWidget> {
  bool load = false;

  late TextEditingController infoUserController;

  @override
  void initState() {
    super.initState();
    infoUserController = TextEditingController(text: "${widget.resteAPayer}");
  }

  @override
  Widget build(BuildContext context) {
    String? jsonString = context.read<AuthCubit>().state.dataCookies;

    // Analyse de la réponse JSON
    Map<String, dynamic> data = jsonDecode(jsonString!);

    // Récupération du hash_id
    String hashId = data['user']['hash_id'];
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blackBlue,
              ),
              text: widget.typeSanction == "1"
                  ? 'Vous avez reçu un paiement de '.tr()
                  : "${'Vous confirmer avoir recu '.tr()}",
              children: <InlineSpan>[
                TextSpan(
                  text: widget.typeSanction == "1"
                      ? "${widget.nom} ?"
                      : "${widget.objectSanction} ",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue),
                ),
                if (widget.typeSanction == "0")
                  TextSpan(
                    text: "venant de ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blackBlue,
                    ),
                  ),
                if (widget.typeSanction == "0")
                  TextSpan(
                    text: widget.nom,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBlue),
                  )
              ],
            ),
          ),
          if (widget.typeSanction == "1")
            SizedBox(
              height: 20.h,
            ),
          if (widget.typeSanction == "1")
            SizedBox(
              height: 60.h,
              child: TextField(
                controller: infoUserController,
                keyboardType: TextInputType.number,
                autofocus: true,
                style: TextStyle(fontSize: 20.sp),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                        color: AppColors.blackBlue,
                      ),
                    )),
              ),
            ),
          SizedBox(
            height: 30.h,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                load = true;
              });
              print(load);
              await CotisationRepository().PayOneCotisation(
                widget.codeSanction,
                widget.typeSanction == "1" ? infoUserController.text:100,
                widget.codeMembre,
                AppCubitStorage().state.codeAssDefaul,
                hashId,
               2,
              );
              context.read<SanctionCubit>().getAllSanctions(widget.codeTournoi);
              context.read<RecentEventCubit>().AllRecentEventCubit(AppCubitStorage().state.membreCode);
              setState(() {
                load = false;
              });
              print(load);
              Navigator.pop(context);
            },
            child: load == true
                ? CircularProgressIndicator(
                    color: AppColors.green,
                  )
                : Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(10.r)),
                    alignment: Alignment.center,
                    child: Text(
                      "Confirmer",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
