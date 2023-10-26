import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:integration_part_two/authentication/business_logic/auth_cubit.dart';
// import 'package:integration_part_two/pages/homeCoursier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}


Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFEFEFEF),
      
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: Color(0xFFEFEFEF),
    
    body: child,
  );
}



class _VerificationPageState extends State<VerificationPage> {
  TextEditingController countrycode = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Future<void> handleLogin() async {
  //   final email = emailController.text;
  //   final password = passwordController.text;

  //   final success = await context.read<AuthCubit>().login(email, password);

  //   if (success) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => homeCoursier()));

  //     print("success login");
  //     print(success);
  //   } else {
  //     print("erreur login");
  //     print(success);

  //     // Afficher un message d'erreur ou une alerte
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(context: context, child: Container(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        // color: Colors.brown,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        alignment: Alignment.center,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                // flex: 7,
                child: Center(
                  child: Container(
                    // color: Colors.deepOrangeAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Groupe_ou_Asso.png", scale: 4,),
                        SizedBox(height: 30),
                        Text(
                          "vérification".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 27,
                            color: Color.fromARGB(255, 20, 45, 99),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Veuillez saisir le code que vous avez reçu par sms au +237 657565623",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 20, 45, 99),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(12),
                          // alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 20, 45, 99),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width / 1.23,
                                margin: EdgeInsets.only(top: 12),
                                alignment: Alignment.center,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: emailController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Code à 6 chiffres",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(122, 20, 45, 99),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );

                              // handleLogin();
                            },
                            child: Text(
                              "vérifier".tr(),
                              style: TextStyle(fontSize: 19),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF9bc43f),
                              // primary: Color(0xFF6FA629),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),);
    
    
    
  }
}
