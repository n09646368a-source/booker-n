import 'package:booker/model/usermodel.dart';
import 'package:booker/service/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInAuthService {
  final Dio _dio = Dio();

  Future<String> signIn(Usermodel user) async {
    try {
      final response = await _dio.post(
        "$baseUrl/api/login",
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        final token = response.data['data']['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        print(response.data['message']);
        return response.data['message'] ?? "Login successful";
      } else {
        return "Login failed (code: ${response.statusCode})";
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;

      if (status == 403 && data is Map && data['message'] != null) {
        return data['message'];
      } else if (status == 401 && data is Map && data['message'] != null) {
        return data['message'];
      } else if (status == 500) {
        return "Server error, please try again later";
      }

      return "Error: ${e.message}";
    } catch (e) {
      return "Unexpected error: $e";
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
