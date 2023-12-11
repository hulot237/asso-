import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';

class widgetListAssCard extends StatefulWidget {
  const widgetListAssCard({
    super.key,
    required this.nomAssociation,
    required this.nbreEventPending,
    required this.phofilAssociation,
    required this.urlcodeAss,
  });

  final String nomAssociation;
  final int nbreEventPending;
  final String phofilAssociation;
  final String? urlcodeAss;

  @override
  State<widgetListAssCard> createState() => _widgetListAssCardState();
}

class _widgetListAssCardState extends State<widgetListAssCard> {

     Color? colorSelect(code_ass) {
      if (code_ass == AppCubitStorage().state.codeAssDefaul) {
        return Color.fromRGBO(0, 162, 255, 0.915);
      } else {
        return Color.fromARGB(23, 20, 45, 99);
      }
      // Aucune correspondance trouvée, retourne null.
      return null;
    }

    Color? colorSelectText(code_ass) {
      if (code_ass == AppCubitStorage().state.codeAssDefaul) {
        return AppColors.white;
      } else {
        return Color.fromARGB(139, 20, 45, 99);
      }
      // Aucune correspondance trouvée, retourne null.
      return null;
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: colorSelect(widget.urlcodeAss),
            borderRadius: BorderRadius.circular(7)),
        margin: EdgeInsets.all(5),
        // padding: EdgeInsets.all(15),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
                height: 50,
                child: Image.network(
                  "${widget.phofilAssociation}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  widget.nomAssociation,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color:colorSelectText(widget.urlcodeAss)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
