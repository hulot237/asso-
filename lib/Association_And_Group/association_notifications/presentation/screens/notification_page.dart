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
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
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
          style: TextStyle(fontSize: 16.sp, color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: BackButtonWidget(colorIcon: AppColors.white),
      ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "Notifications".tr(),
        style: TextStyle(fontSize: 16.sp, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: BackButtonWidget(colorIcon: AppColors.white),
      ),
    ),
    body: child,
  );
}

class _NotificationPageState extends State<NotificationPage> {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<NotificationCubit>(context).getNotification(
              AppCubitStorage().state.tokenUser,
              AppCubitStorage().state.codeAssDefaul);
        }
      }
    });
  }

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
    setupScrollController(context);
    Future<void> handleDetailUser(userCode, codeTournoi) async {
      final allCotisationAss = await context
          .read<AuthCubit>()
          .detailAuthCubit(userCode, codeTournoi);
    }

    return PageScaffold(
        context: context,
        child: Material(
          type: MaterialType.transparency,
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

            if (NotificationState.errorLoadNotif == true)
              return checkInternetConnectionPage(
                  functionToCall: getNotification);

            final currentNotifications =
                context.read<NotificationCubit>().state.notifications;
            return Container(
              margin: EdgeInsets.only(
                  // bottom: 10.h,
                  ),
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                        child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            // Votre widget GroupedListView ici
                            GroupedListView<NotificationModel, String>(
                              elements: currentNotifications!,
                              shrinkWrap: true,
                              groupBy: (element) => DateFormat('yyyy-MM-dd')
                                  .parse(element.createdAt!)
                                  .toString(),
                              groupComparator: (value1, value2) =>
                                  value1.compareTo(value2),
                              itemComparator: (item1, item2) =>
                                  item1.createdAt!.compareTo(item2.createdAt!),
                              order: GroupedListOrder.DESC,
                              groupSeparatorBuilder: (String value) =>
                                  Container(
                                margin: EdgeInsets.only(
                                  left: 30.w,
                                  right: 30.w,
                                  top: 15.h,
                                ),
                                padding: EdgeInsets.only(
                                  bottom: 7.h,
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    width: 0.2.r,
                                    color: AppColors.blackBlue,
                                  ),
                                )),
                                child: Text(
                                  formatDateTimeintegral(
                                    context.locale.toString() == "en_US"
                                        ? "en"
                                        : "fr",
                                    value,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                              ),
                              itemBuilder: (c, element) {
                                return GestureDetector(
                                  onTap: () async {
                                    _showSimpleModalDialog(
                                        context, element.description);

                                    if (element.isReaded == 0) {
                                      await NotificationRepository()
                                          .updateNotification(element.id);
                                    }
                                    setState(() {
                                      element.isReaded = 1;
                                    });
                                    context
                                        .read<NotificationCubit>()
                                        .getNotification(
                                          AppCubitStorage().state.tokenUser,
                                          AppCubitStorage().state.codeAssDefaul,
                                        );

                                    context
                                        .read<NotificationCubit>()
                                        .countNotification();
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
                            ),
                          ]),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: context
                                      .read<NotificationCubit>()
                                      .state
                                      .isAllElement ==
                                  false
                              ? Container(
                                  // color: AppColors.red,
                                  width: 20.r,
                                  height: 150.r,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.green,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 20.w,
                                  height: 200.h,
                                  // color: AppColors.barrierColorModal,
                                  child: Image.asset(
                                    "assets/images/Empty_box.png",
                                  ),
                                ),
                        )
                      ],
                    )),
                    // Padding(
                    //   padding: EdgeInsets.all(10),
                    //   child: CircularProgressIndicator(),
                    // ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}

// if (NotificationState.isLoading == true &&
//     NotificationState.notifications != null)
//   Container(
//     child: EasyLoader(
//       backgroundColor: Color.fromARGB(0, 255, 255, 255),
//       iconSize: 50.r,
//       iconColor: AppColors.blackBlueAccent1,
//       image: AssetImage(
//         "assets/images/AssoplusFinal.png",
//       ),
//     ),
//   )

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
            margin: EdgeInsets.only(top: 10.h, bottom: 0),
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
                margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                width: 45.w,
                height: 45.w,
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
                  margin: EdgeInsets.only(right: 20.w),
                  // padding: EdgeInsets.all(3),
                  // child: Text('${parsedstring}'),
                  child: isReaded == 1
                      ? Column(
                          children: [
                            Html(
                              data:
                                  "<p style='color:#142D63 ; text-align:center; font-size:${14.sp}px'>${description}</p>",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: 10.w, bottom: 9.h),
                                  child: Text(
                                    "${formatHeurUnikLiteral(dateCreate)}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
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
                              padding: EdgeInsets.all(7.r),
                              child: Text(
                                "$descriptionSansBalise",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBlue),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "AFFICHER".tr(),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.backgroundAppBAr,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_double_arrow_right,
                                        size: 16.sp,
                                        color: AppColors.backgroundAppBAr,
                                      )
                                    ],
                                  ),
                                  Text(
                                    "${formatHeurUnikLiteral(dateCreate)}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
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
            constraints: BoxConstraints(maxHeight: 350.h),
            child: Padding(
              padding: EdgeInsets.all(12.0.r),
              child: Html(
                data:
                    "<p style='color:#142D63 ; text-align:center; font-size:${16.sp}px;'>${description}</p>",
              ),
            ),
          ),
        );
      });
}
