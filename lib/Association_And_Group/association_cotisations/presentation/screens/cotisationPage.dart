// import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
// import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInFIxed.dart';
// import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInProgress.dart';
// import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInFIxed.dart';
// import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInProgress.dart';
// import 'package:flutter/material.dart';

// class CotisationPage extends StatefulWidget {
//   const CotisationPage({super.key});

//   @override
//   State<CotisationPage> createState() => _CotisationPageState();
// }

// class _CotisationPageState extends State<CotisationPage> {
//   int _pageIndex = 0;
//   var Tab = [true, false, false, true, false, true];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.pageBackground,
//       appBar: AppBar(
//         title: Text("Cotisations"),
//         backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.all(15),
//             child: CustomSlidingSegmentedControl<int>(
//               padding: 10,
//               // height: 25,
//               initialValue: 0,
//               children: {
//                 0: Row(
//                   children: [
//                     Text(
//                       'Cotisations en cours',
//                       style: TextStyle(
//                           color: AppColors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15),
//                     ),
//                     Container(
//                       alignment: Alignment.center,
//                       height: 13,
//                       width: 13,
//                       margin: EdgeInsets.only(left: 3),
//                       decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(50)),
//                       child: Text(
//                         "${Tab.length}",
//                         style: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 8,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//                 1: Text(
//                   'Cotisations éxpiré',
//                   style: TextStyle(
//                       color: const Color.fromARGB(255, 255, 255, 255),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15),
//                 ),
//               },
//               decoration: BoxDecoration(
//                 // border: Border.all(color: Colors.black),
//                 color: Color.fromARGB(85, 9, 185, 255),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               thumbDecoration: BoxDecoration(
//                 // Color.fromARGB(255, 9, 185, 255),
//                 color: Color.fromARGB(255, 9, 185, 255),
//                 borderRadius: BorderRadius.circular(6),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color.fromARGB(97, 0, 0, 0),
//                     blurRadius: 5.0,
//                     spreadRadius: 0.1,
//                     // offset: Offset(
//                     //   0.0,
//                     //   2.0,
//                     // ),
//                   ),
//                 ],
//               ),
//               duration: Duration(milliseconds: 300),
//               curve: Curves.ease,
//               onValueChanged: (index) {
//                 setState(() {
//                   _pageIndex = index;
//                   print(_pageIndex);
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             child: _pageIndex == 0
//                 ? ListView.builder(
//                     padding: EdgeInsets.all(0),
//                     shrinkWrap: true,
//                     itemCount: Tab.length,
//                     itemBuilder: (context, index) {
//                       // Vérifiez la valeur du booléen à l'index actuel
//                       bool valeurBool = Tab[index];

//                       // Renvoyez un widget différent en fonction de la valeur du booléen
//                       if (valeurBool) {
//                         return WidgetCotisationInProgress(
//                           contributionOneUser: '2000',
//                           heureCotisation: '12h30',
//                           dateCotisation: '21/02/2024',
//                           montantCotisations: 3000,
//                           motifCotisations: 'Cotistion reguliere du staff',
//                           nbreParticipant: 24,
//                           soldeCotisation: '23500',
//                           nbreParticipantCotisationOK: 7,
//                           montantSanctionCollectee: '24000',
//                           isActive: 1,
//                           montantMin: "100",
//                         );
//                       } else {
//                         return WidgetCotisationInFixed(
//                           codeCotisation: "zzzzzz",
//                           contributionOneUser: '2000',
//                           heureCotisation: '12h30',
//                           dateCotisation: '21/02/2024',
//                           montantCotisations: 3000,
//                           motifCotisations: 'Cotistion reguliere du staff',
//                           nbreParticipant: 24,
//                           soldeCotisation: '18000',
//                           nbreParticipantCotisationOK: 7,
//                           isActive: 1,
//                         );
//                       }
//                     },
//                   )
//                 : ListView.builder(
//                     padding: EdgeInsets.all(0),
//                     shrinkWrap: true,
//                     itemCount: Tab.length,
//                     itemBuilder: (context, index) {
//                       // Vérifiez la valeur du booléen à l'index actuel
//                       bool valeurBool = Tab[index];

//                       // Renvoyez un widget différent en fonction de la valeur du booléen
//                       if (valeurBool) {
//                         return WidgetCotisationExpireInFixed(
//                           contributionOneUser: '2000',
//                           heureCotisation: '12h30',
//                           dateCotisation: '21/02/2024',
//                           montantCotisations: 3000,
//                           motifCotisations: 'Cotistion reguliere du staff',
//                           nbreParticipant: 24,
//                           soldeCotisation: '24000',
//                           nbreParticipantCotisationOK: 7,
//                           // montantSanctionCollectee: '24000',
//                           isActive: 0,
//                         )
//                             // Ajoutez ici le widget que vous souhaitez afficher pour true
//                             ;
//                       } else {
//                         return WidgetCotisationExpireInProgress(
//                           contributionOneUser: '2000',
//                           heureCotisation: '12h30',
//                           dateCotisation: '21/02/2024',
//                           montantCotisations: 3000,
//                           motifCotisations: 'Cotistion reguliere du staff',
//                           nbreParticipant: 24,
//                           soldeCotisation: '30000',
//                           nbreParticipantCotisationOK: 7,
//                           // montantSanctionCollectee: '24000',
//                           isActive: 0, 
//                           codeCotisation: '',
//                         )
//                             // Ajoutez ici le widget que vous souhaitez afficher pour false
//                             ;
//                       }
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
