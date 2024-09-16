import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/data/tontine_perso_repository.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/presentation/screen/code_secu_compte.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:toastification/toastification.dart'; // Pour utiliser File

class ActiveTontineScreen extends StatefulWidget {
  @override
  _ActiveTontineScreenState createState() => _ActiveTontineScreenState();
}

class _ActiveTontineScreenState extends State<ActiveTontineScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? _recto;
  XFile? _verso;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _identificationTypeController =
      TextEditingController();
  final TextEditingController _phoneNumber1Controller = TextEditingController();
  final TextEditingController _phoneNumber2Controller = TextEditingController();

  Future<void> _pickImageOrGalleryRecto() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choisissez une source',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blackBlue,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, ImageSource.camera),
              child: Text(
                'Caméra',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenAssociation,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: Text(
                'Galerie',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenAssociation,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 25,
      );
      if (image != null) {
        setState(() {
          _recto = image;
        });
        print('Image sélectionnée: ${image.path}');
      }
    }
  }

  Future<void> _pickImageOrGalleryVerso() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choisissez une source',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blackBlue,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, ImageSource.camera),
              child: Text(
                'Caméra',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenAssociation,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
              child: Text(
                'Galerie',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenAssociation,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 25,
      );
      if (image != null) {
        setState(() {
          _verso = image;
        });
        print('Image sélectionnée: ${image.path}');
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );

    setState(() {
      _image = image;
    });

    if (image != null) {
      final File file = File(image.path);
      final int fileSizeInBytes = await file.length();
      final double fileSizeInMB =
          fileSizeInBytes / (1024 * 1024); // Convertir les octets en Mo

      print('Image sélectionnée: ${image.path}');
      print('Taille de l\'image: ${fileSizeInMB.toStringAsFixed(2)} Mo');
    }
  }

  Future<void> _validateAndSubmit() async {
    // Vérifiez si une option a été sélectionnée dans le Dropdown
    if (_selectedValue == null) {
      _showErrorDialog('Veuillez sélectionner un type d\'identification.');
      return;
    }

    // Vérifiez si les images sont présentes
    if (_image == null || _recto == null || _verso == null) {
      _showErrorDialog('Veuillez ajouter toutes les images requises.');
      return;
    }

    // Vérifiez si les champs de texte ne sont pas vides
    if (_nameController.text.isEmpty || _surnameController.text.isEmpty) {
      _showErrorDialog('Veuillez remplir tous les champs obligatoires.');
      return;
    }

    // Vérifiez si au moins un numéro de téléphone est renseigné
    if (_phoneNumber1Controller.text.isEmpty &&
        _phoneNumber2Controller.text.isEmpty) {
      _showErrorDialog('Veuillez remplir au moins un numéro de téléphone.');
      return;
    }

    // Si tout est valide, naviguez vers la page suivante
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CodeSecuCompte(
          firstName: _nameController.text,
          lastName: _surnameController.text,
          phone: _phoneNumber1Controller.text,
          identificationType: _identificationTypeController.text,
          selfiePhoto: _image,
          idRectoPhoto: _recto,
          idVersoPhoto: _verso,
        ),
      ),
    );

    //  await TontinePersoRepository().tontinePersoCreate(
    //       firstName: _nameController.text,
    //       lastName: _surnameController.text,
    //       phone1: _phoneNumber1Controller.text,
    //       phone2: _phoneNumber2Controller.text,
    //       identificationType: _identificationTypeController.text,
    //       selfiePhoto: _s!,
    //       idRectoPhoto: _idRectoPhoto!,
    //       idVersoPhoto: _idVersoPhoto!,
    //     context: context,
    //   );
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

  // Variable pour stocker la valeur sélectionnée
  String? _selectedValue;

  // Liste des options disponibles dans le dropdown
  final List<String> _options = ['CNI', 'PASSPORT', 'PERMI'];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            'Activer votre tontine perso',
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
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.grey[300],
                  child: _image == null
                      ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
                      : ClipOval(
                          child: Image.file(
                            File(_image!.path),
                            width: 100.r,
                            height: 100.r,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'PRENEZ UN SELFIE',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              _buildTextField('Nom', _nameController),
              _buildTextField('Prénoms', _surnameController),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.h,
                    child: Center(
                      child: Stack(
                        alignment: Alignment
                            .center, // Center the stack within the container
                        children: [
                          Positioned(
                            right: 20.0, // Adjust the offset as needed
                            child: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: Colors.grey[300],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  "assets/images/orange-money-partenaires-logo.avif",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 3.0, // Adjust the offset as needed
                            child: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: Colors.grey[300],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  "assets/images/MTN_lance_le_premier_chatbot_pour_son_service_de_mobile_money.png",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildTextField(
                        'N° de téléphone transaction', _phoneNumber1Controller),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     CircleAvatar(
              //       radius: 15.r,
              //       backgroundColor: Colors.grey[300],
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(15.r),
              //         child: Image.asset(
              //           "assets/images/MTN_lance_le_premier_chatbot_pour_son_service_de_mobile_money.png",
              //           fit: BoxFit.fill,
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 10.w),
              //     Expanded(
              //       child: _buildTextField('N° de téléphone transaction'.tr(),
              //           _phoneNumber2Controller),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                      color: AppColors.greenAssociation,
                      width: 1.h,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedValue,
                    hint: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Type d’identification'),
                    ),
                    items: _options.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            value,
                            style: TextStyle(
                              color: AppColors.blackBlue,
                              fontSize: 14.sp,
                              letterSpacing: 2.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                    isExpanded: true,
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _pickImageOrGalleryRecto();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: MediaQuery.of(context).size.width / 2.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: _recto != null
                            ? Image.file(
                                File(_recto!.path),
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt,
                                        size: 50.sp,
                                        color: AppColors.blackBlueAccent2),
                                    Text(
                                      "RECTO",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.blackBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        _pickImageOrGalleryVerso();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.width / 2.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: _verso != null
                              ? Image.file(
                                  File(_verso!.path),
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt,
                                          size: 50.sp,
                                          color: AppColors.blackBlueAccent2),
                                      Text(
                                        "VERSO",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      )),
                ],
              ),
              Spacer(),
              Container(
                child: ElevatedButton(
                  onPressed: _validateAndSubmit,
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
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: SizedBox(
        height: 40.h,
        child: TextField(
          controller: controller,
          keyboardType: label == 'N° de téléphone transaction'.tr()
              ? TextInputType.number
              : TextInputType.name,
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
            hintText: label,
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
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          autofocus: true,
        ),
      ),
    );
  }
}
