import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_meet/components/date_picker.dart';
import 'package:quick_meet/components/label_dropdown.dart';
import 'package:quick_meet/model/appointmentItemModel.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({super.key});

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  late Box<AppointmentItemModel> appointmentBox;
  final TextEditingController _controller = TextEditingController();
  final List<String> locations = [
    "San Diego",
    "St. George",
    "Park City",
    "Dallas",
    "Memphis",
    "Orlando"
  ];
  bool isDefaultDataSet = false;
  late String selectedLocation;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  late AppointmentDetailsArguments? appointmentArgument;

  void setDefaultValues() {
    if (isDefaultDataSet) return;
    appointmentBox = Hive.box<AppointmentItemModel>('appointments');
    appointmentArgument = ModalRoute.of(context)?.settings.arguments
        as AppointmentDetailsArguments?;
    final appointment = appointmentArgument?.appointment;

    if (appointmentArgument != null) {
      _controller.text = appointment?.details ?? '';
      selectedLocation = appointment?.location ?? '';
      selectedDate = appointment?.date ?? DateTime.now();
      selectedTime = appointment?.time ?? TimeOfDay.now();
    } else {
      selectedLocation = locations[0];
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
    }
    isDefaultDataSet = true;
  }

  @override
  Widget build(BuildContext context) {
    setDefaultValues();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[600],
        title: const Text(
          'Appointment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DatePickerWidget(
                    selectedDate: selectedDate,
                    selectedTime: selectedTime,
                    onDateSelected: (DateTime date, TimeOfDay time) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    labelTitle: "Date",
                    type: DatePickerType.date,
                  ),
                  DatePickerWidget(
                      selectedDate: selectedDate,
                      selectedTime: selectedTime,
                      onDateSelected: (DateTime date, TimeOfDay time) {
                        setState(() {
                          selectedTime = time;
                        });
                      },
                      labelTitle: "Time",
                      type: DatePickerType.time),
                  LabeledDropdownWidget(
                      selectedLocation: selectedLocation,
                      valueSelected: (value) {
                        setState(() {
                          selectedLocation = value;
                        });
                      },
                      label: "Location",
                      dropdownItems: locations),
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: TextField(
                      controller: _controller,
                      maxLines: null, // Allows for unlimited lines
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                ),
                onPressed: () {
                  addAppointment();
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addAppointment() {
    final appointment = appointmentArgument?.appointment;
    final index = appointmentArgument?.index;

    if (appointmentArgument != null && appointment != null && index != null) {
      appointment.date = selectedDate;
      appointment.details = _controller.text;
      appointment.location = selectedLocation;
      appointment.time = selectedTime;
      appointmentBox.putAt(index, appointment);
    } else {
      final appointment = AppointmentItemModel(
          date: selectedDate,
          details: _controller.text,
          location: selectedLocation,
          time: selectedTime);
      appointmentBox.add(appointment);
    }

    Navigator.pop(context);
  }
}
