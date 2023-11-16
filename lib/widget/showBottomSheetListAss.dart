import 'package:flutter/material.dart';

class CustomBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomSheetContent(context);
      },
    );
  }

  static Widget _buildBottomSheetContent(BuildContext context) {
    return Container(
      // Votre contenu de bottom sheet ici
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('Music'),
          ),
          const ListTile(
            leading: Icon(Icons.photo),
            title: Text('Photos'),
            // onTap: () {
            //   // Action à effectuer pour les photos
            //   Navigator.of(context).pop(); // Ferme le bottom sheet
            // },
          ),
        ],
      ),
    );
  }
}