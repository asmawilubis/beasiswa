import 'package:beasiswa/pages/admin/admin_registration_list_view.dart';
import 'package:beasiswa/providers/admin_providers.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Muat data saat halaman pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      Provider.of<AdminProvider>(
        context,
        listen: false,
      ).fetchAllRegistrations(authProvider.user.token!);
    });
  }

  void _handleLogout() async {
    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    if (await authProvider.logout()) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
          labelColor: secondaryColor,
          unselectedLabelColor: Colors.white70,
          indicatorColor: secondaryColor,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Diterima'),
            Tab(text: 'Ditolak'),
          ],
        ),
      ),
      body: Consumer<AdminProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            controller: _tabController,
            children: [
              // Halaman untuk status 'Pending'
              AdminRegistrationListView(
                status: 'pending',
                registrations:
                    provider.allRegistrations
                        .where((reg) => reg.status == 'pending')
                        .toList(),
              ),
              // Halaman untuk status 'Accepted'
              AdminRegistrationListView(
                status: 'accepted',
                registrations:
                    provider.allRegistrations
                        .where((reg) => reg.status == 'accepted')
                        .toList(),
              ),
              // Halaman untuk status 'Rejected'
              AdminRegistrationListView(
                status: 'rejected',
                registrations:
                    provider.allRegistrations
                        .where((reg) => reg.status == 'rejected')
                        .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
