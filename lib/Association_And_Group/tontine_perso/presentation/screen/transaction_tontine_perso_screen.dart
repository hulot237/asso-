import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_state.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/transaction_tontine_perso_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/transaction_tontine_perso_state.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/presentation/screen/deposit_screen.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/presentation/screen/transfert_screen.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/token_interceptor.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';

final Dio dio = Dio()
  ..interceptors.addAll([
    TokenInterceptor(),
  ]);

class TransactionTontinePersoScreen extends StatefulWidget {
  @override
  State<TransactionTontinePersoScreen> createState() =>
      _TransactionTontinePersoScreenState();

  TransactionTontinePersoScreen({
    required this.accountRef,
  });
  final String accountRef;
}

class _TransactionTontinePersoScreenState
    extends State<TransactionTontinePersoScreen> {
  // Fonction spécifique pour le dépôt
  // void _handleDeposit() {
  //   // Code pour gérer le dépôt
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DepositScreen(),
  //     ),
  //   );
  //   print('Dépôt sélectionné');
  //   // Vous pouvez naviguer vers une autre page ou afficher une boîte de dialogue
  // }

  // Fonction spécifique pour le retrait
  void _handleWithdraw() {
    // Code pour gérer le retrait
    print('Retrait sélectionné');
    // Vous pouvez naviguer vers une autre page ou afficher une boîte de dialogue
  }

  // Fonction spécifique pour le transfert
  void _handleTransfer() {
    // Code pour gérer le transfert
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransfertScreen(
          publicRef: widget.accountRef,
        ),
      ),
    );
    print('Transfert sélectionné');
    // Vous pouvez naviguer vers une autre page ou afficher une boîte de dialogue
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<TransactionTontinePersoCubit>()
        .fetchTransaction(widget.accountRef);
  }

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
            'Ma tontine personnelle',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.backgroundAppBAr,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(),
              SizedBox(height: 20),
              Text(
                'Historiques',
                style: TextStyle(
                  color: AppColors.blackBlue,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<TransactionTontinePersoCubit,
                    TransactionTontinePersoState>(
                  builder: (context, state) {
                    if (state is TransactionLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColors.blackBlue,
                      ));
                    } else if (state is TransactionError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is TransactionLoaded) {
                      return ListView.builder(
                        itemCount: state.transactionReponse!.length,
                        itemBuilder: (context, index) {
                          final payment = state.transactionReponse![index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(6.r),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 7.w,
                                          top: 7.h,
                                          bottom: 3.h,
                                          right: 7.w,
                                        ),
                                        child: Text(
                                          "${formatDateLiteral("${payment.createdAt}")}",
                                          style: TextStyle(
                                            color: AppColors.blackBlueAccent1,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Html(
                                      data:
                                          "<p style='color:#142D63; font-size:${14.sp}px; margin:0;'>${payment.description}</p>",
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 7.w,
                                        bottom: 10.h,
                                        top: 3.h,
                                        right: 7.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Montant',
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text(
                                                '${formatMontantFrancais(double.parse("${payment.amount}"))} FCFA',
                                                style: TextStyle(
                                                  color: payment.type == "0"
                                                      ? AppColors
                                                          .greenAssociation
                                                      : AppColors.red,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nouveau solde',
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text(
                                                '${formatMontantFrancais(double.parse("${payment.balanceAfter}"))} FCFA',
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Frais',
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text(
                                                '${formatMontantFrancais(double.parse("${payment.fees}"))} FCFA',
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(); // Handle other states if needed
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return BlocBuilder<TontinePersoCubit, TontinePersoState>(
      builder: (context, state) {
        final cubit = context.read<TontinePersoCubit>();
        final isNoSubmit = cubit.isNoSubmit;
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'MON SOLDE',
                          style: TextStyle(
                            color: AppColors.blackBlueAccent1,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              AppCubitStorage().state.maskSold
                                  ? "* * * *"
                                  : AppCubitStorage().state.isNoSubmit
                                      ? "0 FCFA"
                                      : "${formatMontantFrancais(double.parse(state.dataTontinePerso["data"]["ass_savings"][0]["faroti_balance"]))} FCFA",
                              // '100,000 XAF',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackBlue,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            if (state is TontinePersoLoading)
                              Container(
                                width: 10.r,
                                height: 10.r,
                                child: CircularProgressIndicator(
                                  color: AppColors.blackBlue,
                                  strokeWidth: 1.w,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Mon numéro\n${state.dataTontinePerso["data"]["user_phones"][0]["phone"]}',
                      style: TextStyle(
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      Icons.download,
                      'Dépôt',
                      () => showDepositPopup(
                        context,
                        state.dataTontinePerso["data"]["user_phones"][0]
                            ["phone"],
                        state.dataTontinePerso["data"]["ass_savings"][0]
                            ["public_ref"],
                        state.dataTontinePerso["data"]["ass_savings"][0]
                            ["public_ref"],
                      ),
                    ),
                    _buildActionButton(
                        Icons.upload, 'Retrait', _handleWithdraw),
                    _buildActionButton(
                        Icons.send, 'Transfert', _handleTransfer),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, size: 25.sp, color: AppColors.blackBlue),
          SizedBox(height: 5.h),
          Text(
            label,
            style: TextStyle(
              color: AppColors.blackBlue,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

//   import 'dart:convert';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:faroty_association_1/Modals/fonction.dart';
// import 'package:faroty_association_1/Theming/color.dart';
// import 'package:faroty_association_1/localStorage/localCubit.dart';
// import 'package:faroty_association_1/network/token_interceptor.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pinput/pinput.dart';
// import 'package:toastification/toastification.dart';

  final defaultPinTheme = PinTheme(
    width: 50.w,
    height: 50.w,
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

  final TextEditingController _controllerPin = TextEditingController();
  bool isCodeValid = false;
  bool isLoading = false;

  void showDepositPopup(BuildContext context, String numero, String publicRef,
      String accountRef) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return DepositPopupWidget(
          numero: numero,
          publicRef: publicRef,
          accountRef: accountRef,
        );
      },
    );
  }

  void _showLoadingPopup(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Processing'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Processing your request...'),
              ],
            ),
          );
        },
      );
    }
  }
}

class DepositPopupWidget extends StatefulWidget {
  final String numero;
  final String publicRef;
  final String accountRef;

  DepositPopupWidget(
      {required this.numero,
      required this.publicRef,
      required this.accountRef});

  @override
  _DepositPopupWidgetState createState() => _DepositPopupWidgetState();
}

class _DepositPopupWidgetState extends State<DepositPopupWidget> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Approvisionner votre code',
        style: TextStyle(
          color: AppColors.blackBlue,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Numéro de téléphone",
              style: TextStyle(
                color: AppColors.blackBlue,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            height: 40.h,
            child: TextField(
              enabled: false,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: AppColors.blackBlue,
                fontSize: 14.sp,
                letterSpacing: 2.w,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: AppColors.blackBlue,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.only(left: 15.w),
                hintText: widget.numero,
                hintStyle: TextStyle(
                    letterSpacing: 2.w,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackBlue),
                labelStyle: TextStyle(
                  color: AppColors.blackBlueAccent1,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.colorButton,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.blackBlueAccent1,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
              autofocus: true,
            ),
          ),
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Montant",
              style: TextStyle(
                color: AppColors.blackBlue,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            height: 40.h,
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: AppColors.blackBlue,
                fontSize: 14.sp,
                letterSpacing: 2.w,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: AppColors.blackBlue,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.only(left: 15.w),
                suffix: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    'FCFA',
                    style: TextStyle(
                      color: AppColors.blackBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                hintText: "Entrez le montant",
                hintStyle: TextStyle(
                    letterSpacing: 2.w,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackBlue.withOpacity(.3)),
                labelStyle: TextStyle(
                  color: AppColors.blackBlueAccent1,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.colorButton,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.blackBlueAccent1,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
              autofocus: true,
            ),
          ),
          SizedBox(
            height: 30.h,
            width: MediaQuery.of(context).size.width,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5.h,
                    bottom: 5.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.colorButton,
                    ),
                  ),
                  child: Text(
                    "Annuler",
                    style: TextStyle(
                      color: AppColors.colorButton,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  final amount = _amountController.text;
                  Navigator.of(context).pop(); // Close the deposit popup
                  _showConfirmationPopup(
                      context,
                      amount,
                      widget.numero,
                      widget.publicRef,
                      widget.accountRef); // Show confirmation popup
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: 5.h,
                    bottom: 5.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.colorButton,
                  ),
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        
        
        
        ],
      ),
    );
  }

  void _showConfirmationPopup(BuildContext context, String amount,
      String numero, String publicRef, String accountRef) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          numero: numero,
          amount: amount,
          publicRef: publicRef,
          accountRef: accountRef,
        );
      },
    );
  }
}

class ConfirmationPopup extends StatefulWidget {
  final String amount;
  final String numero;
  final String publicRef;
  final String accountRef;

  ConfirmationPopup(
      {required this.amount,
      required this.numero,
      required this.publicRef,
      required this.accountRef});

  @override
  _ConfirmationPopupState createState() => _ConfirmationPopupState();
}

class _ConfirmationPopupState extends State<ConfirmationPopup> {
  final TextEditingController _controllerPin = TextEditingController();
  bool isLoading = false;
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
    return AlertDialog(
      title: Text(
        'Confirmer le depot',
        style: TextStyle(
          color: AppColors.blackBlue,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Approvisonnement à partir de :',
                  style: TextStyle(
                    color: AppColors.blackBlue,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  widget.numero,
                  style: TextStyle(
                    color: AppColors.blackBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Montant :',
                  style: TextStyle(
                    color: AppColors.blackBlue,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "${formatMontantFrancais(double.parse(widget.amount))} FCFA",
                  style: TextStyle(
                    color: AppColors.blackBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100.h,
            child: Pinput(
              length: 4,
              autofocus: true,
              obscureText: true,
              separatorBuilder: (index) {
                return SizedBox(width: 15.w);
              },
              scrollPadding: EdgeInsets.all(20.r),
              controller: _controllerPin,
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
                final enteredCode = _controllerPin.text;
                if (enteredCode ==
                    AppCubitStorage().state.passWordTontinePerso) {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    final payRef = await initiateDeposit(
                        widget.amount, widget.numero, widget.publicRef);
                    _controllerPin.text = "";
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                    _showWaitingPopup(
                        context, payRef, widget.accountRef, widget.numero);
                  } catch (e) {
                    _controllerPin.text = "";
                    setState(() {
                      isLoading = false;
                    });
                    toastification.show(
                      context: context,
                      title: Text(
                        "Une erreur est survenue veuillez réessayer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      autoCloseDuration: Duration(seconds: 3),
                      type: ToastificationType.error,
                      style: ToastificationStyle.minimal,
                    );
                    Navigator.of(context).pop();
                  }
                } else {
                  _controllerPin.text = "";
                  toastification.show(
                    context: context,
                    title: Text(
                      "PIN incorrect",
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
                  Navigator.of(context).pop(false);
                }
              },
            ),
          ),
          SizedBox(
            height: 30.h,
            width: MediaQuery.of(context).size.width,
          ),
          isLoading
              ? CircularProgressIndicator(
                  strokeWidth: 1.w,
                  color: AppColors.colorButton,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: 5.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColors.colorButton,
                          ),
                        ),
                        child: Text(
                          "Annuler",
                          style: TextStyle(
                            color: AppColors.colorButton,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (_controllerPin.text ==
                            AppCubitStorage().state.passWordTontinePerso) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            final payRef = await initiateDeposit(
                                widget.amount, widget.numero, widget.publicRef);
                            _controllerPin.text = "";
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                            _showWaitingPopup(
                              context,
                              payRef,
                              widget.accountRef,
                              widget.numero,
                            );
                          } catch (e) {
                            _controllerPin.text = "";
                            setState(() {
                              isLoading = false;
                            });
                            toastification.show(
                              context: context,
                              title: Text(
                                "Une erreur est survenue veuillez réessayer",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.blackBlue,
                                    fontWeight: FontWeight.bold),
                              ),
                              autoCloseDuration: Duration(seconds: 3),
                              type: ToastificationType.error,
                              style: ToastificationStyle.minimal,
                            );
                            Navigator.of(context).pop();
                          }
                        } else {
                          _controllerPin.text = "";
                          toastification.show(
                            context: context,
                            title: Text(
                              "PIN incorrect",
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
                          Navigator.of(context).pop(false);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: 5.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.colorButton,
                        ),
                        child: Text(
                          "Continuer",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  void _showWaitingPopup(
      BuildContext context, String payRef, String accountRef, String numero) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WaitingPopup(
          payRef: payRef,
          numero: numero,
          accountRef: accountRef,
        );
      },
    );
  }

  // Implémentez la méthode _showWaitingPopup ici

  // void _showWaitingPopup(BuildContext context, String payRef) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           String statusMessage = 'Waiting for deposit validation...';
  //           String timeRemaining = '02:30';
  //           Timer? countdownTimer;
  //           int remainingSeconds = 150;

  //           void startCountdown(Duration duration) {
  //             remainingSeconds = duration.inSeconds;
  //             countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //               if (remainingSeconds <= 0) {
  //                 timer.cancel();
  //                 setState(() {
  //                   timeRemaining = '00:00';
  //                 });
  //                 return;
  //               }

  //               setState(() {
  //                 remainingSeconds--;
  //                 final minutes = remainingSeconds ~/ 60;
  //                 final seconds = remainingSeconds % 60;
  //                 timeRemaining =
  //                     '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  //               });
  //             });
  //           }

  //           startCountdown(Duration(seconds: 150));

  //           Future<void> checkStatus() async {
  //             final endTime = DateTime.now().add(Duration(seconds: 150));
  //             while (DateTime.now().isBefore(endTime)) {
  //               bool status = await checkDepositStatus(payRef);
  //               if (status) {
  //                 if (Navigator.of(context).canPop()) {
  //                   setState(() {
  //                     statusMessage = 'Deposit validated';
  //                   });
  //                   countdownTimer?.cancel();
  //                   return;
  //                 }
  //               }
  //               await Future.delayed(Duration(seconds: 5));
  //             }
  //             if (Navigator.of(context).canPop()) {
  //               setState(() {
  //                 statusMessage = 'Deposit not validated within the time limit';
  //               });
  //             }
  //           }

  //           checkStatus();

  //           return AlertDialog(
  //             title: Text('Deposit Status'),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(statusMessage),
  //                 SizedBox(height: 20),
  //                 Text('Time Remaining: $timeRemaining'),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                   countdownTimer?.cancel();
  //                 },
  //                 child: Text('Close'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  ////////////////////////////////////////////////////////////////

  static Future<String> initiateDeposit(
      String amount, String numero, String public_ref) async {
    final url = 'https://payment.core.faroty.com/api/v1/saving-payrequest';
    try {
      final response = await dio.post(
        url,
        data: {
          'phone': numero,
          'amount': amount,
          'public_ref': public_ref,
          'shipping': null,
        },
        options: Options(headers: {
          "username": AppCubitStorage().state.userNameKey,
          "password": AppCubitStorage().state.passwordKey
        }),
      );
      print('initiateDeposit: ${response.data}');

      return response.data["pay_ref"];
    } catch (e) {
      print('Error initiating deposit: $e');
      throw Exception('Failed to initiate deposit');
    }
  }
}

class WaitingPopup extends StatefulWidget {
  final String payRef;
  final String numero;
  final String accountRef;

  WaitingPopup(
      {required this.payRef, required this.numero, required this.accountRef});

  @override
  _WaitingPopupState createState() => _WaitingPopupState();
}

class _WaitingPopupState extends State<WaitingPopup> {
  // String statusMessage = 'Waiting for deposit validation...';
  String timeRemaining = '05:00';
  Timer? countdownTimer;
  Timer? statusCheckTimer;
  int remainingSeconds = 300;
  bool isOkay = false;
  final Dio dio = Dio()
    ..interceptors.addAll([
      TokenInterceptor(),
    ]);

  String validatePhoneNumber(String phoneNumber) {
    final RegExp mtnRegexp = RegExp(r'^6(((7|8)[0-9]{7}$)|(5[0-4][0-9]{6}$))');
    final RegExp orangeRegexp = RegExp(r'^6(((9)[0-9]{7}$)|(5[5-9][0-9]{6}$))');

    if (mtnRegexp.hasMatch(phoneNumber)) {
      return 'MTN';
    } else if (orangeRegexp.hasMatch(phoneNumber)) {
      return 'ORANGE';
    } else {
      return 'UNKNOWN'; // Return a default value or handle the unknown case
    }
  }

  @override
  void initState() {
    super.initState();
    startCountdown(Duration(seconds: 150));
    startStatusCheck();
  }

  void startCountdown(Duration duration) {
    remainingSeconds = duration.inSeconds;
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          timeRemaining = '00:00';
        });
        return;
      }

      setState(() {
        remainingSeconds--;
        final minutes = remainingSeconds ~/ 60;
        final seconds = remainingSeconds % 60;
        timeRemaining =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      });
    });
  }

  void startStatusCheck() {
    final endTime = DateTime.now().add(Duration(seconds: 150));
    statusCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (DateTime.now().isAfter(endTime)) {
        timer.cancel();
        context.read<TontinePersoCubit>().fetchTontinePerso();
        print(("accountRef ${widget.accountRef}"));
        context
            .read<TransactionTontinePersoCubit>()
            .fetchTransaction(widget.accountRef);
        // setState(() {
        //   statusMessage = 'Deposit not validated within the time limit';
        // });
        return;
      }

      bool status = await checkDepositStatus(widget.payRef);
      if (status) {
        context.read<TontinePersoCubit>().fetchTontinePerso();
        context
            .read<TransactionTontinePersoCubit>()
            .fetchTransaction(widget.accountRef);
        if (Navigator.of(context).canPop()) {
          setState(() {
            // statusMessage = 'Deposit validated';
            isOkay = true;
          });
          timer.cancel();
          countdownTimer?.cancel();
          return;
        }
      }
    });
  }

  Future<bool> checkDepositStatus(String payRef) async {
    final url = 'https://api.faroty.com/index.php/api/paycheck';
    try {
      final response = await dio.post(
        url,
        data: {'pay_ref': payRef},
        options: Options(
          headers: {
            "username": AppCubitStorage().state.userNameKey,
            "password": AppCubitStorage().state.passwordKey
          },
        ),
      );

      final responseData =
          jsonDecode(response.data as String) as Map<String, dynamic>;
      print('checkDepositStatus: ${response.data}');

      return responseData["error"] == false;
    } catch (e) {
      print('Error checking deposit status: $e');
      return false;
    }
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    statusCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carrier = validatePhoneNumber(widget.numero);
    final code = carrier == 'MTN'
        ? '*126#'
        : (carrier == 'ORANGE' ? '#150*50#' : 'Code');

    final progress = (remainingSeconds / 150).clamp(0.0, 1.0);
    return AlertDialog(
      // contentPadding: EdgeInsets.all(5.r),
      title: Text(
        'Transaction a été initié!',
        style: TextStyle(
          color: AppColors.blackBlue,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      "Vous allez recevoir une demande de paiement sur votre téléphone, ",
                  style: TextStyle(
                    color: AppColors.blackBlue,
                    fontSize: 14.sp,
                  ),
                ),
                TextSpan(
                  text: "sinon composer $code",
                  style: TextStyle(
                    color: AppColors.blackBlue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 70.r,
                width: 70.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5.w,
                  value: isOkay ? 1.0 : progress,
                  backgroundColor: AppColors.blackBlueAccent1,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      isOkay ? AppColors.colorButton : AppColors.blackBlue),
                ),
              ),
              if (!isOkay && remainingSeconds <= 0)
                Container(
                  child: Icon(
                    Icons.close,
                    color: AppColors.blackBlueAccent1,
                    size: 40,
                  ),
                ),
              if (isOkay)
                Container(
                  child: Icon(
                    Icons.check,
                    color: AppColors.colorButton,
                    size: 40,
                  ),
                ),
            ],
          ),
          SizedBox(height: 20),
          if (!isOkay)
            Text(
              // 'Temps écoulé : $timeRemaining',
              "Vérifications en cours . . .",
              style: TextStyle(
                color: AppColors.blackBlue,
                fontSize: 14.sp,
              ),
            ),
          if (isOkay)
            Text(
              "Depôt éffectué !",
              style: TextStyle(
                color: AppColors.blackBlue,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                countdownTimer?.cancel();
                statusCheckTimer?.cancel();
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: 5.h,
                  bottom: 5.h,
                  left: 20.w,
                  right: 20.w,
                ),
                margin: EdgeInsets.only(left: 10.w, top: 30.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.colorButton,
                  ),
                ),
                child: Text(
                  "Fermer",
                  style: TextStyle(
                    color: AppColors.colorButton,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
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
