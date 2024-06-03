// import 'package:flutter/material.dart';

// class AllEpargneWidget extends StatefulWidget {
//    AllEpargneWidget({
//     super.key,
//     required this.currentEpargne,
//   });

//    var currentEpargne;

//   @override
//   State<AllEpargneWidget> createState() => _AllEpargneWidgetState();
// }

// class _AllEpargneWidgetState extends State<AllEpargneWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text("Kengn djousse Hulot")
//           ],
//         )
//       ],
//     );
//   }
// }






//   void showModalPaySanction(context, nom, resteAPayer, codeSanction, codeMembre, typeSaction,objectSanction) {
//   showDialog(
//       context: context,
//       barrierColor: AppColors.barrierColorModal,
//       builder: (BuildContext context) {
//         Future<void> handleDetailCotisation(codeSanction) async {
//           // final detailTournoiCourant = await context
//           //     .read<DetailTournoiCourantCubit>()
//           //     .detailTournoiCourantCubit();
//           final detailCotisation = await context
//               .read<CotisationDetailCubit>()
//               .detailCotisationCubit(codeSanction);
//         }

//         return Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//           child: Container(
//             constraints: BoxConstraints(maxHeight: typeSaction == "1" ? 250.h: 200.h),
//             child: PaiementSanctionWidget(
//               nom: nom,
//               codeSanction: codeSanction,
//               codeMembre: codeMembre,
//               resteAPayer: resteAPayer,
//               typeSanction: typeSaction,
//               objectSanction: objectSanction,
//             ),
//           ),
//         );
//       });