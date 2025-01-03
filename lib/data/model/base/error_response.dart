/// errors : [{"code":"l_name","message":"The last name field is required."},{"code":"password","message":"The password field is required."}]
library;

class ErrorResponse {
  List<Errors> _errors = [];

  List<Errors> get errors => _errors;

  ErrorResponse({List<Errors>? errors}) {
    _errors = errors!;
  }

  ErrorResponse.fromJson(dynamic json) {
    if (json["errors"] != null) {
      _errors = [];
      json["errors"].forEach((dynamic v) {
        _errors.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["errors"] = _errors.map((v) => v.toJson()).toList();
      return map;
  }
}

/// code : "l_name"
/// message : "The last name field is required."

class Errors {
  String _code = '';
  String _message = '';

  String get code => _code;
  String get message => _message;

  Errors({String? code, String? message}) {
    _code = code!;
    _message = message!;
  }

  Errors.fromJson(dynamic json) {
    _code = json["code"].toString();
    _message = json["message"].toString();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["message"] = _message;
    return map;
  }
}