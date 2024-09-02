class ResultEntity {

  // [Constructor]
  ResultEntity();

  // Empty constructor
  ResultEntity.empty({
    required this.result
  });

  // [Properties]
  late bool result;
  String? message;
  dynamic content;
  int? statusCode;
  dynamic cleanContent;
}