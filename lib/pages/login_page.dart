import 'package:beasiswa/theme.dart';
import 'package:beasiswa/widgets/custom_form_field.dart';
import 'package:beasiswa/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );

  bool isLoading = false;

  void handleLogin() async {
    setState(() {
      isLoading = true;
    });

    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    if (await authProvider.login(
      email: emailController.text,
      password: passwordController.text,
    )) {
      if (mounted) {
        if (authProvider.user.roles == 'admin') {
          Navigator.pushNamed(context, '/admin');
        } else {
          Navigator.pushNamed(context, '/home');
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text('Login Gagal', textAlign: TextAlign.center),
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
              'Login',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 2),
            Text('Log In to Your Account', style: subtitleTextStyle),
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          CustomFormField(
            title: 'Email Address',
            hintText: 'Your Email Address',
            iconPath: 'assets/icon_email.png',
            controller: emailController,
            marginTop: 70,
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

    Widget buttonLogin() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: handleLogin,
          style: TextButton.styleFrom(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Login',
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
              "Don't have an account? ",
              style: subtitleTextStyle.copyWith(fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Register',
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
              isLoading ? LoadingButton() : buttonLogin(),
              const Spacer(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
