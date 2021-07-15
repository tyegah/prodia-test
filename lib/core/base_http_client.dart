import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:prodia_test/core/exceptions.dart';
import 'package:prodia_test/core/retry.dart';

const HTTP_STATUS_OK = 200;
const HTTP_STATUS_OK_NO_CONTENT = 204;
const HTTP_STATUS_UNAUTHORIZED = 401;
const HTTP_STATUS_NOT_FOUND = 404;
const HTTP_STATUS_TIME_OUT = 504;
const HTTP_STATUS_INTERNAL_SERVER_ERROR = 502;

enum HTTPRequestType { get, post }

abstract class BaseHttpClient {
  Future<http.Response> post({String url, dynamic params});
}

class BaseHttpClientImpl implements BaseHttpClient {
  final http.Client _client;

  BaseHttpClientImpl({@required http.Client client})
      : assert(client != null),
        _client = client;

  @override
  Future<http.Response> post({
    @required String url,
    params,
  }) async {
    return await _performHttpRequestWithRetry(
        HTTPRequestType.post, url, params);
  }

  Future<http.Response> _performHttpRequestWithRetry(
    HTTPRequestType requestType,
    String url,
    dynamic params,
  ) async {
    final response = retry(
      () async {
        Map<String, String> headers = {
          "Content-Type": "application/x-www-form-urlencoded"
        };
        final response =
            await _performHttpRequest(requestType, url, headers, params);
        _throwExceptionIfAny(response.statusCode);
        return response;
      },
      maxAttempts: 2,
      retryIf: (e) => e is ServerException || e is TimeOutException,
    );

    return response;
  }

  Future<http.Response> _performHttpRequest(HTTPRequestType requestType,
      String url, Map<String, String> headers, dynamic params) async {
    final uri = Uri.parse(url);
    switch (requestType) {
      case HTTPRequestType.get:
        return await _client.get(uri, headers: headers);
      case HTTPRequestType.post:
        return await _client.post(uri, headers: headers, body: params);
      default:
        return await _client.get(uri, headers: headers);
    }
  }

  _throwExceptionIfAny(int statusCode) {
    switch (statusCode) {
      case HTTP_STATUS_TIME_OUT:
        throw TimeOutException();
      case HTTP_STATUS_NOT_FOUND:
        throw ServerException();
      case HTTP_STATUS_INTERNAL_SERVER_ERROR:
        throw ServerException();
      default:
        return;
    }
  }
}
