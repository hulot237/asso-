import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.pageBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Notifications".tr(),
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "Notifications".tr(),
        style: TextStyle(fontSize: 16, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white, size: 16.sp,),
      ),
    ),
    body: child,
  );
}

class _NotificationPageState extends State<NotificationPage> {
  Future<void> getNotification() async {
    await context.read<NotificationCubit>().getNotification(
        AppCubitStorage().state.tokenUser,
        AppCubitStorage().state.codeAssDefaul);
  }

  @override
  void initState() {
    getNotification();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleDetailUser(userCode, codeTournoi) async {
      final allCotisationAss = await context
          .read<AuthCubit>()
          .detailAuthCubit(userCode, codeTournoi);

    }

    return PageScaffold(
        context: context,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            // margin: EdgeInsets.only(top: 10),
            child: Container(
              child: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (NotificationContext, NotificationState) {
                if (NotificationState.isLoading == true &&
                    NotificationState.notifications == null)
                  return Container(
                    child: EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50.r,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                       "assets/images/AssoplusFinal.png",
                      ),
                    ),
                  );
                final currentNotifications =
                    context.read<NotificationCubit>().state.notifications;
          
                return GroupedListView<NotificationModel, String>(
                  elements: currentNotifications!,
                  groupBy: (element) => formatDateTimeintegral(
                    context.locale.toString() == "en_US" ? "en" : "fr",
                    element.createdAt!,
                  ),
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.createdAt!.compareTo(item2.createdAt!),
                  order: GroupedListOrder.ASC,
                  groupSeparatorBuilder: (String value) => Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                    padding: EdgeInsets.only(bottom: 7),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        width: 0.2,
                        color: AppColors.blackBlue,
                      ),
                    )),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
                  itemBuilder: (c, element) {
                    return InkWell(
                      onTap: () async {
                        _showSimpleModalDialog(context, element.description);
          
                        if (element.isReaded == 0) {
                          await NotificationRepository()
                              .updateNotification(element.id);
                        }
          
                        context.read<NotificationCubit>().getNotification(
                            AppCubitStorage().state.tokenUser,
                            AppCubitStorage().state.codeAssDefaul);
                      },
                      child: notificationWidget(
                        idNotification: element.id!,
                        description: element.description!,
                        dateCreate: element.createdAt!,
                        isReaded: element.isReaded!,
                        source_name: element.sourceName!,
                        photoProfil: element.authorAvatar == null
                            ? ""
                            : element.authorAvatar!,
                        descriptionSansBalise:
                            removeBBalise(element.description!),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ));
  }
}

class notificationWidget extends StatelessWidget {
  const notificationWidget({
    super.key,
    required this.description,
    required this.dateCreate,
    required this.isReaded,
    required this.idNotification,
    required this.source_name,
    required this.photoProfil,
    required this.descriptionSansBalise,
  });

  final String description;
  final String dateCreate;
  final int isReaded;
  final int idNotification;
  final String source_name;
  final String photoProfil;
  final String descriptionSansBalise;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 0),
            // child: Text(
            //   dateCreate,
            //   style: TextStyle(
            //       fontWeight: FontWeight.w400,
            //       fontSize: 12,
            //       color: AppColors.blackBlue),
            // ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: NetworkImage(("${Variables.LienAIP}${photoProfil}")),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(360),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: isReaded == 1
                          ? AppColors.blackBlueAccent2
                          : AppColors.colorButtonAccent,
                      borderRadius: BorderRadius.circular(10)),
                  // width: 200,
                  margin: EdgeInsets.only(right: 20),
                  // padding: EdgeInsets.all(3),
                  // child: Text('${parsedstring}'),
                  child: isReaded == 1
                      ? Column(
                          children: [
                            Html(
                              data:
                                  "<p style='color:#142D63 ; text-align:center; '>${description}</p>",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(
                                  margin: EdgeInsets.only(right: 10, bottom: 9),
                                  child: Text(
                                    "${formatHeurUnikLiteral(dateCreate)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              child: Text(
                                "$descriptionSansBalise",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBlue),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "AFFICHER".tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.backgroundAppBAr,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_double_arrow_right,
                                        size: 16,
                                        color: AppColors.backgroundAppBAr,
                                      )
                                    ],
                                  ),
                                  Text(
                                    "${formatHeurUnikLiteral(dateCreate)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

_showSimpleModalDialog(context, description) {
  showDialog(
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Html(
                data:
                    "<p style='color:#142D63 ; text-align:center; font-size:16px;'>${description}</p>",
              ),
            ),
          ),
        );
      });
}
