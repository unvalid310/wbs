class ResponseModel {
  final bool _success;
  final String _title;
  final String _message;
  ResponseModel(this._success, this._title, this._message);

  String get title => _title;
  String get message => _message;
  bool get isSuccess => _success;
}
