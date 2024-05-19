import 'package:json_annotation/json_annotation.dart';
part 'user_location_request.g.dart';

@JsonSerializable()
class UserLocationRequest {
  UserLocationRequest({
    this.uid,
    this.fullname,
    this.email,
    this.latitude,
    this.longitude,
    this.altitude,
    this.category,
  });
  final String? uid;
  final String? fullname;
  final String? email;
  final String? latitude;
  final String? longitude;
  final String? altitude;
  final String? category;

  factory UserLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$UserLocationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationRequestToJson(this);
}
