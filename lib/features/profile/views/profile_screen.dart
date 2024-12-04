import 'dart:io';
import 'package:finkart/features/auth/components/country_picker.dart';
import 'package:finkart/features/auth/controllers/user_controller.dart';
import 'package:finkart/features/shared/colors/colors.dart';
import 'package:finkart/features/shared/components/custom_button.dart';
import 'package:finkart/features/shared/components/custom_text_field.dart';
import 'package:finkart/features/shared/components/show_snack_bar.dart';
import 'package:finkart/utils/constants.dart';
import 'package:finkart/utils/routes.dart';
import 'package:finkart/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController countryController;
  late TextEditingController phoneController;

  IsValid _validFirstName = IsValid.none;
  IsValid _validLastName = IsValid.none;
  IsValid _validCountry = IsValid.none;
  IsValid _validPhone = IsValid.none;
  String? userPhotoPath;
  bool _editMode = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userControllerProvider).currentUser;
    firstNameController = TextEditingController(text: user?.firstName);
    lastNameController = TextEditingController(text: user?.lastName);
    countryController = TextEditingController(text: user?.country);
    phoneController = TextEditingController(text: user?.phone);
    userPhotoPath = user?.userPhoto;
  }

  Future<void> _pickNewImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _editMode = true;
        userPhotoPath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = ref.read(userControllerProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickNewImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: userPhotoPath != null
                    ? FileImage(File(userPhotoPath!))
                    : null,
                child: userPhotoPath == null
                    ? Icon(Icons.add_a_photo, size: 50)
                    : null,
              ),
            ),
            CustomTextField(
              marginTop: 50,
              labelText: 'First name',
              controller: firstNameController,
              onChanged: (value) {
                setState(() {
                  _editMode = true;
                  if (validateName(value)) {
                    _validFirstName = IsValid.none;
                  } else {
                    _validFirstName = IsValid.notValid;
                  }
                });
              },
              isValid: _validFirstName,
            ),
            CustomTextField(
              onChanged: (value) {
                setState(() {
                  _editMode = true;
                  if (validateName(value)) {
                    _validLastName = IsValid.none;
                  } else {
                    _validLastName = IsValid.notValid;
                  }
                });
              },
              labelText: 'Last name',
              controller: lastNameController,
              isValid: _validLastName,
            ),
            CountryPicker(
              isValid: _validCountry,
              country: countryController,
              onTap: () {
                setState(() {
                  _editMode = true;
                });
                // setState(() {
                //   _validCountry = true;
                // });
              },
            ),
            if (_editMode)
              CustomButton(
                marginTop: 30,
                width: 200,
                height: 35,
                text: "Save Changes",
                onPressed: () async {
                  await userController.updateUser(
                    firstNameController.text,
                    lastNameController.text,
                    countryController.text,
                    phoneController.text,
                    userPhotoPath,
                  );
                  showSnackBar(
                      context: context,
                      message: "Profile updated successfully",
                      backgroundColor: snackBarSuccessColor);

                  setState(() {
                    _editMode = false;
                  });
                },
              ),
            CustomButton(
              marginTop: 30,
              width: 130,
              height: 30,
              text: "Sign Out",
              backgroundColor: errorColor,
              onPressed: () {
                userController.logout(); // Log the user out
                context.go(loginPath);
              },
            ),
          ],
        ),
      ),
    );
  }
}
