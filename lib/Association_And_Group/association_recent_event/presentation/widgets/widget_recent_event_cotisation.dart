import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class widgetRecentEventCotisation extends StatefulWidget {
  widgetRecentEventCotisation({
    super.key,
    required this.dateOpen,
    required this.dateClose,
    required this.montantCotisation,
    required this.montantCollecte,
    required this.codeCotisation,
    required this.lienDePaiement,
    required this.motif,
    required this.type,
    required this.isPassed,
    required this.source,
    required this.nomBeneficiaire,
  });
  String dateClose;
  String dateOpen;
  String montantCollecte;
  int montantCotisation;
  String codeCotisation;
  String lienDePaiement;
  String motif;
  String type;
  int isPassed;
  String source;
  String nomBeneficiaire;

  @override
  State<widgetRecentEventCotisation> createState() =>
      _widgetRecentEventCotisationState();
}

class _widgetRecentEventCotisationState
    extends State<widgetRecentEventCotisation> {
  Future<void> handleDetailCotisation(codeCotisation) async {
    // final detailTournoiCourant = await context
    //     .read<DetailTournoiCourantCubit>()
    //     .detailTournoiCourantCubit();
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);

    if (detailCotisation != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailCotisation}");
      print(
          "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<CotisationDetailCubit>().state.detailCotisation}");
    } else {
      print("userGroupDefault null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleDetailCotisation(widget.codeCotisation);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailCotisationPage(
              codeCotisation: widget.codeCotisation,
              lienDePaiement: widget.lienDePaiement,
              dateCotisation: widget.dateOpen,
              heureCotisation: widget.dateOpen,
              montantCotisations: widget.montantCotisation,
              motifCotisations: widget.motif,
              soldeCotisation: widget.montantCollecte,
              type: widget.type,
              isPassed: widget.isPassed,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isPassed == 0
              ? AppColors.white
              : Color.fromARGB(255, 255, 247, 247),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: widget.isPassed == 0
                ? AppColors.white
                : Color.fromARGB(255, 243, 1, 1),
            width: 0.5,
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            // margin: EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(top: 3),
                                        child: Text(
                                          "${formatCompareDateReturnWellValue(widget.dateClose)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.blackBlueAccent1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  widget.type == "0"
                                      ? "Cotisation_fixe".tr()
                                      : "Cotisation_volontaire".tr(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"Motif".tr()} :",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(20, 45, 99, 0.534),
                              ),
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width/2,
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "${widget.motif}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackBlue,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.source == ''
                                        ? " (${(widget.nomBeneficiaire)})"
                                        : " (${(widget.source)})",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blackBlueAccent1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (checkTransparenceStatus(
                            context
                                .read<UserGroupCubit>()
                                .state
                                .ChangeAssData!["user_group"]["configs"],
                            context
                                .read<AuthCubit>()
                                .state
                                .detailUser!["isMember"]))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  "montant_collecté".tr(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${formatMontantFrancais(
                                    double.parse("${widget.montantCollecte}"),
                                  )} FCFA",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width / 1.1,
                    margin: EdgeInsets.only(bottom: 7, top: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "montant".tr(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        child: Text(
                                          "${formatMontantFrancais(double.parse("${widget.montantCotisation}"))} FCFA",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            String msg =
                                "Aide-moi à payer ma cotisation *${widget.motif}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantCotisation.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement} pour valider";

                            Modal().showModalActionPayement(
                              context,
                              msg,
                              widget.lienDePaiement,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: AppColors.colorButton,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              child: Text(
                                "cotiser".tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
