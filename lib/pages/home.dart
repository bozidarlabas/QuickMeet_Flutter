import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_meet/model/appointmentItemModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Box<AppointmentItemModel> appointmentBox;

  @override
  void initState() {
    super.initState();
    appointmentBox = Hive.box<AppointmentItemModel>('appointments');
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text(
          'Appointments',
          style: TextStyle(color: Colors.white),
          ),
        centerTitle: true,
        elevation: 0,
        ),
        body: ValueListenableBuilder(
          valueListenable: appointmentBox.listenable(),
          builder: (context, Box<AppointmentItemModel> box, index) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final appointment = box.getAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                  child: Card(
                    elevation: 3.0,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/details', arguments: AppointmentDetailsArguments(appointment: appointment, index: index));
                      },
                      title: Text(appointment!.details),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appointment.formatedDateTime),
                          Text(appointment.location),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/createAppointment');
            },
      ),
    );
  }
}