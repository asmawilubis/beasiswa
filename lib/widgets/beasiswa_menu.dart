import 'package:beasiswa/pages/home/beasiswa_detail_page.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/models/beasiswa_model.dart';

class BeasiswaMenu extends StatelessWidget {
  final BeasiswaModel beasiswa;
  BeasiswaMenu(this.beasiswa);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BeasiswaDetailPage(beasiswa: beasiswa),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: primaryColor,
                child: Image.asset(
                  'assets/img_beasiswa.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    beasiswa.category.name,
                    style: formTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(height: 6),
                  Text(
                    beasiswa.name,
                    style: formTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Selengkapnya',
                    style: formTextStyle.copyWith(
                      fontSize: 12,
                      color: subtitleTextColor,
                      fontWeight: medium,
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
}
