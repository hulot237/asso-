import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdentiteScreen extends StatefulWidget {
  const IdentiteScreen({super.key});

  @override
  State<IdentiteScreen> createState() => _IdentiteScreenState();
}

class _IdentiteScreenState extends State<IdentiteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(
            colorIcon: AppColors.white,
          ),
        ),
        title: Text(
          'Votre identité',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        elevation: 0,
      ),
      body: Material(
        child: BlocBuilder<TontinePersoCubit, TontinePersoState>(
          builder: (context, state) {
            final cubit = context.read<TontinePersoCubit>();
            final isNoSubmit = cubit.isNoSubmit;
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Date de soumission :',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                              TextSpan(
                                text: ' ${formatDateLiteral(state.dataTontinePerso["data"]["updated_at"])}', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Statut :',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                              TextSpan(
                                text: state.dataTontinePerso["data"]["is_valide"]==0? ' En cours de verification':" Validé",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Text(
                        "Piece d'identification :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.blackBlueAccent2,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 170.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        "${Variables.LienAIP}${state.dataTontinePerso["data"]["id_recto_photo"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.blackBlueAccent2,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 170.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        "${Variables.LienAIP}${state.dataTontinePerso["data"]["id_verso_photo"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
