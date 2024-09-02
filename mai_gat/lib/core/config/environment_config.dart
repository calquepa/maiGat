class EnvironmentConfig {
  // App
  static const String appTitle = 'Catbreeds';
  
  // HTTP Behavior
  static const Duration httpTimeoutServices = Duration(seconds: 20);
  static const int httpClientOkResponse = 200;
  static const int httpClientErrorResponse = 404;
  static const int httpClientTimeoutErrorResponse = 408;

}