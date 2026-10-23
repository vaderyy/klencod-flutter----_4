import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://eus.fezzanu.edu.ly';
  
  // تسجيل الدخول الحقيقي من الموقع
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // محاولة الاتصال بالموقع والتحقق من البيانات
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        // التحقق من نجاح تسجيل الدخول
        var document = parser.parse(response.body);
        
        // البحث عن علامات نجاح تسجيل الدخول
        bool isLoggedIn = document.body!.text.contains('تسجيل الخروج') ||
                          document.body!.text.contains('الملف الشخصي') ||
                          document.body!.text.contains('الدرجات') ||
                          !document.body!.text.contains('كلمة المرور خاطئة');
        
        if (isLoggedIn) {
          // حفظ بيانات الجلسة
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', username);
          await prefs.setString('session_cookie', response.headers['set-cookie'] ?? '');
          await prefs.setBool('is_logged_in', true);
          
          return {
            'success': true,
            'message': 'تم تسجيل الدخول بنجاح',
            'username': username,
          };
        }
      }
      
      return {
        'success': false,
        'message': 'اسم المستخدم أو كلمة المرور غير صحيحة',
      };
    } catch (e) {
      print('Login error: $e');
      return {
        'success': false,
        'message': 'فشل الاتصال بالخادم، تحقق من الإنترنت',
      };
    }
  }

  // التحقق من حالة تسجيل الدخول
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  // تسجيل الخروج
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // جلب بيانات الطالب من الموقع
  Future<Map<String, dynamic>> getStudentData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cookie = prefs.getString('session_cookie') ?? '';
      
      final response = await http.get(
        Uri.parse('$baseUrl/student/profile'),
        headers: {
          'Cookie': cookie,
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        
        // استخراج بيانات الطالب من HTML
        String name = document.querySelector('.student-name')?.text ?? 'غير معروف';
        String id = document.querySelector('.student-id')?.text ?? '';
        
        return {
          'success': true,
          'name': name,
          'id': id,
        };
      }
      
      return {'success': false};
    } catch (e) {
      print('Get student data error: $e');
      return {'success': false};
    }
  }
}