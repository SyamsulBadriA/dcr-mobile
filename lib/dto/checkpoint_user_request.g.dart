// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpoint_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPointUserRequest _$CheckPointUserRequestFromJson(
        Map<String, dynamic> json) =>
    CheckPointUserRequest(
      userId: json['user_id'] as String?,
      category: json['category'] as String?,
      checkpointName: json['checkpoint_name'] as String?,
    );

Map<String, dynamic> _$CheckPointUserRequestToJson(
        CheckPointUserRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'category': instance.category,
      'checkpoint_name': instance.checkpointName,
    };
