import 'package:faroty_association_1/Association_And_Group/tontine_perso/data/tontine_perso_repository.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/presentation/screen/transaction_tontine_perso_screen.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';

class CodeSecuCompte extends StatefulWidget {
  @override
  State<CodeSecuCompte> createState() => _CodeSecuCompteState();
  CodeSecuCompte({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.identificationType,
    this.selfiePhoto,
    this.idRectoPhoto,
    this.idVersoPhoto,
  });
  final String firstName;
  final String lastName;
  final String phone;
  final String identificationType;
  final XFile? selfiePhoto;
  final XFile? idRectoPhoto;
  final XFile? idVersoPhoto;
}

class _CodeSecuCompteState extends State<CodeSecuCompte> {
  final _pinController = TextEditingController();
  final _pinConfirmController = TextEditingController();
  bool isLoad = false;

  Future<void> _validateAndSubmit() async {
    // Vérifiez si les champs de texte ne sont pas vides
    if (_pinController.text.isEmpty || _pinConfirmController.text.isEmpty) {
      _showErrorDialog('Veuillez remplir tous les champs obligatoires.');
      return;
    }

    // Vérifiez si au moins un numéro de téléphone est renseigné
    if (_pinController.text != _pinConfirmController.text) {
      _showErrorDialog('Les PIN de confirmation est different');
      return;
    }

    // Si tout est valide, naviguez vers la page suivante
    await TontinePersoRepository().tontinePersoCreate(
      firstName: widget.firstName,
      lastName: widget.lastName,
      phone: widget.phone,
      identificationType: widget.identificationType,
      selfiePhoto: widget.selfiePhoto,
      idRectoPhoto: widget.idRectoPhoto!,
      idVersoPhoto: widget.idVersoPhoto!,
      context: context,
      pinCode: _pinController.text,
    );
  }

  void _showErrorDialog(String message) {
    toastification.show(
      context: context,
      title: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.blackBlue,
            fontWeight: FontWeight.bold),
      ),
      autoCloseDuration: Duration(seconds: 3),
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
    );
  }

  final defaultPinTheme = PinTheme(
    width: 55.w,
    height: 60.w,
    textStyle: TextStyle(
      fontSize: 22.sp,
      color: AppColors.blackBlue,
      fontWeight: FontWeight.bold,
    ),
    decoration: BoxDecoration(
      color: AppColors.colorButton.withOpacity(.2),
      borderRadius: BorderRadius.circular(
        10.r,
      ),
      border: Border.all(
        color: Colors.transparent,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
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
            'Sécuriser vos transactions',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor:
              AppColors.backgroundAppBAr, // Remplacez par votre couleur
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.greenAssociation.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.all(20.r),
                  child: Icon(
                    Icons.lock,
                    size: 70.sp,
                    color: AppColors.blackBlue.withOpacity(.7),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entrer un PIN',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Pinput(
                      length: 4,
                      autofocus: true,
                      obscureText: true,
                      scrollPadding: const EdgeInsets.all(20),
                      controller: _pinController,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) {
                        return SizedBox(
                          width: 25.w,
                        );
                      },
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(
                              color: AppColors.colorButton,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      onCompleted: (pin) async {
                        // if (widget.isForCreate) {
                        //   await handleConfirmationForCreate();
                        // } else {
                        //   await handleConfirmation();
                        // }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirmer le PIN',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Pinput(
                      length: 4,
                      autofocus: true,
                      obscureText: true,
                      separatorBuilder: (index) {
                        return SizedBox(
                          width: 25.w,
                        );
                      },
                      scrollPadding: EdgeInsets.all(20.r),
                      controller: _pinConfirmController,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(
                              color: AppColors.colorButton,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      onCompleted: (pin) async {
                        // if (widget.isForCreate) {
                        //   await handleConfirmationForCreate();
                        // } else {
                        //   await handleConfirmation();
                        // }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 110.h),
                isLoad
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greenAssociation,
                          minimumSize: Size(double.infinity, 40.h),
                        ),
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ))
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoad = true;
                          });
          
                          await _validateAndSubmit();
                          await AppCubitStorage()
                              .updatepassWordTontinePerso(_pinController.text);
          
                          setState(() {
                            isLoad = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greenAssociation,
                          minimumSize: Size(double.infinity, 40.h),
                        ),
                        child: Text(
                          'CONFIRMER',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return Container(
              width: 60,
              height: 60,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
