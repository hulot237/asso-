import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetActionAppBArChangeAss extends StatefulWidget {

   WidgetActionAppBArChangeAss({super.key, required this.ListAss});
  List? ListAss;

  @override
  State<WidgetActionAppBArChangeAss> createState() =>
      _WidgetActionAppBArChangeAssState();
}

class _WidgetActionAppBArChangeAssState
    extends State<WidgetActionAppBArChangeAss> {
  // List<dynamic>? get currentInfoAssociationAll {
  //   return context.read<UserGroupCubit>().state.userGroup;
  // }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic>? currentInfoAssociationCourant = context.read<UserGroupCubit>().state.userGroupDefault;
    return Container(
      alignment: Alignment.center,
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Container(
            child: GestureDetector(
              onTap: () {
                Modal().showBottomSheetListAss(
                  context,
                  widget.ListAss,
                  
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 255, 26, 9),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.all(1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 25,
                    width: 25,
                    child: Image.network(
                      "${Variables.LienAIP}${context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]["profile_photo"] == null ? "" : context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]["profile_photo"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
