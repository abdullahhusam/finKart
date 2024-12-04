import 'package:finkart/features/auth/components/custom_divider.dart';
import 'package:finkart/features/shared/colors/colors.dart';
import 'package:finkart/features/shared/components/auth_button.dart';
import 'package:finkart/features/shared/components/custom_button.dart';
import 'package:finkart/features/shared/components/custom_text.dart';
import 'package:finkart/features/shared/components/custom_text_field.dart';
import 'package:finkart/utils/constants.dart';
import 'package:finkart/utils/routes.dart';
import 'package:finkart/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/user_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IsValid _validEmail = IsValid.none;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final userController = ref.read(userControllerProvider);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  marginBottom: 40,
                  text: "FinKart",
                  style: GoogleFonts.lobster(fontSize: 60),
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
                  marginTop: 15,
                  type: Type.password,
                  onChanged: (value) {
                    setState(() {});
                  },
                  labelText: 'Password',
                  controller: passwordController,
                ),
                CustomButton(
                  marginTop: 40,
                  onPressed: emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty
                      ? () async {
                          FocusScope.of(context).unfocus();
                          if (!validateEmail(emailController.text)) {
                            setState(() {
                              _validEmail = IsValid.notValid;
                            });
                          } else {
                            final success = await userController.loginUser(
                              emailController.text,
                              passwordController.text,
                            );

                            if (success) {
                              context.go(entryPath);
                            } else {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: snackBarErrorColor,
                                    content: Text('Invalid email or password')),
                              );
                            }
                          }
                        }
                      : null,
                  text: "Login",
                ),
                CustomDivider(
                  marginTop: 6.h,
                  marginBottom: 1.5.h,
                ),
                AuthButton(
                  text: "Sign Up Now!",
                  onPressed: () {
                    context.go(signUpPath);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
