import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/pages/daftar_beasiswa_form_page.dart';
import 'package:beasiswa/providers/beasiswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/theme.dart';
import 'package:provider/provider.dart';

class BeasiswaDetailPage extends StatelessWidget {
  // Ubah ke StatelessWidget
  final BeasiswaModel beasiswa;
  const BeasiswaDetailPage({required this.beasiswa, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Akses provider di dalam build method
    BeasiswaProvider beasiswaProvider = Provider.of<BeasiswaProvider>(context);

    // Panggil fungsi untuk memeriksa status pendaftaran
    bool sudahTerdaftar = beasiswaProvider.isRegistered(beasiswa.id);

    Widget header() {
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
                  child: const Icon(Icons.chevron_left, size: 32),
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
              image: const DecorationImage(
                image: AssetImage('assets/img_beasiswa.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    }

    // Widget baru untuk tombol di bagian bawah halaman
    Widget bottomButton() {
      // Jika sudah terdaftar, tampilkan widget status
      if (sudahTerdaftar) {
        return Container(
          height: 50,
          margin: EdgeInsets.all(defaultMargin),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green, // Warna untuk menandakan status
            border: Border.all(color: Colors.green.shade700),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Anda Sudah Terdaftar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }

      // Jika belum terdaftar, tampilkan tombol untuk mendaftar
      return Container(
        width: double.infinity,
        height: 54,
        margin: EdgeInsets.all(defaultMargin),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => DaftarBeasiswaFormPage(beasiswa: beasiswa),
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Daftar Beasiswa',
            style: buttonLoginStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.only(top: 17),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          color: backgroundColor1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (kode untuk nama, kategori, deskripsi, dll. tetap sama)
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
                          beasiswa.name,
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          beasiswa.category.name,
                          style: secondaryTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    beasiswa.description,
                    style: secondaryTextStyle.copyWith(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Persyaratan:',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. IPK minimal 3.5\n2. Aktif kuliah di perguruan tinggi terakreditasi\n3. Mengisi formulir pendaftaran',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor4,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              content(),
              // Panggil widget tombol kondisional di sini
              bottomButton(),
            ],
          ),
        ),
      ),
    );
  }
}
