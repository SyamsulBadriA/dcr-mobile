// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocationRequest _$UserLocationRequestFromJson(Map<String, dynamic> json) =>
    UserLocationRequest(
      uid: json['uid'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      altitude: json['altitude'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$UserLocationRequestToJson(
        UserLocationRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'fullname': instance.fullname,
      'email': instance.email,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitude': instance.altitude,
      'category': instance.category,
    };
