import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/providers/beasiswa_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:beasiswa/widgets/beasiswa_list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeasiswaListPage extends StatefulWidget {
  const BeasiswaListPage({super.key});

  @override
  State<BeasiswaListPage> createState() => _BeasiswaListPageState();
}

class _BeasiswaListPageState extends State<BeasiswaListPage> {
  // Future untuk digunakan oleh FutureBuilder
  late Future<void> _registrationsFuture;

  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadRegistrations();
  }

  // Fungsi untuk memuat atau memuat ulang data
  void _loadRegistrations() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _registrationsFuture = Provider.of<BeasiswaProvider>(
      context,
      listen: false,
    ).getRegistrations(authProvider.user.token!);
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text('Beasiswa Terdaftar', style: primaryTextStyle),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget belumTerdaftar() {
      return Container(
        color: backgroundColor2,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bookmark.png',
              width: 74,
              height: 62,
              color: Colors.grey,
            ),
            const SizedBox(height: 23),
            Text(
              'Belum Terdaftar Beasiswa Manapun',
              textAlign: TextAlign.center,
              style: formTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Cari Beasiswa',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: FutureBuilder(
          future: _registrationsFuture,
          builder: (context, snapshot) {
            // Tampilkan loading indicator saat data sedang diambil
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            // Tampilkan pesan error jika terjadi masalah
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Gagal memuat data. Silakan coba lagi.',
                  style: secondaryTextStyle,
                ),
              );
            }

            // Jika data berhasil diambil, gunakan Consumer untuk membangun UI
            return Consumer<BeasiswaProvider>(
              builder: (context, provider, child) {
                // Tampilkan pesan jika tidak ada beasiswa yang terdaftar
                if (provider.registrations.isEmpty) {
                  return belumTerdaftar();
                }

                // Tampilkan daftar beasiswa yang terdaftar
                return Container(
                  color: backgroundColor2,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        _loadRegistrations();
                      });
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                        vertical: 20,
                      ),
                      itemCount: provider.registrations.length,
                      itemBuilder: (context, index) {
                        final reg = provider.registrations[index];
                        // Pastikan ada detail dan beasiswa di dalamnya
                        if (reg.details.isNotEmpty) {
                          return BeasiswaListCard(
                            beasiswa: reg.details.first.beasiswa,
                          );
                        }
                        return const SizedBox.shrink(); // Widget kosong
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return Column(children: [header(), content()]);
  }
}
