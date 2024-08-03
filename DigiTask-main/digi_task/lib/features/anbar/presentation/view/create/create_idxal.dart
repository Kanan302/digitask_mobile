import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/features/anbar/data/model/anbar_item_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio _dio = Dio();
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<void> postAnbarItem(AnbarItemModel item) async {
    try {
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('Token is not available');
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.post(
        'http://135.181.42.192/services/import/',
        data: item.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Item imported successfully');
      } else {
        print('Failed to import item: ${response.statusCode}');
      }
    } catch (e) {
      print('Error importing item: $e');
    }
  }
}