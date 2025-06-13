import 'package:beasiswa/models/category_model.dart';
import 'package:beasiswa/providers/admin_providers.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminAddEditCategoryPage extends StatefulWidget {
  final CategoryModel? category;

  const AdminAddEditCategoryPage({this.category, super.key});

  @override
  State<AdminAddEditCategoryPage> createState() =>
      _AdminAddEditCategoryPageState();
}

class _AdminAddEditCategoryPageState extends State<AdminAddEditCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final adminProvider = Provider.of<AdminProvider>(context, listen: false);
      bool success;

      if (widget.category == null) {
        // Mode Tambah
        success = await adminProvider.createCategory(
          token: authProvider.user.token!,
          name: _nameController.text,
        );
      } else {
        // Mode Edit
        success = await adminProvider.updateCategory(
          token: authProvider.user.token!,
          id: widget.category!.id,
          name: _nameController.text,
        );
      }

      setState(() => _isLoading = false);

      if (success) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan, silakan coba lagi.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditMode = widget.category != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode ? 'Edit Kategori' : 'Tambah Kategori',
          style: primaryTextStyle,
        ),
        backgroundColor: backgroundColor1,
        iconTheme: IconThemeData(color: primaryTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Kategori'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama kategori tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: Text(
                      isEditMode ? 'Simpan Perubahan' : 'Tambah Kategori',
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
