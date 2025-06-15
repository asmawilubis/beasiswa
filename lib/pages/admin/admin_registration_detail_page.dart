import 'package:beasiswa/models/reg_model.dart';
import 'package:beasiswa/providers/admin_providers.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminRegistrationDetailPage extends StatelessWidget {
  final RegModel registration;
  const AdminRegistrationDetailPage({required this.registration, super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    final beasiswa = registration.details.first.beasiswa;

    void updateStatus(String newStatus) async {
      bool confirm =
          await showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text('Konfirmasi Tindakan'),
                  content: Text(
                    'Anda yakin ingin mengubah status menjadi "$newStatus"?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Yakin'),
                    ),
                  ],
                ),
          ) ??
          false;

      if (confirm) {
        bool success = await adminProvider.updateStatus(
          token: authProvider.user.token!,
          registrationId: registration.id,
          status: newStatus,
        );
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Status berhasil diubah menjadi "$newStatus"'),
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Gagal mengubah status.'),
            ),
          );
        }
      }
    }

    Widget buildSection(String title, String content) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: secondaryTextStyle.copyWith(fontSize: 14)),
            const SizedBox(height: 4),
            Text(content, style: formTextStyle.copyWith(fontSize: 16)),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pendaftaran', style: primaryTextStyle),
        backgroundColor: backgroundColor1,
        iconTheme: IconThemeData(color: primaryTextColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          buildSection('Nama Pendaftar', registration.user?.name ?? 'N/A'),
          buildSection('Email Pendaftar', registration.user?.email ?? 'N/A'),
          buildSection('Beasiswa Dilamar', beasiswa?.name ?? 'N/A'),
          buildSection('Kategori', beasiswa?.category.name ?? 'N/A'),
          const Divider(height: 30),
          Text(
            'Detail dari Pendaftar',
            style: formTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(registration.description, style: formTextStyle),
          ),
        ],
      ),
      bottomNavigationBar:
          (registration.status == 'pending')
              ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => updateStatus('rejected'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: alertColor,
                        ),
                        child: const Text('Tolak'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => updateStatus('accepted'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Setujui'),
                      ),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}
