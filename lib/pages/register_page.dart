import 'package:beasiswa/theme.dart';
import 'package:beasiswa/widgets/loading_button.dart';
import 'package:beasiswa/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameController = TextEditingController(
    text: '',
  );
  final TextEditingController userNameController = TextEditingController(
    text: '',
  );
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );

  bool isLoading = false;

  void handleSignUp() async {
    setState(() {
      isLoading = true;
    });

    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    if (await authProvider.register(
      name: fullNameController.text,
      username: userNameController.text,
      email: emailController.text,
      password: passwordController.text,
    )) {
      if (mounted) Navigator.pushNamed(context, '/login');
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text('Register Gagal', textAlign: TextAlign.center),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 2),
            Text('Register Your Account!', style: subtitleTextStyle),
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          CustomFormField(
            title: 'Full Name',
            hintText: 'Your Full Name',
            iconPath: 'assets/icon_name.png',
            controller: fullNameController,
            marginTop: 50,
          ),
          CustomFormField(
            title: 'Username',
            hintText: 'Your Username',
            iconPath: 'assets/icon_username.png',
            controller: userNameController,
          ),
          CustomFormField(
            title: 'Email Address',
            hintText: 'Your Email Address',
            iconPath: 'assets/icon_email.png',
            controller: emailController,
          ),
          CustomFormField(
            title: 'Password',
            hintText: 'Your Password',
            iconPath: 'assets/icon_password.png',
            controller: passwordController,
            obscureText: true,
          ),
        ],
      );
    }

    Widget buttonRegister() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: handleSignUp,
          style: TextButton.styleFrom(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Register',
            style: buttonLoginStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: subtitleTextStyle.copyWith(fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Login',
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              content(),
              isLoading ? LoadingButton() : buttonRegister(),
              const Spacer(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
