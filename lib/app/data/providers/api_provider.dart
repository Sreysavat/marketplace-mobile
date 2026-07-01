import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';

import '../../sevices/storage_service.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;


class ApiProvider {
  late Dio _dio;


  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8000/api',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),

        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,

        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },

        validateStatus: (status) {
          return status != null && status < 600;
        },
      ),
    );

    // 🔥 ADD THIS INTERCEPTOR (IMPORTANT)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageService.read(key: "token");

          print("🔥 TOKEN FROM STORAGE: $token");
          print("🔥 BEFORE REQUEST HEADERS: ${options.headers}");

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
    //add interceptors

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {

        //add auth token to request
        String? token = await StorageService.read(key: 'token');

        if(token != null){
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error , handler) async{
        if(error.response?.statusCode == 401){
          String? token = await StorageService.read(key: 'token');

          if(token != null) {
            await StorageService.delete(key: 'token');
          }
          Get.offAllNamed(Routes.SIGNIN);
        }
        handler.next(error);
    }
    ));

    // _dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     requestHeader: true,
    //   ),
    // );
  }

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await _dio.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      return await _dio.post(
        '/otp/verify',
        data: {
          'email': email,
          'otp': otp,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';

      case DioExceptionType.sendTimeout:
        return 'Request timeout';

      case DioExceptionType.receiveTimeout:
        return 'Server response timeout';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      case DioExceptionType.badResponse:
        return e.response?.data['message'] ??
            'Server error';

      default:
        return e.message ?? 'Unknown error';
    }
  }

  Future<Response> resendOtp({required String email}) {
    return _dio.post('/resend-otp', data: {
      'email': email,
    });
  }
  Future<Response> logout() async {
    return await _dio.post('/auth/logout');
  }
  Future<Response> getProfile() async {
    return await _dio.get('/auth/me');
  }

  Future<Response> updateProfile({
    required String name,
    required String email,
    String? avatar,
  }) async {
    final formData = FormData.fromMap({
      "name": name,
      "email": email,
    });

    if (avatar != null && avatar.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "avatar",
          await MultipartFile.fromFile(
            avatar,
            filename: avatar.split('/').last,
          ),
        ),
      );
    }

    return await _dio.post(
      '/auth/update',
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
  }

  Future<Response> getProducts() async {
    return await _dio.get('/products');
  }
  Future<Response> searchProduct(String keyword) async {
    final res = await _dio.get('/products/search', queryParameters: {
      'q': keyword,
    });

    return res;
  }

  Future<Response> addToCart({
    required proId,
    required proVaId,
    required qty,
  }) async {
    final token = StorageService;

    return await _dio.post(
      '/cart',
      data: {
        'product_id': proId,
        'product_variant_id': proVaId,
        'quantity': qty,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );
  }
  Future<Response> getCart() async{
    return await _dio.get('/cart');
  }

  Future<Response> updateCartItem(int id, int qty) async {
    return await _dio.put(
      '/cart/$id',
      data: {
        'quantity': qty,
      },
    );
  }

  Future<Response> deleteCartItem(int id) async {
    return await _dio.delete('/cart/$id');
  }

  Future<Response> checkout(Map<String, dynamic> data) async {
    return await _dio.post(
      "/checkout",
      data: data,
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }
  Future<Response> getAddress() async{
    return await _dio.get('/addresses',
    options: Options(
      validateStatus: (status){
        return status !<500 ;
      }
    )
    );

  }
}