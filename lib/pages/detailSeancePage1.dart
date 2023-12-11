// import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/screens/detailRencontrePage.dart';
// import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
// import 'package:flutter/material.dart';

// class DetailSeancePage1 extends StatefulWidget {
//   const DetailSeancePage1({super.key});

//   @override
//   State<DetailSeancePage1> createState() => _DetailSeancePage1State();
// }

// class _DetailSeancePage1State extends State<DetailSeancePage1> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         backgroundColor: Color.fromARGB(255, 226, 226, 226),
//         appBar: AppBar(
//           leadingWidth: 40,
//           title: Container(
//             padding: EdgeInsets.only(top: 20),
//             child: Text(
//               "Detail de la cotisations",
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.blackBlue,
//               ),
//             ),
//           ),
//           elevation: 0,
//           backgroundColor: Color.fromARGB(255, 226, 226, 226),
//           leading: Container(
//             height: 15,
//             width: 15,
//             padding: EdgeInsets.only(left: 20, top: 20),
//             decoration: BoxDecoration(
//               color: AppColors.green,
//               // color: Color.fromARGB(33, 20, 45, 99),
//               borderRadius: BorderRadius.circular(50),
//             ),
//             margin: EdgeInsets.only(right: 10),
//             child: Icon(
//               Icons.arrow_back,
//               size: 25,
//               color: AppColors.blackBlue,
//             ),
//           ),
//           bottom: TabBar(
//             isScrollable: true,
//             labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//             unselectedLabelStyle: TextStyle(fontSize: 10),
//             padding: EdgeInsets.all(0),
//             indicatorColor: const Color.fromARGB(255, 93, 117, 255),
//             indicator: UnderlineTabIndicator(
//               borderSide: BorderSide(
//                 width: 5.0,
//                 color: Color.fromARGB(255, 255, 255, 255),
//               ),
//               insets: EdgeInsets.symmetric(
//                 horizontal: 100,
//               ),
//             ),
//             indicatorWeight: 0,
//             tabs: [
//               Tab(
//                 text: "Présence",
//               ),
//               Tab(
//                 text: "Cotisations",
//               ),
//               Tab(
//                 text: "Tontine",
//               ),
//               Tab(
//                 text: "Sanctions",
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Container(
//               padding: EdgeInsets.only(
//                 top: 1.5,
//                 left: 1.5,
//                 // bottom: 10,
//                 right: 1.5,
//               ),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 226, 226, 226),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
//                     child: Text(
//                       "La liste de vos tournois en cours",
//                       style: TextStyle(
//                           color: AppColors.blackBlue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           letterSpacing: 0.2),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Container(
//                         // color: Colors.grey,
//                         width: MediaQuery.of(context).size.width,
//                         child: Wrap(
//                           crossAxisAlignment: WrapCrossAlignment.start,
//                           alignment: WrapAlignment.spaceEvenly,
//                           children: [
//                             for (var i = 0; i < 3; i++)
//                               GestureDetector(
//                                 // onTap: () {
//                                 //   Navigator.push(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //       builder: (context) => detailRencontrePage(),
//                                 //     ),
//                                 //   );
//                                 // },
//                                 child: WidgetCompteCard(montantCompte: '', nomCompte: '', numeroCompte: '',),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding:
//                   EdgeInsets.only(top: 1.5, left: 1.5, bottom: 10, right: 1.5),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(69, 255, 31, 31),
//                   boxShadow: [
//                     BoxShadow(
//                         color: const Color.fromARGB(110, 117, 117, 117),
//                         spreadRadius: 1,
//                         blurRadius: 1)
//                   ]),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
//                     child: Text(
//                       "Liste des comptes de l'association",
//                       style: TextStyle(
//                           color: AppColors.blackBlue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           letterSpacing: 0.2),
//                     ),
//                   ),
//                   Wrap(
//                     children: [
//                       for (var i = 0; i < 5; i++)
//                         Container(
//                           width: MediaQuery.of(context).size.width / 3.2,
//                           padding: EdgeInsets.all(5),
//                           margin: EdgeInsets.only(
//                             bottom: 1.5,
//                             right: 1.5,
//                             top: 1.5,
//                             left: 1.5,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(0, 162, 255, 0.815),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Container(
//                                 child: Text(
//                                   "Fonds de caisse",
//                                   style: TextStyle(
//                                       fontSize: 10, color: AppColors.white),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
