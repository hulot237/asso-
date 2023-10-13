// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:integration_part_one/authentication/business_logic/auth_cubit.dart';
// import 'package:integration_part_one/pages/homeClient.dart';
// import 'package:integration_part_one/pages/singuppage.dart';


// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController countrycode = TextEditingController();
   

//   final  emailController = TextEditingController();
//   final  passwordController = TextEditingController();

//   Future<void> handleLogin() async {
//     final email = emailController.text;
//     final password = passwordController.text;

//     final success = await context.read<AuthCubit>().login(email, password);

//     if (success) {
//       Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => homeClient()));
//       print("success login");
//       print(success);
//     } else {
//       print("email: "+ email);
//       print("password: "+ password);
//       print("erreur login");
//       print(success);

//       // Afficher un message d'erreur ou une alerte
//     }
//   }





//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 202, 237, 248),
//       body: Container(
//         margin: const EdgeInsets.only(
//           left: 20,
//           right: 20,
//         ),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 "assets/images/logoOff.png",
//                 width: 250,
//               ),
//               SizedBox(height: 15),
//               const Text(
//                 "Connectez-vous pour profiter de nos services de qualité",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 25),
//               Container(
//                 padding: EdgeInsets.only(left: 10),
//                 height: 55,
//                 decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Color(0xFF8B9597)),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Container(
//                   child: TextField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     style: TextStyle(fontSize: 17),
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Email",
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15),
//               Container(
//                 padding: EdgeInsets.only(left: 10),
//                 height: 55,
//                 decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Color(0xFF8B9597)),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: passwordController,
//                         obscureText: true,
//                         style: TextStyle(fontSize: 17),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Mot de passe",
//                         ),
//                       ),
//                     ),
//                     Container(
//                       child: IconButton(
//                           onPressed: null,
//                           icon: Icon(
//                             Icons.visibility_off,
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 25),
//               SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     handleLogin();
//                   },
//                   child: Text(
//                     'Connexion',
//                     style: TextStyle(fontSize: 19),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF6FA629),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => singupPage()));
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Vous n'avez pas encore de compte? ",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 13),
//                       ),
//                       Text(
//                         "Cliquez ici!",
//                         style: TextStyle(color: Colors.blue),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
