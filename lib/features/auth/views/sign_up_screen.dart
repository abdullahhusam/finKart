import 'dart:io';
import 'package:finkart/features/auth/components/country_picker.dart';
import 'package:finkart/features/auth/components/custom_phone_textfield/intl_phone_field.dart';
import 'package:finkart/features/shared/colors/colors.dart';
import 'package:finkart/features/shared/components/custom_button.dart';
import 'package:finkart/features/shared/components/custom_text.dart';
import 'package:finkart/features/shared/components/custom_text_field.dart';
import 'package:finkart/features/shared/components/show_snack_bar.dart';
import 'package:finkart/utils/constants.dart';
import 'package:finkart/utils/routes.dart';
import 'package:finkart/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../controllers/user_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _editActive = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? userPhotoPath;
  String _phoneNumber = "";

  IsValid _validFirstName = IsValid.none;
  IsValid _validLastName = IsValid.none;
  IsValid _validCountry = IsValid.none;
  IsValid _validPhone = IsValid.none;
  IsValid _validEmail = IsValid.none;
  IsValid _validPassword = IsValid.none;
  IsValid _validConfirmPassword = IsValid.none;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        userPhotoPath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userController = ref.read(userControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.w),
              const CustomText(
                marginBottom: 20,
                text: 'Welcome to Gappy',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
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
              ),
              CustomTextField(
                type: Type.name,
                labelText: 'First name',
                controller: firstNameController,
                onChanged: (value) {
                  setState(() {
                    if (_validFirstName != IsValid.none) {
                      if (validateName(value)) {
                        _validFirstName = IsValid.valid;
                      } else {
                        _validFirstName = IsValid.notValid;
                      }
                    }
                  });
                },
                isValid: _validFirstName,
              ),
              CustomTextField(
                onChanged: (value) {
                  setState(() {
                    if (_validLastName != IsValid.none) {
                      if (validateName(value)) {
                        _validLastName = IsValid.valid;
                      } else {
                        _validLastName = IsValid.notValid;
                      }
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
                  setState(() {});
                  // setState(() {
                  //   _validCountry = true;
                  // });
                },
              ),
              IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'EG',
                onChanged: (phone) {
                  print(phone.completeNumber);
                  _phoneNumber = phone.completeNumber;
                },
                isValid: _validPhone,
              ),
              CustomTextField(
                onChanged: (value) {
                  setState(() {
                    if (_validEmail != IsValid.none) {
                      if (validateEmail(value)) {
                        _validEmail = IsValid.valid;
                      } else {
                        _validEmail = IsValid.notValid;
                      }
                    }
                  });
                },
                labelText: 'Email',
                controller: emailController,
                type: Type.email,
                isValid: _validEmail,
              ),
              CustomTextField(
                type: Type.password,
                onChanged: (value) {
                  setState(() {
                    if (confirmPasswordController.text.isNotEmpty) {
                      confirmPasswordController.clear();
                      _validConfirmPassword = IsValid.none;
                    }

                    if (_validPassword != IsValid.none) {
                      if (validatePassword(value)) {
                        _validPassword = IsValid.valid;
                      } else {
                        _validPassword = IsValid.notValid;
                      }
                    }
                  });
                },
                labelText: 'Password',
                controller: passwordController,
                isValid: _validPassword,
              ),
              CustomTextField(
                onChanged: (value) {
                  setState(() {
                    if (_validConfirmPassword != IsValid.none) {
                      if (confirmPasswordController.text ==
                          passwordController.text) {
                        _validConfirmPassword = IsValid.valid;
                      } else {
                        _validConfirmPassword = IsValid.notValid;
                      }
                    }
                  });
                },
                labelText: 'Confirm password',
                controller: confirmPasswordController,
                type: Type.confirmPassword,
                // passwordConfirm: _passwordText,
                isValid: _validConfirmPassword,
              ),
              Column(
                children: <Widget>[
                  (_validPassword == IsValid.notValid)
                      ? const SizedBox(
                          height: 73,
                          child: CustomText(
                            marginLeft: 10,
                            marginTop: 10,
                            text:
                                "• Password must be at least 8 characters,\n• A combination of uppercase letters, lower letters, numbers, and symbols. ",
                            fontSize: 12,
                          ),
                        )
                      : const SizedBox(
                          height: 73,
                        ),
                  (_validEmail == IsValid.notValid)
                      ? const SizedBox(
                          height: 15.5,
                          child: Center(
                            child: CustomText(
                              fontWeight: FontWeight.w700,
                              color: errorColor,
                              text: "• Wrong email",
                              fontSize: 12,
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 15.5,
                        ),
                  (_validConfirmPassword == IsValid.notValid)
                      ? const SizedBox(
                          height: 15.5,
                          child: Center(
                            child: CustomText(
                              fontWeight: FontWeight.w700,
                              color: errorColor,
                              text: "• Password doesn't match",
                              fontSize: 12,
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 15.5,
                        )
                ],
              ),
              CustomButton(
                onPressed: firstNameController.text.isNotEmpty &&
                        lastNameController.text.isNotEmpty &&
                        countryController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        _phoneNumber.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        confirmPasswordController.text.isNotEmpty &&
                        _validFirstName != IsValid.notValid &&
                        _validLastName != IsValid.notValid &&
                        _validEmail != IsValid.notValid &&
                        _validPassword != IsValid.notValid &&
                        _validConfirmPassword != IsValid.notValid
                    ? () async {
                        setState(() {
                          if (!validateName(firstNameController.text)) {
                            _validFirstName = IsValid.notValid;
                          }
                          if (!validateName(lastNameController.text)) {
                            _validLastName = IsValid.notValid;
                          }
                          if (!validateEmail(emailController.text)) {
                            _validEmail = IsValid.notValid;
                          }
                          if (!validatePassword(passwordController.text)) {
                            _validPassword = IsValid.notValid;
                          }
                          if (confirmPasswordController.text !=
                              passwordController.text) {
                            _validConfirmPassword = IsValid.notValid;
                          }
                        });
                        if (_validFirstName != IsValid.notValid &&
                            _validLastName != IsValid.notValid &&
                            _validEmail != IsValid.notValid &&
                            _validPassword != IsValid.notValid &&
                            _validConfirmPassword != IsValid.notValid) {
                          final success = await userController.createUser(
                            firstNameController.text,
                            lastNameController.text,
                            countryController.text,
                            _phoneNumber,
                            emailController.text,
                            passwordController.text,
                            userPhotoPath,
                          );
                          if (success) {
                            await showSnackBar(
                                duration: const Duration(milliseconds: 500),
                                context: context,
                                message: "Account Created Successfully",
                                backgroundColor: snackBarSuccessColor);
                            context.go(loginPath);
                          } else {
                            showSnackBar(
                                context: context,
                                message: "Email is already in use",
                                backgroundColor: snackBarErrorColor);
                          }
                        }
                      }
                    : null,
                text: "Create Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
