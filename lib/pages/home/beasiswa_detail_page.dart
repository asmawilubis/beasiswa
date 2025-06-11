import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/theme.dart';

class BeasiswaDetailPage extends StatefulWidget {
  final BeasiswaModel beasiswa;
  BeasiswaDetailPage({required this.beasiswa});

  @override
  State<BeasiswaDetailPage> createState() => _BeasiswaDetailPageState();
}

class _BeasiswaDetailPageState extends State<BeasiswaDetailPage> {
  Widget header(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.chevron_left),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: defaultMargin,
            right: defaultMargin,
          ),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200],
            image: DecorationImage(
              image: AssetImage('assets/img_beasiswa.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget content(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 17),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        color: backgroundColor1,
      ),
      child: Column(
        children: [
          Container(
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
                        widget.beasiswa.name,
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        widget.beasiswa.category.name,
                        style: secondaryTextStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.beasiswa.description,
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                ),
                SizedBox(height: 16),
                Text(
                  'Persyaratan:',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '1. IPK minimal 3.5\n2. Aktif kuliah di perguruan tinggi terakreditasi\n3. Mengisi formulir pendaftaran',
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(defaultMargin),
            alignment: Alignment.center, // Memastikan isi di tengah
            child: SizedBox(
              height: 54,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Daftar Beasiswa',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor4,
      body: ListView(children: [header(context), content(context)]),
    );
  }
}
