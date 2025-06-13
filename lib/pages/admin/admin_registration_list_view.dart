import 'package:beasiswa/models/reg_model.dart';
import 'package:beasiswa/pages/admin/admin_registration_detail_page.dart';
import 'package:beasiswa/providers/admin_providers.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminRegistrationListView extends StatelessWidget {
  final String status;
  final List<RegModel> registrations;

  const AdminRegistrationListView({
    required this.status,
    required this.registrations,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (registrations.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada pendaftaran dengan status "$status".',
          style: secondaryTextStyle,
        ),
      );
    }

    // Fungsi untuk pull-to-refresh
    Future<void> _refreshData() async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await Provider.of<AdminProvider>(
        context,
        listen: false,
      ).fetchAllRegistrations(authProvider.user.token!);
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: registrations.length,
        itemBuilder: (context, index) {
          final reg = registrations[index];
          final beasiswa = reg.details.first.beasiswa;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(
                beasiswa?.name ?? 'Beasiswa Tidak Ditemukan',
                style: formTextStyle.copyWith(fontWeight: semiBold),
              ),
              subtitle: Text(
                'Pendaftar: ${reg.user?.name ?? 'N/A'}\nKategori: ${beasiswa?.category.name ?? 'N/A'}',
                style: secondaryTextStyle.copyWith(fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            AdminRegistrationDetailPage(registration: reg),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
