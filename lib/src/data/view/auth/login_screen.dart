import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
import 'package:admin_side/src/data/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    var size = MediaQuery.of(context).size;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? tbgDarkColor : tbgColor,
      body: SingleChildScrollView(child: mainBody(size, context, isDark)),
    );
  }

  Widget mainBody(Size size, BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //app logo
          appLogo(size, context),
          //login form
          loginForm(isDark, size, context),
        ],
      ),
    );
  }

  Widget loginForm(bool isDark, Size size, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: screenHeight / 2,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //login text
          Text(
            "Login",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          //form field
          formfield(loginController),
          //forgot password
          forgetPassword(context),
          //login button
          loginButton(),
        ],
      ),
    );
  }

  //login button
  Obx loginButton() {
    return Obx(
      () {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                loginController.login();
              }
            },
            child: loginController.loginLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : const Text("Login"),
          ),
        );
      },
    );
  }

  //forget password
  Widget forgetPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            'Forgot Password?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  //app logo
  Widget appLogo(Size size, BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: size.height / 2,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // app icon
            const SizedBox(
              height: 150,
              width: 150,
              child: Image(
                image: AssetImage("assets/icons/appIcon2.png"),
              ),
            ),
            //E-Clothing store text
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: 'E-Clothing\n',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: tappColor,
                      fontSize: 40,
                    ),
                children: [
                  TextSpan(
                    text: 'Store',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: tappColor,
                          fontSize: 35,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //form field
  Widget formfield(LoginController loginController) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //email
          TextFormField(
            validator: (value) => loginController.validateEmail(),
            controller: loginController.emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(
                Icons.alternate_email,
              ),
            ),
          ),
          const SizedBox(height: 15),
          //password
          TextFormField(
            validator: (value) => loginController.validatepassword(),
            obscureText: true,
            controller: loginController.passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(
                Icons.lock_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
