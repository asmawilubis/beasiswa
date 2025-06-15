import 'package:beasiswa/models/reg_model.dart';
import 'package:beasiswa/services/beasiswa_services.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/models/category_model.dart';
import 'package:beasiswa/models/beasiswa_model.dart';

class AdminProvider with ChangeNotifier {
  final BeasiswaServices _beasiswaServices = BeasiswaServices();

  List<RegModel> _allRegistrations = [];
  List<RegModel> get allRegistrations => _allRegistrations;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  List<BeasiswaModel> _allBeasiswas = [];
  List<BeasiswaModel> get allBeasiswas => _allBeasiswas;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void clearAdminData() {
    _allRegistrations = [];
    _categories = [];
    _allBeasiswas = [];
    _isLoading = false;
    notifyListeners();
    print('AdminProvider data cleared.');
  }

  // FUNGSI UNTUK MENGGABUNGKAN SEMUA FETCH DATA AWAL
  Future<void> initDashboardData(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Jalankan semua fetch secara bersamaan untuk efisiensi
      final results = await Future.wait([
        _beasiswaServices.getAllRegistrations(token),
        _beasiswaServices.getAdminCategories(token),
        _beasiswaServices.getBeasiswa(),
      ]);

      // Tetapkan hasil ke state masing-masing
      _allRegistrations = results[0] as List<RegModel>;
      _categories = results[1] as List<CategoryModel>;
      _allBeasiswas = results[2] as List<BeasiswaModel>;
    } catch (e) {
      print("Error initializing dashboard data: $e");
    } finally {
      // Set loading menjadi false di akhir, setelah semua selesai
      _isLoading = false;
      notifyListeners();
    }
  }

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

  Future<void> fetchAllBeasiswas() async {
    try {
      _allBeasiswas = await _beasiswaServices.getBeasiswa();
      notifyListeners();
    } catch (e) {
      print("Error fetching all beasiswas: $e");
    }
  }

  Future<bool> createCategory({
    required String token,
    required String name,
  }) async {
    try {
      await _beasiswaServices.createCategory(token: token, name: name);
      await fetchCategories(token);
      return true;
    } catch (e) {
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
      return false;
    }
  }

  Future<bool> createBeasiswa({
    required String token,
    required String name,
    required String description,
    required int categoryId,
  }) async {
    try {
      await _beasiswaServices.createBeasiswa(
        token: token,
        name: name,
        description: description,
        categoryId: categoryId,
      );
      await fetchAllBeasiswas();
      return true;
    } catch (e) {
      print("Error creating beasiswa: $e");
      throw e.toString();
    }
  }

  Future<bool> updateBeasiswa({
    required String token,
    required int id,
    required String name,
    required String description,
    required int categoryId,
  }) async {
    try {
      await _beasiswaServices.updateBeasiswa(
        token: token,
        id: id,
        name: name,
        description: description,
        categoryId: categoryId,
      );
      await fetchAllBeasiswas();
      return true;
    } catch (e) {
      print("Error updating beasiswa: $e");
      throw e.toString();
    }
  }

  Future<bool> deleteBeasiswa({required String token, required int id}) async {
    try {
      await _beasiswaServices.deleteBeasiswa(token: token, id: id);
      _allBeasiswas.removeWhere((b) => b.id == id);
      notifyListeners();
      return true;
    } catch (e) {
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
      return false;
    }
  }
}
