import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_meet/components/custom_card.dart';
import 'package:quick_meet/model/appointmentItemModel.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({super.key});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  late AppointmentDetailsArguments appointmentArgument;

  late Box<AppointmentItemModel> appointmentBox;

  @override
  void initState() {
    super.initState();
    appointmentBox = Hive.box<AppointmentItemModel>('appointments');
  }

  @override
  Widget build(BuildContext context) {
    appointmentArgument = ModalRoute.of(context)?.settings.arguments
        as AppointmentDetailsArguments;
    final appointment = appointmentArgument.appointment;

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, '/createAppointment',
                    arguments: appointmentArgument);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                appointmentBox.deleteAt(appointmentArgument.index);
                Navigator.pop(context);
              },
            ),
          ],
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[600],
          title: const Text(
            'Appointment',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: ValueListenableBuilder(
            valueListenable: appointmentBox.listenable(),
            builder: (context, box, _) {
              AppointmentItemModel? updatedAppointment;
              if (box.isNotEmpty && appointmentArgument.index < box.length) {
                updatedAppointment = box.getAt(appointmentArgument.index);
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCard(
                        label1: "Date",
                        label2: updatedAppointment?.formatedDateTime ?? "",
                        label3: "Location",
                        label4: updatedAppointment?.location ?? "",
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(appointment.details,
                          style: const TextStyle(fontSize: 18)),
                    ]),
              );
            }));
  }
}
