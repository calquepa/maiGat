import 'package:mai_gat/core/config/secrets.dart';

class HttpRemoteUtil {

  // [Functions]
  
  // Default headers

  Map<String, String> getDefaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'x-api-key': Secrets.apiKey
    };
  }
}