import 'package:json_annotation/json_annotation.dart';
part 'checkpoint_user_request.g.dart';

@JsonSerializable()
class CheckPointUserRequest {
  CheckPointUserRequest({
    this.userId,
    this.category,
    this.checkpointName,
  });
  @JsonKey(name: "user_id")
  final String? userId;
  final String? category;
  @JsonKey(name: "checkpoint_name")
  final String? checkpointName;


  factory CheckPointUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckPointUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPointUserRequestToJson(this);
}
