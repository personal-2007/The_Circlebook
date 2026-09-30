import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'storage_service.dart';

/// Exception thrown when the API response indicates an error.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

/// Exception thrown on network connectivity failure.
class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

/// ApiService handles all REST API HTTP communication with the Node.js + Express backend.
/// Flutter never connects directly to MySQL.
class ApiService {
  static http.Client _client = http.Client();

  /// Allows injecting a mock or custom http.Client for tests
  static void setClient(http.Client client) {
    _client = client;
  }

  static Uri _buildUri(String endpoint, [Map<String, dynamic>? queryParams]) {
    final baseUrl = ApiConfig.baseUrl.endsWith('/')
        ? ApiConfig.baseUrl.substring(0, ApiConfig.baseUrl.length - 1)
        : ApiConfig.baseUrl;
    final path = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    final fullUrl = '$baseUrl$path';

    if (queryParams == null || queryParams.isEmpty) {
      return Uri.parse(fullUrl);
    }

    final sanitizedParams = queryParams.map(
      (key, value) => MapEntry(key, value?.toString() ?? ''),
    );
    return Uri.parse(fullUrl).replace(queryParameters: sanitizedParams);
  }

  static Map<String, String> _buildHeaders([Map<String, String>? extraHeaders]) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final token = StorageService.loadAuthToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }
    return headers;
  }

  /// GET request
  static Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    final uri = _buildUri(endpoint, queryParams);
    try {
      final response = await _client
          .get(uri, headers: _buildHeaders())
          .timeout(ApiConfig.requestTimeout);
      return _processResponse(response);
    } on SocketException catch (e) {
      throw NetworkException('Unable to reach server. Please check your connection: ${e.message}');
    } on TimeoutException {
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      if (e is ApiException || e is NetworkException) rethrow;
      throw ApiException(e.toString());
    }
  }

  /// POST request
  static Future<dynamic> post(String endpoint, {dynamic body, Map<String, dynamic>? queryParams}) async {
    final uri = _buildUri(endpoint, queryParams);
    try {
      final response = await _client
          .post(
            uri,
            headers: _buildHeaders(),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConfig.requestTimeout);
      return _processResponse(response);
    } on SocketException catch (e) {
      throw NetworkException('Unable to reach server. Please check your connection: ${e.message}');
    } on TimeoutException {
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      if (e is ApiException || e is NetworkException) rethrow;
      throw ApiException(e.toString());
    }
  }

  /// PUT request
  static Future<dynamic> put(String endpoint, {dynamic body}) async {
    final uri = _buildUri(endpoint);
    try {
      final response = await _client
          .put(
            uri,
            headers: _buildHeaders(),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConfig.requestTimeout);
      return _processResponse(response);
    } on SocketException catch (e) {
      throw NetworkException('Unable to reach server. Please check your connection: ${e.message}');
    } on TimeoutException {
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      if (e is ApiException || e is NetworkException) rethrow;
      throw ApiException(e.toString());
    }
  }

  /// DELETE request
  static Future<dynamic> delete(String endpoint) async {
    final uri = _buildUri(endpoint);
    try {
      final response = await _client
          .delete(uri, headers: _buildHeaders())
          .timeout(ApiConfig.requestTimeout);
      return _processResponse(response);
    } on SocketException catch (e) {
      throw NetworkException('Unable to reach server. Please check your connection: ${e.message}');
    } on TimeoutException {
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      if (e is ApiException || e is NetworkException) rethrow;
      throw ApiException(e.toString());
    }
  }

  static dynamic _processResponse(http.Response response) {
    dynamic body;
    if (response.body.isNotEmpty) {
      try {
        body = jsonDecode(response.body);
      } catch (_) {
        body = response.body;
      }
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    if (response.statusCode == 401) {
      // Unauthenticated session - clear token
      StorageService.clearAuthToken();
      throw ApiException(
        body is Map && body['message'] != null
            ? body['message'].toString()
            : 'Session expired. Please log in again.',
        statusCode: 401,
        data: body,
      );
    }

    final message = body is Map && body['message'] != null
        ? body['message'].toString()
        : 'Server returned error status ${response.statusCode}';
    throw ApiException(message, statusCode: response.statusCode, data: body);
  }
}
