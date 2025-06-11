import 'package:beasiswa/models/user_model.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/providers/beasiswa_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:beasiswa/widgets/beasiswa_card.dart';
import 'package:beasiswa/widgets/beasiswa_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    BeasiswaProvider beasiswaProvider = Provider.of<BeasiswaProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: formTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: formTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                      color: subtitleTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  // image: NetworkImage(
                  //   user.profilePhotoUrl ?? 'assets/images/profile.png',
                  // ),
                  image: AssetImage('assets/img_profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget categoryBeasiswa() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: defaultMargin),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  'Prestasi',
                  style: primaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: transparentColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: subtitleTextColor),
                ),
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  'Akademik',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: transparentColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: subtitleTextColor),
                ),
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  'Swasta',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: transparentColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: subtitleTextColor),
                ),
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  'Pemerintah',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget daftarBeasiswaTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Beasiswa',
              style: formTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget beasiswaContent() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: defaultMargin),
              Row(
                children:
                    beasiswaProvider.beasiswa
                        .map((beasiswa) => BeasiswaCard(beasiswa))
                        .toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget informasiBeasiswaTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Beasiswa',
              style: formTextStyle.copyWith(fontSize: 22, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget informasiBeasiswa() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: Column(
          children:
              beasiswaProvider.beasiswa
                  .map((beasiswa) => BeasiswaMenu(beasiswa))
                  .toList(),
        ),
      );
    }

    return ListView(
      children: [
        header(),
        categoryBeasiswa(),
        daftarBeasiswaTitle(),
        beasiswaContent(),
        informasiBeasiswaTitle(),
        informasiBeasiswa(),
      ],
    );
  }
}
