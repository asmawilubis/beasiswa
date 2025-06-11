import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/pages/daftar_beasiswa_form_page.dart';
import 'package:beasiswa/providers/beasiswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/theme.dart';
import 'package:provider/provider.dart';

class BeasiswaDetailPage extends StatelessWidget {
  final BeasiswaModel beasiswa;
  const BeasiswaDetailPage({required this.beasiswa, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    BeasiswaProvider beasiswaProvider = Provider.of<BeasiswaProvider>(context);

    final pendaftaran = beasiswaProvider.getRegistrationFor(beasiswa.id);

    Widget header() {
      // ... (kode header tidak berubah)
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

    Widget buildBottomWidget() {
      // ... (kode buildBottomWidget tidak berubah, sudah benar)
      if (pendaftaran == null) {
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

      Color statusColor;
      String statusText;
      IconData statusIcon;
      switch (pendaftaran.status.toLowerCase()) {
        case 'accepted':
          statusColor = Colors.green;
          statusText = 'Pendaftaran Diterima';
          statusIcon = Icons.check_circle;
          break;
        case 'rejected':
          statusColor = alertColor;
          statusText = 'Pendaftaran Ditolak';
          statusIcon = Icons.cancel;
          break;
        case 'pending':
        default:
          statusColor = secondaryColor;
          statusText = 'Status: Dalam Peninjauan';
          statusIcon = Icons.hourglass_top_rounded;
          break;
      }
      return Container(
        constraints: const BoxConstraints(minHeight: 50),
        margin: EdgeInsets.all(defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: statusColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(statusIcon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                statusText,
                textAlign: TextAlign.center,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              // --- PERBAIKAN UTAMA DI SINI ---
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  // Tampilkan chip status jika sudah terdaftar
                  if (pendaftaran != null) ...[
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: secondaryColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check, color: secondaryColor, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'TERDAFTAR',
                            style: secondaryTextStyle.copyWith(
                              color: secondaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
          child: Column(children: [header(), content(), buildBottomWidget()]),
        ),
      ),
    );
  }
}
