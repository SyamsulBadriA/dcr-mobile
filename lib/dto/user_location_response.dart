import 'package:dcr_mobile/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_location_response.g.dart';

@JsonSerializable()
class UserLocationResponse {
  UserLocationResponse({
    required this.id,
    this.uid,
    this.fullname,
    this.email,
    this.latitude,
    this.longitude,
    this.altitude,
    this.createdAt,
    this.updatedAt,
  });
  final int id;
  final String? uid;
  final String? fullname;
  final String? email;
  final String? latitude;
  final String? longitude;
  final String? altitude;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  factory UserLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BaseUserLocationResponse {
  BaseUserLocationResponse({
    required this.success,
    this.data,
  });
  final bool success;
  final List<UserLocationResponse>? data;
  factory BaseUserLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseUserLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseUserLocationResponseToJson(this);

  List<UserLocation> toEntity() {
    final listUser = data?.map((e) {
      final double latitude = double.parse(e.latitude ?? "0");
      final double longitude = double.parse(e.longitude ?? "0");
      final double altitude = double.parse(e.altitude ?? "0");

      return UserLocation(
        idUser: e.uid ?? "",
        latitude: latitude,
        longitude: longitude,
        altitude: altitude,
      );
    });

    return listUser?.toList() ?? [];
  }
}
