import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class widgetRecentEventTontine extends StatefulWidget {
  widgetRecentEventTontine({
    super.key,
    required this.nomBeneficiaire,
    required this.prenomBeneficiaire,
    required this.dateOpen,
    required this.dateClose,
    required this.montantTontine,
    required this.montantCollecte,
    required this.codeCotisation,
    required this.lienDePaiement,
    required this.nomTontine,
  });
  String nomBeneficiaire;
  String dateClose;
  String dateOpen;
  String montantCollecte;
  int montantTontine;
  String prenomBeneficiaire;
  String codeCotisation;
  String lienDePaiement;
  String nomTontine;

  @override
  State<widgetRecentEventTontine> createState() =>
      _widgetRecentEventTontineState();
}

class _widgetRecentEventTontineState extends State<widgetRecentEventTontine>
    with TickerProviderStateMixin {
  Future<void> handleDetailContributionTontine(codeContribution) async {
    final detailCotisation = await context
        .read<DetailContributionCubit>()
        .detailContributionTontineCubit(codeContribution);

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
    final TabController _tabController = TabController(length: 2, vsync: this);
    return GestureDetector(
      onTap: () {
        if (checkTransparenceStatus(
            context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]
                ["configs"],
            context.read<AuthCubit>().state.detailUser!["isMember"])) {
          handleDetailContributionTontine(
            widget.codeCotisation,
          );

          Modal().showBottomSheetHistTontine(
            context,
            _tabController,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isPasseDate(widget.dateClose)? Color.fromARGB(255, 255, 247, 247): AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isPasseDate(widget.dateClose)
                ? Color.fromARGB(255, 243, 1, 1)
                : AppColors.white,
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
                              children: [                                      Container(
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
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  "Tontine ${widget.nomTontine}".tr(),
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
                        Expanded(
                          child: Container(
                            // margin: EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 3),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "${"Bénéficiaire".tr()} :",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                20, 45, 99, 0.534),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${widget.nomBeneficiaire}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                          Expanded(
                            child: Column(
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
                                    "${formatMontantFrancais(double.parse("${widget.montantCollecte}"))} FCFA",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.green,
                                      fontWeight: FontWeight.w600,
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
                                          "${formatMontantFrancais(double.parse("${widget.montantTontine}"))} FCFA",
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
                                "Aide-moi à payer ma tontine *${widget.nomTontine}* .\nMontant: *${formatMontantFrancais(widget.montantTontine.toDouble())} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement} pour valider";
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
                                "Tontiner",
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
