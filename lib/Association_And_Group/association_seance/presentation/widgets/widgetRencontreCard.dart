import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/screens/detailRencontrePage.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WidgetRencontreCard extends StatefulWidget {
  WidgetRencontreCard({
    super.key,
    required this.prenomRecepteurRencontre,
    required this.identifiantRencontre,
    required this.isActiveRencontre,
    required this.descriptionRencontre,
    required this.lieuRencontre,
    required this.dateRencontre,
    required this.heureRencontre,
    required this.nomRecepteurRencontre,
    required this.photoProfilRecepteur,
    required this.codeSeance,
    required this.dateRencontreAPI,
    required this.maskElt,
    required this.typeRencontre,
  });

  String prenomRecepteurRencontre;
  String nomRecepteurRencontre;
  String identifiantRencontre;
  int isActiveRencontre;
  String descriptionRencontre;
  String lieuRencontre;
  String dateRencontre;
  String heureRencontre;
  String photoProfilRecepteur;
  String codeSeance;
  String dateRencontreAPI;
  bool maskElt;
  String typeRencontre;

  @override
  State<WidgetRencontreCard> createState() => _WidgetRencontreCardState();
}

class _WidgetRencontreCardState extends State<WidgetRencontreCard> {
  Future<void> handleDefaultSeance(codeSeance) async {
    final detailSeance =
        await context.read<SeanceCubit>().detailSeanceCubit(codeSeance);
  }

  isPasseDate() {
    // Date récupérée de l'API (sous forme de String)
    String apiDateString = widget.dateRencontreAPI;

    // Conversion de la chaîne en un objet DateTime
    DateTime apiDate = DateTime.parse(apiDateString);

    // Date actuelle
    DateTime now = DateTime.now();

    // Comparaison pour savoir si la date de l'API est passée par rapport à la date actuelle
    if (apiDate.isBefore(now)) {
      print('La date de l\'API est passée par rapport à la date actuelle.');
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeanceCubit, SeanceState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          print("eeeeeeeeeeeeeeeee");
          handleDefaultSeance(widget.codeSeance);
          final detailSeance =
              context.read<SeanceCubit>().detailSeanceCubit(widget.codeSeance);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detailRencontrePage(
                codeSeance: widget.codeSeance,
                dateRencontre: widget.dateRencontre,
                descriptionRencontre: widget.descriptionRencontre,
                heureRencontre: widget.heureRencontre,
                identifiantRencontre: widget.identifiantRencontre,
                isActiveRencontre: widget.isActiveRencontre,
                lieuRencontre: widget.lieuRencontre,
                nomRecepteurRencontre: widget.nomRecepteurRencontre,
                prenomRecepteurRencontre: widget.prenomRecepteurRencontre,
                photoProfilRecepteur: widget.photoProfilRecepteur,
                dateRencontreAPI: widget.dateRencontreAPI,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: widget.isActiveRencontre == 1
                ? AppColors.white
                : Color.fromARGB(12, 0, 0, 0),
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: widget.isActiveRencontre == 1
                    ? Color.fromARGB(110, 117, 117, 117)
                    : Color.fromARGB(0, 117, 117, 117),
                spreadRadius: 0.2,
                blurRadius: 0.2,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 7.h),
                            child: Text(
                              "recepteur".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Modal().showFullPicture(
                                              context,
                                              widget.photoProfilRecepteur == null
                                                  ? "https://services.faroty.com/images/avatar/avatar.png"
                                                  : "${Variables.LienAIP}${widget.photoProfilRecepteur}",
                                              "${widget.nomRecepteurRencontre} ${widget.prenomRecepteurRencontre}".tr());
                                    

                                    // print("${Variables.LienAIP}${widget.photoProfilRecepteur}");
                                  },
                                  child: Container(
                                    height: 15.w,
                                    width: 15.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        "${Variables.LienAIP}${widget.photoProfilRecepteur}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // alignment: Alignment.center,
                                  // color: Colors.deepOrange,
                                  margin: EdgeInsets.only(left: 5.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        // margin: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "${widget.nomRecepteurRencontre} ${widget.prenomRecepteurRencontre}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                    if(!widget.maskElt)
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: Text(
                                    "rencontre".tr(),
                                    style: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontSize: 12.sp,),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    " ${widget.identifiantRencontre}",
                                    style: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.isActiveRencontre == 0)
                            Container(
                              padding: EdgeInsets.only(top: 5.h),

                              // decoration: BoxDecoration(
                              // color: Color.fromARGB(24, 212, 0, 0),
                              // borderRadius: BorderRadius.circular(7)),
                              child: Container(
                                padding: EdgeInsets.all(1.r),
                                child: Text(
                                  "Archivé".tr(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,),
                                ),
                              ),
                            ),
                          if (widget.isActiveRencontre == 1 && isPasseDate())
                            Container(
                              padding: EdgeInsets.only(top: 5.h,),
                              // decoration: BoxDecoration(
                              //     color: Color.fromARGB(24, 212, 0, 0),
                              //     borderRadius: BorderRadius.circular(7)),
                              child: Container(
                                padding: EdgeInsets.all(1.r),
                                child: Text(
                                  "terminé".tr(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,),
                                ),
                              ),
                            ),
                          if (!isPasseDate() && widget.isActiveRencontre == 1)
                            Container(
                              padding: EdgeInsets.only(top: 5.h),
                              // decoration: BoxDecoration(
                              //     color: Color.fromARGB(43, 0, 212, 7),
                              //     borderRadius: BorderRadius.circular(7)),
                              child: Container(
                                padding: EdgeInsets.all(1.r),
                                child: Text(
                                  "en_cours".tr(),
                                  style: TextStyle(
                                      color: AppColors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(17, 131, 131, 131),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      padding: EdgeInsets.all(5.r),
                      child: Container(
                        child: Text(
                          widget.descriptionRencontre,
                          // textAlign: TextAlign.start,
                          style: TextStyle(
                            letterSpacing: 0.3,
                            height: 1.3.r,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                // margin: EdgeInsets.only(top: 7),
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  color: Color.fromARGB(29, 131, 131, 131),
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(width: 0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "lieu".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 1.h),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      widget.lieuRencontre,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5.w),
                                  child: Icon(
                                    Icons.maps_home_work_rounded,
                                    size: 13.sp,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Type".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 1.h),
                            child: Text(
                              widget.typeRencontre == "0"? "Ordinaire".tr(): widget.typeRencontre == "1"? "Extraordinaire".tr(): "Comité",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: AppColors.blackBlue,
                                  fontWeight: FontWeight.bold),
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
    });
  }
}
