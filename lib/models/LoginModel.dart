class LoginDataModel {
  bool? status; // Ensure this is a bool after parsing.
  String? message;
  UserData? data;

  LoginDataModel({
    this.status,
    this.message,
    this.data,
  });

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    // Check if 'status' is String and convert it to bool if necessary
    if (json['status'] is String) {
      status = json['status'] == 'true'; // Convert "true"/"false" string to boolean
    } else if (json['status'] is bool) {
      status = json['status']; // Already a boolean, use as is
    }

    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? null;
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
