import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetHistoriqueCotisation extends StatefulWidget {
  var resteAPayer;

  var codeCotisation;

  var codeMembre;

  WidgetHistoriqueCotisation({
    super.key,
    required this.photoProfil,
    required this.versement_status,
    required this.montantVersee,
    required this.matricule,
    required this.nom,
    required this.prenom,
    required this.montantTotalAVerser,
    required this.resteAPayer,
    required this.codeCotisation,
    required this.codeMembre,
  });
  String matricule;

  String montantVersee;

  String nom;

  String prenom;

  String photoProfil;
  String montantTotalAVerser;
  String versement_status;

  @override
  State<WidgetHistoriqueCotisation> createState() =>
      _WidgetHistoriqueCotisationState();
}

class _WidgetHistoriqueCotisationState
    extends State<WidgetHistoriqueCotisation> {
  bool load = false;

  @override
  Widget build(BuildContext context) {
    String? jsonString = context.read<AuthCubit>().state.dataCookies;

    // Analyse de la réponse JSON
    Map<String, dynamic> data = jsonDecode(jsonString!);

    // Récupération du hash_id
    String hashId = data['user']['hash_id'];
    return Container(
      padding:
          EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.r,
            color: Color.fromARGB(85, 9, 185, 255),
          ),
        ),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Modal().showFullPicture(
                        context,
                        widget.photoProfil == null
                            ? "https://services.faroty.com/images/avatar/avatar.png"
                            : "${Variables.LienAIP}${widget.photoProfil}",
                        "${widget.nom} ${widget.prenom}");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Container(
                      height: 45.r,
                      width: 45.r,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(50.r)),
                      child: Image.network(
                        "${Variables.LienAIP}${widget.photoProfil}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5.h),
                                child: Text(
                                  "${widget.nom} ${widget.prenom}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                              ),
                              if (widget.versement_status == "2")
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 5.h, left: 0.w),
                                  child: Text(
                                    "payé".tr(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: AppColors.green,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(3.r),
                          //   margin: EdgeInsets.only(left: 5.w),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(50.r),
                          //     color: widget.versement_status == "0"
                          //         ? Color.fromARGB(40, 175, 76, 76)
                          //         : widget.versement_status == "1"
                          //             ? Color.fromARGB(40, 175, 139, 76)
                          //             : Color.fromARGB(40, 83, 175, 76),
                          //   ),
                          //   child: Icon(
                          //     widget.versement_status == "0"
                          //         ? Icons.close
                          //         : widget.versement_status == "1"
                          //             ? Icons.close
                          //             : Icons.done,
                          //     color: widget.versement_status == "0"
                          //         ? Colors.red
                          //         : widget.versement_status == "1"
                          //             ? Colors.orange
                          //             : Colors.green,
                          //     size: 14.sp,
                          //   ),
                          // ),
                        ],
                      ),

                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w800,
                                        color: widget.versement_status == "0"
                                            ? Colors.red
                                            : widget.versement_status == "1"
                                                ? Colors.orange
                                                : Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.all(1.r),
                            //   margin: EdgeInsets.only(left: 5.w),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(50.r),
                            //     color: widget.versement_status=="0"? Color.fromARGB(40, 175, 76, 76) : widget.versement_status=="1"? Color.fromARGB(40, 175, 139, 76): Color.fromARGB(40, 83, 175, 76),
                            //   ),
                            //   child: Icon(
                            //    widget.versement_status=="0" ? Icons.close : widget.versement_status=="1" ? Icons.close : Icons.done,
                            //     color: widget.versement_status=="0"? Colors.red : widget.versement_status=="1"? Colors.orange :  Colors.green,
                            //     size: 10.sp,
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                      // Container(
                      //   child: Text(
                      //     "${widget.matricule}",
                      //     style: TextStyle(
                      //       fontSize: 10.sp,
                      //       fontWeight: FontWeight.w800,
                      //       color: Color.fromRGBO(20, 45, 99, 0.349),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!context.read<AuthCubit>().state.detailUser!["isMember"])
            //   widget.versement_status != "2"
            //       ?
            InkWell(
              onTap: () {
                _showSimpleModalDialog(
                  context,
                  widget.nom,
                  widget.resteAPayer,
                  widget.codeCotisation,
                  widget.codeMembre,
                  hashId,
                );
                print("object");
              },
              child: Container(
                alignment: Alignment.center,
                width: 32.r,
                height: 32.r,
                padding: EdgeInsets.symmetric(
                  horizontal: 8.r,
                  vertical: 8.r,
                ),
                decoration: BoxDecoration(
                  color: AppColors.colorButton,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: SvgPicture.asset(
                  "assets/images/walletPayIcon.svg",
                  fit: BoxFit.scaleDown,
                  color: AppColors.white,
                ),
              ),
            ),
          // : Container(
          //     padding: EdgeInsets.all(3.r),
          //     margin: EdgeInsets.only(left: 5.w),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(50.r),
          //       color: widget.versement_status == "0"
          //           ? Color.fromARGB(40, 175, 76, 76)
          //           : widget.versement_status == "1"
          //               ? Color.fromARGB(40, 175, 139, 76)
          //               : Color.fromARGB(40, 83, 175, 76),
          //     ),
          //     child: Icon(
          //       widget.versement_status == "0"
          //           ? Icons.close
          //           : widget.versement_status == "1"
          //               ? Icons.close
          //               : Icons.done,
          //       color: widget.versement_status == "0"
          //           ? Colors.red
          //           : widget.versement_status == "1"
          //               ? Colors.orange
          //               : Colors.green,
          //       size: 14.sp,
          //     ),
          //   ),
          if (context.read<AuthCubit>().state.detailUser!["isMember"])
            Container(
              child: Row(
                children: [
                  // Container(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         // margin: EdgeInsets.only(bottom: 15),
                  //         child: Text(
                  //           "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA",
                  //           style: TextStyle(
                  //             fontSize: 12.sp,
                  //             fontWeight: FontWeight.w800,
                  //             color: widget.versement_status == "0"
                  //                 ? Colors.red
                  //                 : widget.versement_status == "1"
                  //                     ? Colors.orange
                  //                     : Colors.green,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.all(3.r),
                    margin: EdgeInsets.only(left: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: widget.versement_status == "0"
                          ? Color.fromARGB(40, 175, 76, 76)
                          : widget.versement_status == "1"
                              ? Color.fromARGB(40, 175, 139, 76)
                              : Color.fromARGB(40, 83, 175, 76),
                    ),
                    child: Icon(
                      widget.versement_status == "0"
                          ? Icons.close
                          : widget.versement_status == "1"
                              ? Icons.close
                              : Icons.done,
                      color: widget.versement_status == "0"
                          ? Colors.red
                          : widget.versement_status == "1"
                              ? Colors.orange
                              : Colors.green,
                      size: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  _showSimpleModalDialog(
    context,
    nom,
    resteAPayer,
    codeCotisation,
    codeMembre,
    hashId,
  ) {
    showDialog(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) {
        Future<void> handleDetailCotisation(codeCotisation) async {
          // final detailTournoiCourant = await context
          //     .read<DetailTournoiCourantCubit>()
          //     .detailTournoiCourantCubit();
          final detailCotisation = await context
              .read<CotisationDetailCubit>()
              .detailCotisationCubit(codeCotisation);
        }

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 250.h),
            child: paiementWidget(
              nom: nom,
              codeCotisation: codeCotisation,
              codeMembre: codeMembre,
              hashId: hashId,
              resteAPayer: resteAPayer,
            ),
          ),
        );
      },
    );
  }
}

class paiementWidget extends StatefulWidget {
  var nom;

  var codeCotisation;

  var codeMembre;

  var hashId;
  var resteAPayer;

  paiementWidget({
    super.key,
    // required this.infoUserController,
    required this.nom,
    required this.codeCotisation,
    required this.codeMembre,
    required this.hashId,
    required this.resteAPayer,
  });

  @override
  State<paiementWidget> createState() => _paiementWidgetState();
}

class _paiementWidgetState extends State<paiementWidget> {
  bool load = false;

  late TextEditingController infoUserController;

  Future<void> handleAllCotisationAssTournoi(codeTournoi, codeMembre) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssTournoiCubit(codeTournoi, codeMembre);

    if (allCotisationAss != null) {
      print("handleAllCotisationAss");
    } else {
      print("handleAllCotisationAss null");
    }
  }

  @override
  void initState() {
    super.initState();
    infoUserController = TextEditingController(text: "${widget.resteAPayer}");
  }

  @override
  Widget build(BuildContext context) {
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
              text: 'Vous avez reçu un paiement de '.tr(),
              children: <InlineSpan>[
                TextSpan(
                  text: '${widget.nom}',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 60.h,
            child: TextField(
              controller: infoUserController,
              autofocus: true,
              keyboardType: TextInputType.number,
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
              // setState(() {
              //   load = true;
              // });
              print(load);
              CotisationRepository().PayOneCotisation(
                widget.codeCotisation,
                infoUserController.text,
                widget.codeMembre,
                AppCubitStorage().state.codeAssDefaul,
                widget.hashId,
                3,
              );
              context.read<CotisationDetailCubit>().updateStateAmountPay(
                    widget.codeMembre,
                    infoUserController.text,
                  );
                            await Future.delayed(Duration(seconds: 2));

              handleAllCotisationAssTournoi(
                AppCubitStorage().state.codeTournoisHist,
                AppCubitStorage().state.membreCode,
              );

              // setState(() {
              //   load = false;
              // });
              print(load);
              Navigator.pop(context);
              // Attendre 2 secondes avant d'exécuter handleAllCotisationAssTournoi

            },
            child:
                // load == true
                // ? CircularProgressIndicator(
                //     color: AppColors.green,
                //   )
                // :
                Container(
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
