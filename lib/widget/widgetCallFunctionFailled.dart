import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';


class callFunctionFailled extends StatefulWidget {
  Function reFunction;

   callFunctionFailled({
    required Function this.reFunction,
    super.key,
  });


  @override
  State<callFunctionFailled> createState() => _callFunctionFailledState();
}

class _callFunctionFailledState extends State<callFunctionFailled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Opacity(
                opacity: 0.2,
                child: Container(
                  padding: EdgeInsets.all(7),
                  child: Image.asset(
                    "assets/images/Groupe_ou_Asso.png",
                    width: 60,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(360)),
                  child: Icon(
                    Icons.history,
                    size: 18,
                    color: AppColors.blackBlueAccent1,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Vérifier l'état de votre connexion Internet",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic,
                fontSize: 12),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            width: 72,
            padding: EdgeInsets.only(
              left: 6,
              right: 6,
              top: 4,
              bottom: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.colorButton,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              onTap: () {
                widget.reFunction();
              },
              child: Container(
                child: Text(
                  "Réessayer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.white,
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