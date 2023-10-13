import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/verificationPage.dart';
import 'package:flutter/material.dart';
// import 'package:integration_part_two/authentication/business_logic/auth_cubit.dart';
// import 'package:integration_part_two/pages/homeCoursier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: Container(
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
                flex: 7,
                child: Center(
                  child: Container(
                    // color: Colors.deepOrangeAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Groupe_ou_Asso.png", scale: 3,),
                        SizedBox(height: 70),
                        Text(
                          "Entrer votre numéro pour obtenir le code d'authentification",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 20, 45, 99),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 25),
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
                                  // width: 90,
                                  child: Text(
                                "+237",
                                style: TextStyle(
                                    color: Color.fromARGB(142, 20, 45, 99),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              )),
                              Container(
                                width: MediaQuery.sizeOf(context).width / 1.5,
                                margin: EdgeInsets.only(top: 12),
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Numero de téléphone",
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
                                      builder: (context) =>
                                          VerificationPage()));
                              // handleLogin();
                            },
                            child: Text(
                              "Vérification",
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
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "msg_condition_utilisation".tr(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 20, 45, 99),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
