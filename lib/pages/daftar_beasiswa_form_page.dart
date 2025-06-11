import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/providers/beasiswa_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:beasiswa/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaftarBeasiswaFormPage extends StatefulWidget {
  final BeasiswaModel beasiswa;
  const DaftarBeasiswaFormPage({required this.beasiswa, super.key});

  @override
  State<DaftarBeasiswaFormPage> createState() => _DaftarBeasiswaFormPageState();
}

class _DaftarBeasiswaFormPageState extends State<DaftarBeasiswaFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController reasonController = TextEditingController(
    text: '',
  );
  final TextEditingController achievementsController = TextEditingController(
    text: '',
  );

  @override
  void dispose() {
    phoneController.dispose();
    reasonController.dispose();
    achievementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BeasiswaProvider beasiswaProvider = Provider.of<BeasiswaProvider>(
      context,
      listen: false,
    );
    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    Future<void> handleApply() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        // Gabungkan semua input menjadi satu string deskripsi
        String fullDescription = """
          Nomor Telepon: ${phoneController.text}

          Alasan Mendaftar:
          ${reasonController.text}

          Prestasi:
          ${achievementsController.text}
          """;

        bool success = await beasiswaProvider.applyForBeasiswa(
          token: authProvider.user.token!,
          scholarshipId: widget.beasiswa.id,
          description: fullDescription, // Kirim deskripsi yang sudah digabung
        );

        if (!mounted) return;

        if (success) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: secondaryColor,
              content: Text(
                'Pendaftaran berhasil dikirim!',
                style: primaryTextStyle.copyWith(color: primaryColor),
              ),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: alertColor,
              content: const Text(
                'Pendaftaran gagal, periksa kembali data Anda.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        setState(() {
          isLoading = false;
        });
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryTextColor),
        title: Text(
          'Form Pendaftaran',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget buildInputField({
      required String title,
      required TextEditingController controller,
      String? hint,
      int maxLines = 1,
    }) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: formTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller,
              maxLines: maxLines,
              style: formTextStyle,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: subtitleTextStyle,
                fillColor: backgroundColor4,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field ini tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.all(defaultMargin),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Mendaftar untuk: ${widget.beasiswa.name}',
                style: formTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pastikan data yang Anda masukkan sudah benar sebelum mengirim.',
                style: secondaryTextStyle,
              ),
              const SizedBox(height: 20),
              buildInputField(
                title: 'Nomor Telepon Aktif',
                hint: 'Contoh: 08123456xxxx',
                controller: phoneController,
              ),
              buildInputField(
                title: 'Alasan Mendaftar',
                hint: 'Jelaskan mengapa Anda tertarik dengan beasiswa ini',
                controller: reasonController,
                maxLines: 4,
              ),
              buildInputField(
                title: 'Prestasi (Jika ada)',
                hint: 'Sebutkan prestasi yang pernah Anda raih',
                controller: achievementsController,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              isLoading
                  ? LoadingButton()
                  : SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: handleApply,
                      style: TextButton.styleFrom(
                        backgroundColor: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Kirim Pendaftaran',
                        style: buttonLoginStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: header(),
      body: content(),
    );
  }
}
