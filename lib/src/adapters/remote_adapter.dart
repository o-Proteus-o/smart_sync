import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

abstract class RemoteAdapter {
  Future<void> initialize();
  Future<dynamic> create(String collection, dynamic data);
  Future<dynamic> read(String collection, String id);
  Future<List<dynamic>> readAll(String collection);
  Future<dynamic> update(String collection, String id, dynamic data);
  Future<void> delete(String collection, String id);
}

class RestAdapter implements RemoteAdapter {
  final String baseUrl;
  final Map<String, String> headers;

  RestAdapter({
    required this.baseUrl,
    this.headers = const {'Content-Type': 'application/json'},
  });

  @override
  Future<void> initialize() async {
    // No initialization needed for REST
  }

  @override
  Future<dynamic> create(String collection, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$collection'),
      headers: headers,
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> read(String collection, String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$collection/$id'),
      headers: headers,
    );
    return _handleResponse(response);
  }

  @override
  Future<List<dynamic>> readAll(String collection) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$collection'),
      headers: headers,
    );
    return List.from(_handleResponse(response));
  }

  @override
  Future<dynamic> update(String collection, String id, dynamic data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$collection/$id'),
      headers: headers,
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  @override
  Future<void> delete(String collection, String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$collection/$id'),
      headers: headers,
    );
    _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw HttpException(
        'Request failed with status: ${response.statusCode}',
        uri: response.request?.url,
      );
    }
  }
}
