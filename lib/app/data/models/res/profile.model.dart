class Profile {
  User? user;

  Profile({this.user});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
    };
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? avatar;
  String? fcmToken;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? otp;
  String? otpCreatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.avatar,
    this.fcmToken,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.otp,
    this.otpCreatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      phone: json['phone'],
      avatar: json['avatar'],
      fcmToken: json['fcm_token'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      otp: json['otp'],
      otpCreatedAt: json['otp_created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone': phone,
      'avatar': avatar,
      'fcm_token': fcmToken,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'otp': otp,
      'otp_created_at': otpCreatedAt,
    };
  }
}