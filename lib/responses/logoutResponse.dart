/// status : true
/// message : "تم تسجيل الخروج بنجاح"
/// data : {"id":81371,"token":"lCNeUKxin64j2MBlsibrWjJLKukOzbX8yXmLyMC9rU7KBgWeFJfyr9KVD2km4hZyUnA8Wj"}

class LogoutResponse {
  LogoutResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  LogoutResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 81371
/// token : "lCNeUKxin64j2MBlsibrWjJLKukOzbX8yXmLyMC9rU7KBgWeFJfyr9KVD2km4hZyUnA8Wj"

class Data {
  Data({
      int? id, 
      String? token,}){
    _id = id;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _token = json['token'];
  }
  int? _id;
  String? _token;

  int? get id => _id;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['token'] = _token;
    return map;
  }

}