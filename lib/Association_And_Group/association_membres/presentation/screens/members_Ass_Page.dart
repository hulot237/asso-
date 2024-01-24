import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_state.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembersAssPage extends StatefulWidget {
  const MembersAssPage({super.key});

  @override
  State<MembersAssPage> createState() => _MembersAssPageState();
}

class _MembersAssPageState extends State<MembersAssPage> {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];

  Future<void> handleShowMembers(codeAssociation) async {
    final detailCotisation =
        await context.read<MembreCubit>().showMembersAss(codeAssociation);

    if (detailCotisation != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailCotisation}");
      print(
          "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<MembreCubit>().state.allMembers}");
    } else {
      print("handleShowMembers null");
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   handleShowMembers(AppCubitStorage().state.codeAssDefaul);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text("Liste des membres".tr()),
        backgroundColor: AppColors.backgroundAppBAr,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            BlocBuilder<MembreCubit, MembreState>(
                builder: (membreContext, membreState) {
              if (membreState.allMembers == null &&
                  membreState.isLoading == true)
                return Expanded(
                  child: Center(
                    child: EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                        'assets/images/Groupe_ou_Asso.png',
                      ),
                    ),
                  ),
                );
              final currentMembers =
                  membreContext.read<MembreCubit>().state.allMembers;
              return Expanded(
                child: Stack(
                  children: [
                    ListView.separated(
                      itemCount: currentMembers!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        final itemMembers = currentMembers[index];
                        return Container(
                          child: Row(
                            children: [
                              Container(
                                width: 65,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        "${Variables.LienAIP}${itemMembers!["photo_profil"] == null ? "" : itemMembers!["photo_profil"]}",
                                      ),
                                      radius: 25,
                                    ),
                                    if (itemMembers["isSuperAdmin"] == true)
                                      Positioned(
                                        left: 35,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 239, 239, 239),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Admin",
                                            style: TextStyle(
                                              color: AppColors.backgroundAppBAr,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${itemMembers["first_name"]} ${itemMembers["last_name"] == null ? '' : itemMembers["last_name"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      if (itemMembers["membre_code"] ==
                                          AppCubitStorage().state.membreCode)
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.2,
                                                color:
                                                    AppColors.backgroundAppBAr,
                                              ),
                                            color: AppColors.blackBlueAccent2,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.all(2),
                                          margin: EdgeInsets.only(left: 2),
                                          child: Text(
                                            "(Vous)".tr(),
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: AppColors.blackBlue,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      if (itemMembers["countrycode"] != 0)
                                        Text(
                                          "${itemMembers["countrycode"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      Text(
                                        "${itemMembers["first_phone"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "${itemMembers["membre_code"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11,
                                        color: AppColors.backgroundAppBAr,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    if (membreState.allMembers != null &&
                        membreState.isLoading == true)
                      Center(
                        child: EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            'assets/images/Groupe_ou_Asso.png',
                          ),
                        ),
                      ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
