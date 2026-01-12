import 'dart:io';
import 'package:booker/service/constants.dart';
import 'package:dio/dio.dart';
import 'package:booker/model/apartment_model.dart';

class ApartmentRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "$baseUrl/api"));

  Future<ApartmentModel> submitApartment({
    required String city,
    required String governorate,
    required String rentPrice,
    required String apartmentSpace,
    required String rooms,
    required String floor,
    required String bathrooms,
    required File apartmentImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        'city': city,
        'Governorate': governorate,
        'rent_price': rentPrice,
        'apartment_space': apartmentSpace,
        'rooms': rooms,
        'floor': floor,
        'bathrooms': bathrooms,
        'apartment_image': await MultipartFile.fromFile(
          apartmentImage.path,
          filename: apartmentImage.path.split('/').last,
        ),
      });

      final response = await _dio.post("/Apartmentregister", data: formData);
      print("✅ Status: ${response.statusCode}");
      print("✅ Response: ${response.data}");

      return ApartmentModel.fromJson(response.data);
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      print("❌ Status: ${e.response?.statusCode}");
      print("❌ Response: ${e.response?.data}");
      throw Exception("فشل في إضافة الشقة");
    } catch (e) {
      print("❌ Unexpected error: $e");
      throw Exception("حدث خطأ غير متوقع");
    }
  }
}
