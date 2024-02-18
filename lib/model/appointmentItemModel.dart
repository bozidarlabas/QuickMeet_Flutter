import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class AppointmentItemModel {
  // @HiveField(0)
  // final String id;

  @HiveField(0)
  String details;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  TimeOfDay time;

  @HiveField(3)
  String location;

  String get dateString => DateFormat.yMMMd().format(date);
  String get timeString => timeToString(time);
  String get formatedDateTime => '$dateString at $timeString';

  static TimeOfDay timeFromString(String timeString) {
    List<String> parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  static String timeToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  AppointmentItemModel({
    // required this.id,
    required this.details,
    required this.date,
    required this.time,
    required this.location,
  });
}

class AppointmentAdapter extends TypeAdapter<AppointmentItemModel> {
  @override
  final typeId = 0;

  @override
  AppointmentItemModel read(BinaryReader reader) {
    return AppointmentItemModel(
      details: reader.readString(),
      date: DateTime.parse(reader.readString()),
      time: AppointmentItemModel.timeFromString(reader.readString()),
      location: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentItemModel obj) {
    writer.writeString(obj.details);
    writer.writeString(obj.date.toIso8601String());
    writer.writeString(AppointmentItemModel.timeToString(obj.time));
    writer.writeString(obj.location);
  }
}

class AppointmentDetailsArguments {
  final AppointmentItemModel appointment;
  final int index;

  AppointmentDetailsArguments({
    required this.appointment,
    required this.index,
  });
}