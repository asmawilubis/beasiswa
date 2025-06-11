import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/models/user_model.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    PreferredSizeWidget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: secondaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context); // Kembali setelah menyimpan
            },
            icon: Icon(Icons.check, color: secondaryColor),
          ),
        ],
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          SizedBox(height: defaultMargin),
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/img_profile.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),

          _buildInputField(label: 'Name', hint: user.name),
          _buildInputField(label: 'Username', hint: '@${user.username}'),
          _buildInputField(label: 'Email Address', hint: user.email),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: header(),
      body: content(),

      resizeToAvoidBottomInset: true,
    );
  }

  Widget _buildInputField({required String label, required String hint}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24), // Beri jarak bawah antar input
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: secondaryTextStyle.copyWith(fontSize: 13)),
          TextFormField(
            style: formTextStyle,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: primaryTextStyle,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: secondaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
