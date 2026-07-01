class AddressResponse {
  final int? userId;
  final List<UserAddress> addresses;

  AddressResponse({
    this.userId,
    this.addresses = const [],
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      userId: json['user_id'],
      addresses: (json['addresses'] as List? ?? [])
          .map((e) => UserAddress.fromJson(e))
          .toList(),
    );
  }
}

class UserAddress {
  int? id;
  int? userId;
  String? label;
  String? fullName;
  String? phone;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? province;
  String? postalCode;
  String? country;
  String? lat;
  String? lng;
  bool? isDefault;

  UserAddress({
    this.id,
    this.userId,
    this.label,
    this.fullName,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.province,
    this.postalCode,
    this.country,
    this.lat,
    this.lng,
    this.isDefault,
  });

  factory UserAddress.fromJson(Map<String,dynamic> json){
    return UserAddress(
      id: json["id"],
      userId: json["user_id"],
      label: json["label"],
      fullName: json["full_name"],
      phone: json["phone"],
      addressLine1: json["address_line1"],
      addressLine2: json["address_line2"],
      city: json["city"],
      province: json["province"],
      postalCode: json["postal_code"],
      country: json["country"],
      lat: json["lat"]?.toString(),
      lng: json["lng"]?.toString(),
      isDefault: json["is_default"] == 1 || json["is_default"] == true,
    );
  }
}