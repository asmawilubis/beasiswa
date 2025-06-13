import 'package:beasiswa/models/reg_model.dart';
import 'package:beasiswa/services/beasiswa_services.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/models/category_model.dart';

class AdminProvider with ChangeNotifier {
  final BeasiswaServices _beasiswaServices = BeasiswaServices();

  List<RegModel> _allRegistrations = [];
  List<RegModel> get allRegistrations => _allRegistrations;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // --- FUNGSI BARU UNTUK MENGGABUNGKAN SEMUA FETCH DATA AWAL ---
  Future<void> initDashboardData(String token) async {
    // Set loading menjadi true hanya di sini, sekali di awal
    _isLoading = true;
    notifyListeners();

    try {
      // Jalankan kedua fetch secara bersamaan untuk efisiensi
      final results = await Future.wait([
        _beasiswaServices.getAllRegistrations(token),
        _beasiswaServices.getAdminCategories(token),
      ]);

      // results[0] adalah hasil dari getAllRegistrations
      _allRegistrations = results[0] as List<RegModel>;
      // results[1] adalah hasil dari getAdminCategories
      _categories = results[1] as List<CategoryModel>;
    } catch (e) {
      print("Error initializing dashboard data: $e");
    } finally {
      // Set loading menjadi false di akhir, setelah semua selesai
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi-fungsi di bawah ini tetap ada untuk digunakan secara spesifik,
  // seperti untuk pull-to-refresh atau setelah melakukan aksi CRUD.

  Future<void> fetchAllRegistrations(String token) async {
    try {
      _allRegistrations = await _beasiswaServices.getAllRegistrations(token);
      notifyListeners();
    } catch (e) {
      print("Error fetching all registrations: $e");
    }
  }

  Future<void> fetchCategories(String token) async {
    try {
      _categories = await _beasiswaServices.getAdminCategories(token);
      notifyListeners();
    } catch (e) {
      print("Error fetching categories for admin: $e");
    }
  }

  // --- CRUD FUNCTIONS (TIDAK BERUBAH) ---

  Future<bool> createCategory({
    required String token,
    required String name,
  }) async {
    try {
      await _beasiswaServices.createCategory(token: token, name: name);
      await fetchCategories(token);
      return true;
    } catch (e) {
      print("Error creating category: $e");
      return false;
    }
  }

  Future<bool> updateCategory({
    required String token,
    required int id,
    required String name,
  }) async {
    try {
      await _beasiswaServices.updateCategory(token: token, id: id, name: name);
      await fetchCategories(token);
      return true;
    } catch (e) {
      print("Error updating category: $e");
      return false;
    }
  }

  Future<bool> deleteCategory({required String token, required int id}) async {
    try {
      await _beasiswaServices.deleteCategory(token: token, id: id);
      _categories.removeWhere((cat) => cat.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error deleting category: $e");
      return false;
    }
  }

  Future<bool> updateStatus({
    required String token,
    required int registrationId,
    required String status,
  }) async {
    try {
      await _beasiswaServices.updateRegistrationStatus(
        token: token,
        regId: registrationId,
        status: status,
      );
      final index = _allRegistrations.indexWhere(
        (reg) => reg.id == registrationId,
      );
      if (index != -1) {
        _allRegistrations[index].status = status;
        notifyListeners();
      }
      return true;
    } catch (e) {
      print("Error updating status: $e");
      return false;
    }
  }
}
