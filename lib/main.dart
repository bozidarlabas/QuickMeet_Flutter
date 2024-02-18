import 'package:flutter/material.dart';
import 'package:quick_meet/pages/appointment_details.dart';
import 'package:quick_meet/pages/create_appointment.dart';
import 'package:quick_meet/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_meet/model/appointmentItemModel.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AppointmentAdapter());
  await Hive.openBox<AppointmentItemModel>('appointments');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => const Home(),
    '/details': (context) => const AppointmentDetails(),
    '/createAppointment': (context) => const CreateAppointment()
  },
));
}
