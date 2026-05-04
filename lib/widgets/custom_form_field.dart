import 'package:flutter/material.dart';
import 'package:beasiswa/theme.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final String iconPath;
  final TextEditingController controller;
  final bool obscureText;
  final double marginTop;

  const CustomFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.iconPath,
    required this.controller,
    this.obscureText = false,
    this.marginTop = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  Image.asset(iconPath, width: 17),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      style: formTextStyle,
                      obscureText: obscureText,
                      decoration: InputDecoration.collapsed(
                        hintText: hintText,
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
