// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    UserProfileResponse(
      idRegistration: json['id_registration'] as String?,
      idUser: json['id_user'] as String?,
      idCategory: json['id_category'] as String?,
      nameBib: json['name_bib'] as String?,
      namaCategory: json['name_category'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserProfileResponseToJson(
        UserProfileResponse instance) =>
    <String, dynamic>{
      'id_registration': instance.idRegistration,
      'id_user': instance.idUser,
      'id_category': instance.idCategory,
      'name_bib': instance.nameBib,
      'name_category': instance.namaCategory,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'username': instance.username,
      'phone': instance.phone,
    };

BaseUserProfileResponse _$BaseUserProfileResponseFromJson(
        Map<String, dynamic> json) =>
    BaseUserProfileResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UserProfileResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseUserProfileResponseToJson(
        BaseUserProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };
