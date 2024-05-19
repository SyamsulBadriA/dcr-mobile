// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocationResponse _$UserLocationResponseFromJson(
        Map<String, dynamic> json) =>
    UserLocationResponse(
      id: (json['id'] as num).toInt(),
      uid: json['uid'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      altitude: json['altitude'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$UserLocationResponseToJson(
        UserLocationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'fullname': instance.fullname,
      'email': instance.email,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitude': instance.altitude,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

BaseUserLocationResponse _$BaseUserLocationResponseFromJson(
        Map<String, dynamic> json) =>
    BaseUserLocationResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserLocationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaseUserLocationResponseToJson(
        BaseUserLocationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
