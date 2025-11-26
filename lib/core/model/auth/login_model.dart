class LogInReq {
  final String phoneNumber;
  final String password;

  LogInReq({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return {'phone_number': phoneNumber, 'password': password};
  }
}

class LogInRes {
  final String message;
  final Data data;

  LogInRes({required this.message, required this.data});
}

class Data {
  final User user;
  final Subscription subscription;
  final String token;

  Data({required this.user, required this.subscription, required this.token});
}

class Subscription {
  final int id;
  final int userId;
  final String userIdString;
  final DateTime effectiveTime;
  final DateTime expiryTime;
  final DateTime updateTime;
  final String isOTC;
  final String productId;
  final String serviceId;
  final String spId;
  final String statusCode;
  final dynamic chargeMode;
  final dynamic chargeNumber;
  final dynamic referenceId;
  final Details details;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subscription({
    required this.id,
    required this.userId,
    required this.userIdString,
    required this.effectiveTime,
    required this.expiryTime,
    required this.updateTime,
    required this.isOTC,
    required this.productId,
    required this.serviceId,
    required this.spId,
    required this.statusCode,
    required this.chargeMode,
    required this.chargeNumber,
    required this.referenceId,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });
}

class Details {
  final int id;
  final String code;
  final String title;
  final int amount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Details({
    required this.id,
    required this.code,
    required this.title,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String jollyEmail;
  final String country;
  final List<String> personalizations;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.jollyEmail,
    required this.country,
    required this.personalizations,
    required this.createdAt,
    required this.updatedAt,
  });
}
