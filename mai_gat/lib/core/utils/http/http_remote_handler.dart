import 'dart:async';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as ioclient;
import 'package:mai_gat/core/config/environment_config.dart';
import 'package:mai_gat/core/entities/common/result_entity.dart';
import 'package:mai_gat/core/utils/http/http_remote_util.dart';

class HttpRemoteHandler {

  // [Singleton]
  static final HttpRemoteHandler _instance = HttpRemoteHandler._constructor();

  factory HttpRemoteHandler() {
    return _instance;
  }

  // [Constructor]
  HttpRemoteHandler._constructor();

  // [Functions]  
  Future<ResultEntity> baseReadResult(http.Response responseService) async {
    ResultEntity getResult = ResultEntity.empty(result: false);

    getResult.statusCode = responseService.statusCode;
    
    // Only read information if result status code is 200
    if(getResult.statusCode == EnvironmentConfig.httpClientOkResponse) {
      getResult.result = true;
      getResult.content = responseService.body;
    }
    
    return getResult;
  }

  ResultEntity baseCatchError(dynamic error, String endPoint) {
    ResultEntity catchErrorResult = ResultEntity.empty(result: false);

    catchErrorResult.statusCode = EnvironmentConfig.httpClientErrorResponse;
    
    if (kDebugMode) {
      log('Error: $error, Message: ${error.message}, Method: $endPoint');
    }

    return catchErrorResult;
  }

  ResultEntity baseTimeout() {
    ResultEntity timeoutResult = ResultEntity.empty(result: false);
    timeoutResult.statusCode = EnvironmentConfig.httpClientTimeoutErrorResponse;
    return timeoutResult;
  }

  // [HTTP Methods :: Handler]

  // [GET]
  Future<ResultEntity> baseGET(String server, String endPoint) async {

    if(server.isEmpty) {
      return ResultEntity.empty(result: false);
    }
    else {
      return await http.get(Uri.parse(server + endPoint),
                              headers: HttpRemoteUtil().getDefaultHeaders())
        .then((http.Response response) async {
          return await baseReadResult(response); 
        }).catchError((error) {
          return baseCatchError(error, endPoint);
        }).timeout(EnvironmentConfig.httpTimeoutServices, onTimeout: () {
          return baseTimeout();
        });
    } 
  }

  // [POST]
  Future<ResultEntity> _basePOST(String server, String endPoint, dynamic body, Map<String, String> headersRequest) async {
    HttpClient httpClient = HttpClient()..badCertificateCallback = (cert, host, port) => kDebugMode;
    var client = ioclient.IOClient(httpClient);

    if(server.isEmpty) {
      return ResultEntity.empty(result: false);
    }
    else {
      return await client.post(Uri.parse(server + endPoint),
                              headers: headersRequest,
                              body: body)
        .then((http.Response response) async {
           return await baseReadResult(response); 
        }).catchError((error) {
          return baseCatchError(error, endPoint);
        }).timeout(EnvironmentConfig.httpTimeoutServices, onTimeout: () {
          return baseTimeout();
        });
    }
  }

  Future<ResultEntity> callPost(String server, String endPoint, dynamic body) async {
    return _basePOST(server, endPoint, body, HttpRemoteUtil().getDefaultHeaders());
  }

  // [PUT]
  Future<ResultEntity> basePUT(String server, String endPoint, dynamic body) async {
    HttpClient httpClient = HttpClient()..badCertificateCallback = (cert, host, port) => kDebugMode;
    var client = ioclient.IOClient(httpClient);

    if(server.isEmpty) {
      return ResultEntity.empty(result: false);
    }
    else {
      return await client.put(Uri.parse(server + endPoint),
                              headers: HttpRemoteUtil().getDefaultHeaders(), 
                              body: body)
        .then((http.Response response) async {
           return await baseReadResult(response); 
        }).catchError((error) {
          return baseCatchError(error, endPoint);
        }).timeout(EnvironmentConfig.httpTimeoutServices, onTimeout: () {
          return baseTimeout();
        });
    }
  }

  // [DELETE]
  Future<ResultEntity> baseDELETE(String server, String endPoint, dynamic body) async {
    HttpClient httpClient = HttpClient()..badCertificateCallback = (cert, host, port) => kDebugMode;
    var client = ioclient.IOClient(httpClient);

    if(server.isEmpty) {
      return ResultEntity.empty(result: false);
    }
    else {
      return await client.delete(Uri.parse(server + endPoint),
                                headers: HttpRemoteUtil().getDefaultHeaders(),
                                body: body)
        .then((http.Response response) async {
          return await baseReadResult(response); 
        }).catchError((error) {
          return baseCatchError(error, endPoint);
        }).timeout(EnvironmentConfig.httpTimeoutServices, onTimeout: () {
          return baseTimeout();
        });
    }
  }
}