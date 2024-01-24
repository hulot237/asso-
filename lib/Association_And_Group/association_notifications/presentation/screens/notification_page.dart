import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/data/notification_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

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
          "active_de_retrait".tr(),
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
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white),
      ),
    ),
    body: child,
  );
}

class _NotificationPageState extends State<NotificationPage> {
    Future<void> getNotification() async {
      await context.read<NotificationCubit>().getNotification(AppCubitStorage().state.tokenUser, AppCubitStorage().state.codeAssDefaul);

    }
  @override
  void initState() {
    getNotification();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleDetailUser(userCode) async {
      final allCotisationAss =
          await context.read<AuthCubit>().detailAuthCubit(userCode);

      if (allCotisationAss != null) {
      } else {}
    }


    return PageScaffold(
        context: context,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Container(
            child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (NotificationContext, NotificationState) {
              if (NotificationState.isLoading == true && NotificationState.notifications == null)
                return Container(
              child: EasyLoader(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                iconSize: 50,
                iconColor: AppColors.blackBlueAccent1,
                image: AssetImage(
                  'assets/images/Groupe_ou_Asso.png',
                ),
              ),
            );
              final currentNotifications =
                  context.read<NotificationCubit>().state.notifications;

              return ListView.builder(
                  itemCount: currentNotifications!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final itemWithdrawals = currentNotifications[index];

                    return GestureDetector(
                      onTap: () async{
                        print(itemWithdrawals.id!);
                        await NotificationRepository().updateNotification(itemWithdrawals.id!);
                        print(itemWithdrawals.id!);
                        await context.read<NotificationCubit>().getNotification(AppCubitStorage().state.tokenUser, AppCubitStorage().state.codeAssDefaul);
                        // handleApproveWithdraw(itemWithdrawals["id"],
                        // AppCubitStorage().state.membreCode);
                      },
                      child: notificationWidget(
                        idNotification: itemWithdrawals.id!,
                        description: itemWithdrawals.description!,
                        dateCreate: formatDateLiteral(itemWithdrawals.createdAt!),
                        isReaded: itemWithdrawals.isReaded!, 
                        source_name: itemWithdrawals.sourceName!,
                        
                      ),
                    );
                  });
            }),
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
  });

  final String description;
  final String dateCreate;
  final int isReaded;
  final int idNotification;
  final String source_name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
           dateCreate,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.blackBlue),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.blackBlueAccent2,
                borderRadius: BorderRadius.circular(360),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Icon(
                Icons.notifications,
                color: AppColors.blackBlue,
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
                padding: EdgeInsets.all(8),
                // child: Text('${parsedstring}'),
                child: Html(
                  data: description,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
