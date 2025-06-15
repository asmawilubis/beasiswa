import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/models/category_model.dart';
import 'package:beasiswa/providers/admin_providers.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminAddEditBeasiswaPage extends StatefulWidget {
  final BeasiswaModel? beasiswa;

  const AdminAddEditBeasiswaPage({this.beasiswa, super.key});

  @override
  State<AdminAddEditBeasiswaPage> createState() =>
      _AdminAddEditBeasiswaPageState();
}

class _AdminAddEditBeasiswaPageState extends State<AdminAddEditBeasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  int? _selectedCategoryId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.beasiswa?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.beasiswa?.description ?? '',
    );
    _selectedCategoryId = widget.beasiswa?.category.id;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    // Validasi form dan pilihan kategori
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih kategori terlebih dahulu.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);

    try {
      bool success;
      if (widget.beasiswa == null) {
        // Mode Tambah
        success = await adminProvider.createBeasiswa(
          token: authProvider.user.token!,
          name: _nameController.text,
          description: _descriptionController.text,
          categoryId: _selectedCategoryId!,
        );
      } else {
        // Mode Edit
        success = await adminProvider.updateBeasiswa(
          token: authProvider.user.token!,
          id: widget.beasiswa!.id,
          name: _nameController.text,
          description: _descriptionController.text,
          categoryId: _selectedCategoryId!,
        );
      }

      // Jika proses di atas berhasil tanpa melempar error
      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.beasiswa == null
                  ? 'Beasiswa berhasil ditambahkan'
                  : 'Beasiswa berhasil diperbarui',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Ini akan dijalankan jika provider mengembalikan false tanpa error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan yang tidak diketahui.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst("Exception: ", "")),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Pastikan loading indicator selalu berhenti
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditMode = widget.beasiswa != null;
    final categories = Provider.of<AdminProvider>(context).categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode ? 'Edit Beasiswa' : 'Tambah Beasiswa',
          style: primaryTextStyle,
        ),
        backgroundColor: backgroundColor1,
        iconTheme: IconThemeData(color: primaryTextColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Beasiswa'),
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Nama tidak boleh kosong.'
                            : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedCategoryId,
                hint: const Text('Pilih Kategori'),
                items:
                    categories.map<DropdownMenuItem<int>>((
                      CategoryModel category,
                    ) {
                      return DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(category.name),
                      );
                    }).toList(),
                onChanged: (int? newValue) {
                  setState(() => _selectedCategoryId = newValue);
                },
                validator:
                    (value) => value == null ? 'Kategori harus dipilih.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Deskripsi tidak boleh kosong.'
                            : null,
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      isEditMode ? 'Simpan Perubahan' : 'Tambah Beasiswa',
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
