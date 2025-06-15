import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/pages/admin/admin_add_edit_beasiswa_page.dart';
import 'package:beasiswa/providers/admin_providers.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminBeasiswaPage extends StatelessWidget {
  const AdminBeasiswaPage({super.key});

  void _showDeleteConfirmation(BuildContext context, BeasiswaModel beasiswa) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Konfirmasi Hapus'),
            content: Text('Yakin ingin menghapus beasiswa "${beasiswa.name}"?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Batal'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
              TextButton(
                child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  final authProvider = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  );
                  Provider.of<AdminProvider>(
                    context,
                    listen: false,
                  ).deleteBeasiswa(
                    token: authProvider.user.token!,
                    id: beasiswa.id,
                  );
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminProvider>(
        builder: (context, provider, child) {
          if (provider.allBeasiswas.isEmpty) {
            return const Center(child: Text('Belum ada data beasiswa.'));
          }
          return ListView.builder(
            itemCount: provider.allBeasiswas.length,
            itemBuilder: (context, index) {
              final beasiswa = provider.allBeasiswas[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListTile(
                  title: Text(beasiswa.name, style: formTextStyle),
                  subtitle: Text(
                    beasiswa.category.name,
                    style: secondaryTextStyle,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: secondaryColor),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => AdminAddEditBeasiswaPage(
                                    beasiswa: beasiswa,
                                  ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: alertColor),
                        onPressed:
                            () => _showDeleteConfirmation(context, beasiswa),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AdminAddEditBeasiswaPage()),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
