import 'package:beasiswa/pages/admin/admin_registration_list_view.dart';
import 'package:beasiswa/providers/admin_providers.dart';
import 'package:beasiswa/pages/admin/admin_category_page.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beasiswa/pages/admin/admin_beasiswa_page.dart';
import 'package:beasiswa/providers/beasiswa_provider.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi TabController dengan 5 tab
    _tabController = TabController(length: 5, vsync: this);

    // Panggil data dari API saat halaman pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final adminProvider = Provider.of<AdminProvider>(context, listen: false);

      if (authProvider.user.token != null) {
        Provider.of<AdminProvider>(
          context,
          listen: false,
        ).initDashboardData(authProvider.user.token!);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Fungsi untuk menangani logout
  void _handleLogout() async {
    bool confirm =
        await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Konfirmasi Logout'),
                content: const Text(
                  'Apakah Anda yakin ingin keluar dari dasbor admin?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Yakin'),
                  ),
                ],
              ),
        ) ??
        false;

    if (confirm) {
      AuthProvider authProvider = Provider.of<AuthProvider>(
        context,
        listen: false,
      );
      if (await authProvider.logout()) {
        Provider.of<AdminProvider>(context, listen: false).clearAdminData();
        Provider.of<BeasiswaProvider>(
          context,
          listen: false,
        ).clearUserSpecificData();

        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        title: Text('Admin Dashboard', style: primaryTextStyle),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: primaryTextColor),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: secondaryColor,
          unselectedLabelColor: Colors.white70,
          indicatorColor: secondaryColor,
          tabs: const [
            Tab(text: 'PENDING'),
            Tab(text: 'DITERIMA'),
            Tab(text: 'DITOLAK'),
            Tab(text: 'KELOLA KATEGORI'),
            Tab(text: 'KELOLA BEASISWA'),
          ],
        ),
      ),

      body: Consumer<AdminProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Tampilkan TabBarView setelah data selesai dimuat
          return TabBarView(
            controller: _tabController,
            children: [
              // Halaman untuk status 'pending'
              AdminRegistrationListView(
                status: 'pending',
                registrations:
                    provider.allRegistrations
                        .where((reg) => reg.status == 'pending')
                        .toList(),
              ),
              // Halaman untuk status 'accepted'
              AdminRegistrationListView(
                status: 'accepted',
                registrations:
                    provider.allRegistrations
                        .where((reg) => reg.status == 'accepted')
                        .toList(),
              ),
              // Halaman untuk status 'rejected'
              AdminRegistrationListView(
                status: 'rejected',
                registrations:
                    provider.allRegistrations
                        .where((reg) => reg.status == 'rejected')
                        .toList(),
              ),
              const AdminCategoryPage(),
              const AdminBeasiswaPage(),
            ],
          );
        },
      ),
    );
  }
}
