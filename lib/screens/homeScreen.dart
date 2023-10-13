import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Future<void> handleAllUserGroup() async {
    final AllUserGroup =
        await context.read<UserGroupCubit>().AllUserGroupOfUserCubit();

    if (AllUserGroup != null) {
      print("1");
      // print(context.read<UserGroupCubit>().state.userGroup);
    } else {
      print("AllUserGroup null");
    }
  }

  Future<void> handleUserGroupDefault() async {
    final userGroupDefault =
        await context.read<UserGroupCubit>().UserGroupDefaultCubit();

    if (userGroupDefault != null) {
      for (var elt in context
          .read<UserGroupCubit>()
          .state
          .userGroupDefault!["associationTournoi"]) {
        if (elt['is_default'] == 1) {

          print("okkkkkkkkkkkk ${elt["tournois_code"]}");

          // setState(() {
            
         await AppCubitStorage().updateCodeTournoisDefault("${elt["tournois_code"]}");
          // });


          // AppCubitStorage().updateValeur1WithValA(elt['is_default'], "ournois_cod" );

          print(
            "TournoisCodeDefaultCubitStorage==   ${AppCubitStorage().state.codeTournois}",
          );
        }
      }

      // updateDataTournoisCodeDefaul
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleTournoiDefault() async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubit();

    if (detailTournoiCourant != null) {
      // print(
      //     "objectdddddddddddddddddddddddddddddddddd  ${detailTournoiCourant}");
      // print(
      //     "dddddddddddddddddddddddddddddddddddddddd ${context.read<DetailTournoiCourantCubit>().state.detailtournoiCourant}");
    } else {
      print("userGroupDefault null");
    }
  }

  Map<String, dynamic>? get currentInfoAssociationCourant {
    return context.read<UserGroupCubit>().state.userGroupDefault;
  }

  @override
  void initState() {
    // TODO: implement initState
    handleAllUserGroup();
    handleUserGroupDefault();
    handleTournoiDefault();
    super.initState();
  }

  var Tab = [true, false, false, true, false, true, 'expi', 'expi'];

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic>? currentInfoAssociationCourant = context.read<UserGroupCubit>().state.userGroupDefault;
    TabController _tabController = TabController(length: 2, vsync: this);
    return BlocBuilder<UserGroupCubit, UserGroupState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFFEFEFEF),
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                // expandedHeight: 20,
                // toolbarHeight: 1,
                leading: Container(),
                elevation: 0,
                backgroundColor: Color.fromRGBO(0, 162, 255, 0.915),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                  centerTitle: false,
                  title: Container(
                    child: Stack(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 13),
                                  child: Text(
                                    "${currentInfoAssociationCourant!["name"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    // textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Modal().showBottomSheetListAss(
                                    context,
                                    context
                                        .read<UserGroupCubit>()
                                        .state
                                        .userGroup,
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
                                      height: 30,
                                      width: 30,
                                      child: Image.network(
                                        "${Variables.LienAIP}${currentInfoAssociationCourant!['profile_photo']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 2,
                          top: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 26, 9),
                                borderRadius: BorderRadius.circular(50)),
                            width: 5,
                            height: 5,
                          ),
                        )
                      ],
                    ),
                  ),
                  background: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "https://img.freepik.com/premium-vector/lamp-icon-idea-concept-large-group-people-form-create-shape-lamp-vector-illustration_191567-1626.jpg?size=626&ext=jpg&ga=GA1.1.852592464.1694512378&semt=ais",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(85, 255, 255, 255),
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: const Offset(5, 5),
                          ),
                          const BoxShadow(
                              color: Color.fromARGB(4, 255, 255, 255),
                              offset: Offset(-5, -5),
                              blurRadius: 15,
                              spreadRadius: 1),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(0, 85, 85, 85),
                            Color.fromARGB(70, 53, 53, 53),
                            Color.fromARGB(80, 63, 63, 63),
                            Color.fromARGB(221, 46, 46, 46),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SliverPersistentHeader(
                pinned: false,
                floating: false,
                delegate: FixedHeaderBar(
                  maxExtent: 210,
                  minExtent: 210,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SliverTabBar(
                  tabController: _tabController,
                  maxExtent: 50,
                  minExtent: 50,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 2,
                  margin: EdgeInsets.all(5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: Tab.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var valeurBool = Tab[index];

                          if (valeurBool == true) {
                            return GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 7, right: 7, top: 3, bottom: 7),
                                child: WidgetCotisationInFixed(
                                  contributionOneUser: '2000',
                                  heureCotisation: '20h40',
                                  dateCotisation: '03/03/2034',
                                  montantCotisations: 5000,
                                  motifCotisations: 'Fonds de developpement',
                                  nbreParticipant: 5,
                                  soldeCotisation: '20000',
                                  nbreParticipantCotisationOK: 4,
                                  montantSanctionCollectee: '24000',
                                  isActive: 1,
                                ),
                              ),
                            );
                          } else if (valeurBool == false) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetCotisationInProgress(
                                contributionOneUser: '2000',
                                heureCotisation: '12h30',
                                dateCotisation: '21/02/2024',
                                montantCotisations: 3000,
                                motifCotisations:
                                    'Cotistion reguliere du staff',
                                nbreParticipant: 24,
                                soldeCotisation: "25000",
                                nbreParticipantCotisationOK: 7,
                                montantSanctionCollectee: '24000',
                                isActive: 1,
                                montantMin: "200",
                              ),
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetCotisationExpireInFixed(
                                contributionOneUser: '1500',
                                motifCotisations:
                                    'Collecte pour l\'orphelinat coeur des anges',
                                dateCotisation: '22/03/2023',
                                montantCotisations: 3000,
                                heureCotisation: '12h12',
                                montantSanctionCollectee: '2000',
                                nbreParticipantCotisationOK: 10,
                                nbreParticipant: 12,
                                soldeCotisation: '30000',
                                isActive: 0,
                              ),
                            );
                          }
                        },
                      ),
                      ListView.builder(
                        // shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),

                        padding: EdgeInsets.all(0),
                        itemCount: Tab.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(top: 3, bottom: 7),
                              child: WidgetSanctionNonPayeeIsMoney(
                                dateSanction: '23/20/2021',
                                heureSanction: '21h12',
                                montantPayeeSanction: '0',
                                montantSanction: "1200",
                                motifSanction:
                                    "Retard de paiement de la tontine de 5000 FCFA",
                              ));
                        },
                      ),
                      //  Text("2"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SliverTabBar extends SliverPersistentHeaderDelegate {
  const SliverTabBar({
    required this.minExtent,
    required this.maxExtent,
    required TabController tabController,
  }) : _tabController = tabController;

  @override
  final double minExtent;

  @override
  final double maxExtent;

  final TabController _tabController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Color.fromARGB(120, 226, 226, 226),
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            labelColor: Color.fromARGB(255, 20, 45, 99),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            padding: EdgeInsets.all(0),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 20, 45, 99),
                width: 5.0,
              ),
              insets: EdgeInsets.symmetric(horizontal: 36.0),
            ),
            // indicatorWeight: 0,
            controller: _tabController,
            tabs: [
              Tab(
                text: "Cotisations",
              ),
              Tab(
                text: "Sanctions",
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class FixedHeaderBar extends SliverPersistentHeaderDelegate {
  const FixedHeaderBar({required this.minExtent, required this.maxExtent});

  @override
  final double minExtent;

  @override
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // return Container();
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 7),
          padding: EdgeInsets.only(left: 6, right: 6, bottom: 3, top: 3),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(110, 117, 117, 117),
                  spreadRadius: 1,
                  blurRadius: 1)
            ],
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 7, left: 5, bottom: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "rencontre".tr(),
                        style: TextStyle(
                          color: const Color.fromRGBO(20, 45, 99, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(244, 67, 54, 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 7, right: 7, top: 5),
                child: WidgetRencontreCard(
                  dateRencontre: '25/10/2033',
                  descriptionRencontre:
                      'Jeudi se tiendra notre 3 rencontres, soyez donc present a 10h10',
                  heureRencontre: '10h10',
                  identifiantRencontre: '01S01',
                  isActiveRencontre: 0,
                  lieuRencontre: 'Musee Provincial de Douala',
                  nomRecepteurRencontre: 'Baba Ahmadou Danpullo',
                ),
              ),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   // height: 22,
              //   margin: EdgeInsets.only(left: 5, top: 7),
              //   child: Row(
              //     // crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       // Container(
              //       //   child: Text(
              //       //     "Voir les details de la Rencontre",
              //       //     style: TextStyle(
              //       //       color: Color.fromARGB(164, 20, 45, 99),
              //       //       fontWeight: FontWeight.w500,
              //       //       fontSize: 11,
              //       //       letterSpacing: 0.2,
              //       //     ),
              //       //   ),
              //       // ),
              //       Container(
              //         child: Icon(
              //           Icons.keyboard_double_arrow_right_rounded,
              //           size: 12,
              //           color: Color.fromARGB(164, 20, 45, 99),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
