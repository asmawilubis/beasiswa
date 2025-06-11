// lib/pages/home/beasiswa_detail_page.dart

import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/pages/daftar_beasiswa_form_page.dart'; // <-- 1. TAMBAHKAN IMPORT INI
import 'package:flutter/material.dart';
import 'package:beasiswa/theme.dart';

class BeasiswaDetailPage extends StatefulWidget {
  final BeasiswaModel beasiswa;
  BeasiswaDetailPage({required this.beasiswa, Key? key})
    : super(key: key); // <-- Tambahkan Key

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Agar rapi
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                // Ukuran ikon diperbesar agar mudah disentuh
                child: Icon(
                  Icons.chevron_left,
                  size: 32,
                  color: Colors.black54,
                ),
              ),
              // Bisa ditambahkan tombol lain di sini jika perlu, misal tombol share
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

  Widget content(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 17),
      width: double.infinity,
      // Gunakan Column agar bisa scroll jika kontennya panjang
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Agar tombol bisa full-width
        children: [
          Container(
            padding: EdgeInsets.all(defaultMargin),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
                bottom: Radius.circular(24),
              ),
              color: backgroundColor1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                const SizedBox(height: 30),
                Text(
                  widget.beasiswa.description,
                  style: secondaryTextStyle.copyWith(fontSize: 14),
                  textAlign: TextAlign.justify, // Agar teks deskripsi rapi
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
                  ), // Beri jarak antar baris
                ),
              ],
            ),
          ),
          // Tombol diletakkan di luar container deskripsi agar menempel di bawah
          Padding(
            padding: EdgeInsets.all(defaultMargin),
            child: SizedBox(
              height: 54,
              width: double.infinity,
              child: TextButton(
                // --- 2. PERBAIKI BAGIAN INI ---
                onPressed: () {
                  // Arahkan ke halaman form pendaftaran dengan membawa data beasiswa
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              DaftarBeasiswaFormPage(beasiswa: widget.beasiswa),
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
                  // --- 3. PERBAIKI GAYA TEKS TOMBOL ---
                  style: buttonLoginStyle.copyWith(
                    // Gunakan style yang kontras
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
      backgroundColor: backgroundColor4, // Warna latar belakang utama
      body: SafeArea(
        // Gunakan SafeArea
        child: SingleChildScrollView(
          // Agar bisa di-scroll jika konten melebihi layar
          child: Column(children: [header(context), content(context)]),
        ),
      ),
    );
  }
}
