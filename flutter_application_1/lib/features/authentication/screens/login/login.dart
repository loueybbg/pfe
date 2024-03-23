import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/styles/spacing_styles.dart';
import 'package:flutter_application_1/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:flutter_application_1/features/authentication/screens/signup_widgets/signup.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/utils/API/login_request.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/constants/image_string.dart';
import 'package:flutter_application_1/utils/helpers/helper_functions.dart';
import 'package:flutter_application_1/utils/constants/sizes.dart';
import 'package:flutter_application_1/utils/constants/text_string.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/form_divider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title & Sub-Titleh
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage(
                        dark ? TImages.lightAppLogin : TImages.lightAppLogin),
                  ),
                  Text(TTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.sm),
                ],
              ), // Column
              /// Form
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceEtwSections),
                  child: Column(
                    children: [
                      /// Email
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.direct_right),
                            labelText: TTexts.email),
                      ), // TextFormField
                      const SizedBox(height: TSizes.spaceBtwInputFields),

                      /// Password
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: TTexts.password,
                          suffixIcon: Icon(Iconsax.eye_slash),
                        ), // InputDecoration
                      ), // TextFormField
                      const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                      /// Remember Me & Forget Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Remember Me
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const Text(TTexts.rememberMe),
                            ],
                          ), // Row
                          /// Forget Password
                          TextButton(
                              onPressed: () =>
                                  Get.to(() => const ForgetPassword()),
                              child: const Text(TTexts.forgetPassword)),
                        ],
                      ), // Row
                      const SizedBox(height: TSizes.spaceEtwSections),

                      /// Sign In Button
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                loginUser(emailController.text,
                                    passwordController.text);
                              },
                              child: const Text(TTexts.signIn))),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// Create Account Button
                      SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () =>
                                  Get.to(() => const SignupScreen()),
                              child: const Text(TTexts.createAccount))),
                      const SizedBox(height: TSizes.spaceEtwSections),
                    ],
                  ),
                ), // Column
              ), //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: TFormDivider(dark: dark)),
                  Text(TTexts.orSignInWith.capitalize!,
                      style: Theme.of(context).textTheme.labelMedium),
                  Flexible(
                      child: TFom_divider(
                          dividerText: TTexts.orSignInWith.capitalize!)),
                ],
              ),
              const SizedBox(height: TSizes.spaceEtwSections),

              /// Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: TSizes.iconMd,
                        height: TSizes.iconMd,
                        image: AssetImage(TImages.google),
                      ), // Image
                    ), // IconButton
                  ), // Container
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: TSizes.iconMd,
                        height: TSizes.iconMd,
                        image: AssetImage(TImages.facebook),
                      ), // Image
                    ), // IconButton
                  ), // Container
                ],
              ), // Column
            ], // Padding
          ),
        ), // SingleChildScrollView
      ),
    ); // Scaffold
  }
}

Future<void> loginUser(String email, String password) async {
  try {
    String token = await login(email, password);
    if (token.isNotEmpty) {
      Get.to(() => const HomePage());
      print('Login successful!');
    } else {
      print('Login failed');
    }
  } catch (e) {
    print('Login failed: $e');
  }
}



// Future<void> loginUser(String email, String password) async {
//   Map<String, dynamic> result = await login(
//     email: email,
//     password: password,
//   );

//   if (result['success']) {
//     Get.to(() => const HomePage());
//     // Handle successful login here.
//     // For example, navigate to the home screen.
//     print('Login successful!');
//   } else {
//     // Handle login failure here.
//     // For example, show an error message.
//     print('Login failed: ${result['error']}');
//   }
// }
