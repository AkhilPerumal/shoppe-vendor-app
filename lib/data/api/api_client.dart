import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:carclenx_vendor_app/data/model/response/error_response.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;
  Logger _logger = Logger();

  String token;
  Map<String, String> _mainHeaders;

  ApiClient({@required this.appBaseUrl, @required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    _logger.i('Token: $token');
    updateHeader(
        token, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
  }

  void updateHeader(String token, String languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.LOCALIZATION_KEY:
          languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(
      {String uri,
      Map<String, dynamic> query,
      Map<String, String> headers}) async {
    try {
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        headers: headers != null ? headers : _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(
      {String uri,
      Map<String, String> headers,
      Map<String, dynamic> body}) async {
    var encBody;
    try {
      if (body != null) {
        encBody = jsonEncode(body);
      } else {
        encBody = "";
      }
      _logger.i('====> API Call: URI : $uri\nHeader:' +
          (headers != null ? headers.toString() : _mainHeaders.toString()));
      _logger.i('====> API Body: $body');
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: encBody,
        headers: headers != null ? headers : _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      _logger.e(e);
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      {String uri,
      Map<String, String> body,
      List<MultipartBody> multipartBody,
      Map<String, String> headers}) async {
    try {
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      _logger.i('====> API Body: $body');
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders);

      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          if (Foundation.kIsWeb) {
            Uint8List _list = await multipart.file.readAsBytes();
            Http.MultipartFile _part = await Http.MultipartFile.fromPath(
              multipart.key,
              multipart.file.path,
              filename: basename(multipart.file.path),
              contentType: MediaType('image', 'jpg'),
            );
            _request.files.add(_part);
          } else {
            File _file = File(multipart.file.path);
            // // _request.files.add(Http.MultipartFile(
            // //   multipart.key,
            // //   _file.readAsBytes().asStream(),
            // //   _file.lengthSync(),
            // //   filename: _file.path.split('/').last,
            // // ));
            // var multipartFile = await Http.MultipartFile.fromPath(
            //   'upload',
            //   _file.path,
            //   contentType:
            //       MediaType('image', _file.path.split(".").last.toString()),
            // );
            // _request.files.add(multipartFile);
            _request
              ..files.add(
                await Http.MultipartFile.fromPath(
                  'upload',
                  _file.path,
                  contentType: MediaType('image', 'jpeg'),
                ),
              );
          }
        }
      }
      var id = body['id'];
      _request.fields['id'] = id;
      _logger.i(_request);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(
      {String uri,
      Map<String, dynamic> headers,
      Map<String, dynamic> body}) async {
    var encBody;
    try {
      if (body != null) {
        encBody = jsonEncode(body);
      } else {
        encBody = "";
      }
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      _logger.i('====> API Body: $body');
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: encBody,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      _logger.e(e.toString());
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String> headers}) async {
    try {
      _logger.i('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      _logger.e(e);
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (err) {
      _logger.e("Handling response : " + err.toString());
    }
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    _logger.d(
        '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    return _response;
  }
}

class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}
