import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailContributionPage.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/localisation_phone/business_logic/localisation_phone_cubit.dart';
import 'package:faroty_association_1/network/session_activity/session_cubit.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/pages/pre_login_screen.dart';
import 'package:faroty_association_1/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashRedirectNotifScreen extends StatefulWidget {
  String dataSource;
  String codeElt;

  SplashRedirectNotifScreen(
      {super.key, required this.dataSource, required this.codeElt});

  @override
  State<SplashRedirectNotifScreen> createState() =>
      _SplashRedirectNotifScreenState();
}

class _SplashRedirectNotifScreenState extends State<SplashRedirectNotifScreen> {
  Future<Map<String, dynamic>?> handleDetailCotisation(
      String codeCotisation) async {
    final detailCubit = context.read<CotisationDetailCubit>();
    await detailCubit.detailCotisationCubit(codeCotisation);
    // Vous pouvez attendre que l'état soit mis à jour ici
    // par exemple, en vérifiant que `detailCubit.state.currentDetailCotisation` n'est pas null
    final currentDetailCotisation = detailCubit.state.detailCotisation;
    return currentDetailCotisation;
  }

  Future<Map?> handleDetailContribution(String codeCotisation) async {
    final detailCubit = context.read<DetailContributionCubit>();
    await detailCubit.detailContributionTontineCubit(codeCotisation);
    // Vous pouvez attendre que l'état soit mis à jour ici
    // par exemple, en vérifiant que `detailCubit.state.currentDetailCotisation` n'est pas null
    final currentDetailContribution =
        detailCubit.state.detailContributionTontine;
    return currentDetailContribution;
  }

  Future<void> navigateAfterLoading() async {
    if (AppCubitStorage().state.codeAssDefaul != null &&
        AppCubitStorage().state.codeTournois != null &&
        AppCubitStorage().state.membreCode != null &&
        AppCubitStorage().state.tokenUser != null) {
      if (widget.dataSource == "ass_cotisations") {
        final currentDetailCotisation =
            await handleDetailCotisation(widget.codeElt);

        // Navigate to DetailCotisationPage after the data is loaded
        if (currentDetailCotisation != null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => DetailCotisationPage(
                fromNotification: true,
                rapportUrl: currentDetailCotisation["rapport"],
                isPayed: currentDetailCotisation["is_current_membre_payed"],
                rubrique: currentDetailCotisation["ass_rubrique"] == null
                    ? ""
                    : currentDetailCotisation["ass_rubrique"],
                montantCotisations: currentDetailCotisation["amount"],
                motifCotisations: currentDetailCotisation["name"],
                dateCotisation: currentDetailCotisation["end_date"],
                heureCotisation: AppCubitStorage().state.Language == "fr"
                    ? formatTimeToFrench(currentDetailCotisation["end_date"])
                    : formatTimeToEnglish(currentDetailCotisation["end_date"]),
                soldeCotisation: currentDetailCotisation["total_cotise"],
                codeCotisation: currentDetailCotisation["cotisation_code"],
                type: currentDetailCotisation["type"],
                lienDePaiement:
                    currentDetailCotisation["cotisation_pay_link"] == null
                        ? "le lien n'a pas été généré"
                        : currentDetailCotisation["cotisation_pay_link"],
                is_passed: currentDetailCotisation["is_passed"],
                is_tontine: currentDetailCotisation["is_tontine"],
                source: currentDetailCotisation["seance"] == null
                    ? ''
                    : '${'rencontre'.tr()} ${currentDetailCotisation["seance"]["matricule"]} ${"du".tr()} ${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", currentDetailCotisation["seance"]["date_seance"])}',
                nomBeneficiaire: currentDetailCotisation["membre"] == null
                    ? ''
                    : '${currentDetailCotisation["membre"]["last_name"] == null ? "${currentDetailCotisation["membre"]["first_name"]}" : "${currentDetailCotisation["membre"]["first_name"]} ${currentDetailCotisation["membre"]["last_name"]}"}',
                isPassed: currentDetailCotisation["is_passed"],
              ),
            ),
            (route) => false,
          );
        }
      } else if (widget.dataSource == "ass_tontine_contributions") {
        final currentDetailContribution =
            await handleDetailContribution(widget.codeElt);

        // Navigate to DetailCotisationPage after the data is loaded
        if (currentDetailContribution != null) {

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => DetailContributionPage(

                  fromNotification: true,
                  montantCotisations: currentDetailContribution["amount"] ?? "",
                  motifCotisations: currentDetailContribution["motif"] ?? "",
                  dateCotisation: currentDetailContribution["end_date"] ?? "",
                  heureCotisation: currentDetailContribution["end_date"] ?? "",
                  soldeCotisation:
                      currentDetailContribution["total_cotise"] ?? "",
                  isPassed: currentDetailContribution["is_passed"],
                  type: "0",
                  lienDePaiement:
                      currentDetailContribution["tontine_pay_link"] ?? "",
                  codeCotisation: currentDetailContribution["code"] ?? "",
                  isPayed: currentDetailContribution["is_current_membre_payed"],
                  // rapportUrl: widget.x,
                  is_passed: currentDetailContribution["is_passed"],
                  is_tontine: 1,
                  source: '',
                  nomBeneficiaire:
                      currentDetailContribution["membre"]?["first_name"] ?? "",
                  rubrique:
                      'Tontine : ${currentDetailContribution["matricule"] ?? ""}'),
            ),
            (route) => false,
          );
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ),
          (route) => false,
        );
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<LocalisationPhoneCubit>().showLocalisationPhone();
    context.read<SessionCubit>().GetSessionCubit();

    // Call navigateAfterLoading in initState
    navigateAfterLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images/updateBulle.png",
                width: 250.w,
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: RotatedBox(
                quarterTurns: 2,
                child: Image.asset(
                  "assets/images/updateBulle.png",
                  width: 180.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      margin: EdgeInsets.only(top: 50.h),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [ImageAnimated()],
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Image.asset(
                          "assets/images/FAroty_gris.png",
                          width: 80.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageAnimated extends StatefulWidget {
  const ImageAnimated({super.key});

  @override
  State<ImageAnimated> createState() => _ImageAnimatedState();
}

class _ImageAnimatedState extends State<ImageAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..repeat(reverse: true);
  late Animation<double> _animation = CurvedAnimation(
      parent: _controller, curve: Curves.fastEaseInToSlowEaseOut);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1,
        end: 1,
      ).animate(_animation),
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0.4,
          end: 1,
        ).animate(_animation),
        child: Container(
          child: Image.asset(
            "assets/images/AssoplusFinalSquare.png",
            width: 180.w,
          ),
        ),
      ),
    );
  }
}
