import 'package:beasiswa/providers/beasiswa_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  Future<void> getInit() async {
    await Provider.of<BeasiswaProvider>(context, listen: false).getBeasiswa();

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 336,
          height: 98,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/logo-white.png')),
          ),
        ),
      ),
    );
  }
}
