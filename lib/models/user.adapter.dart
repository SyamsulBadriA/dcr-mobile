import 'user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 1;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      idRegistration: fields[0] as String,
      idCategory: fields[1] as String,
      idUser: fields[2] as String,
      nameBib: fields[3] as String,
      fullname: fields[4] as String,
      email: fields[5] as String,
      phoneNumber: fields[6] as String,
      username: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.idRegistration)
      ..writeByte(1)
      ..write(obj.idCategory)
      ..writeByte(2)
      ..write(obj.idUser)
      ..writeByte(3)
      ..write(obj.nameBib)
      ..writeByte(4)
      ..write(obj.fullname)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.username);
  }
}

class UserLocationAdapter extends TypeAdapter<UserLocation> {
  @override
  final int typeId = 2;

  @override
  UserLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocation(
      idUser: fields[0] as String,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      altitude: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocation obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idUser)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.altitude);
  }
}
