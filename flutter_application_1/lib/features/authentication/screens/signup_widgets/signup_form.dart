import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/verify_email.dart';
import 'package:flutter_application_1/features/authentication/screens/login/login.dart';
import 'package:flutter_application_1/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/API/registre_request.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_string.dart';

class TSignupForm extends StatelessWidget {
  TSignupForm({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  void register() {
    // Concatenate firstName and lastName to create fullName
    String fullName =
        '${_firstNameController.text} ${_lastNameController.text}';

    registerUser(fullName, _usernameController.text, _emailController.text,
        _phoneNumberController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.LastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// User NAME
          TextFormField(
            controller: _usernameController,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username, prefixIcon: Icon(Iconsax.edit)),
          ),

          // Emaaill
          TextFormField(
            controller: _emailController,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),
          // phone number
          TextFormField(
            controller: _phoneNumberController,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// PASSWORD
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Terms&Conditions Checkbox
          Row(
            children: [
              SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(value: true, onChanged: (value) {})),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '${TTexts.iAgreeTo}',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: '${TTexts.privacyPolicy} ',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark ? TColors.white : TColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  dark ? TColors.white : TColors.primary,
                            )), // TextSpan
                    TextSpan(
                        text: '${TTexts.and}',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: TTexts.termsofUse,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark ? TColors.white : TColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  dark ? TColors.white : TColors.primary,
                            )), // TextSpan
                  ],
                ), // TextSpan
              ), // Text.rich
            ],
          ), // Row
          const SizedBox(height: TSizes.spaceEtwSections),

          /// Sign Up BUTTON
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    register();
                  }
                },
                child: const Text(TTexts.createAccount),
              ))
        ],
      ),
    );
  }
}

Future<void> registerUser(String fullName, String username, String email,
    String phoneNumber, String password) async {
  final response = await http.post(
    Uri.parse('https://localhost:7172/api/Account/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'FullName': fullName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
    }),
  );

  if (response.statusCode == 200) {
    Get.to(() => LoginScreen());
  } else {
    throw Exception('Failed to register user');
  }
}
