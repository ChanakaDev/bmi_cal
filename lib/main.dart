import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: "Health Profile Tracker",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String? gender;
  late DateTime selectedDate;
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BMI',
                      style: TextStyle(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.green,
                        fontSize: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CALCULATOR',
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.green,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 1.5,
                ),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/2.png',
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery
                .of(context)
                .size
                .height -
                AppBar().preferredSize.height -
                MediaQuery
                    .of(context)
                    .padding
                    .top -
                MediaQuery
                    .of(context)
                    .padding
                    .bottom,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 70,
                left: 20,
                child: Container(
                  width: 140,
                  height: 440,
                  child: Image.asset(
                    'assets/4.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(180, 115, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]'),
                          ),
                        ],
                      ),
                      TextField(
                        controller: addressController,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Display date picker when the field is tapped
                          showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              // Update selected date when a date is chosen
                              setState(() {
                                selectedDate = value;
                              });
                            }
                          });
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: TextEditingController(
                              text: DateFormat('yyyy-MM-dd')
                                  .format(selectedDate),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Date Of Birth',
                              labelStyle: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Radio(
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                          Text(
                            'Female',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Weight (Kg)',
                          labelStyle: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                        ],
                      ),
                      TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Height (cm)',
                          labelStyle: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: calculateBMI,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  minimumSize: Size(85, 30),
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                child: Text('Calculate'),
                              ),
                              ElevatedButton(
                                onPressed: resetFields,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  minimumSize: Size(85, 30),
                                ),
                                child: Text('Reset'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (userInfo.isNotEmpty) ...[
                        SizedBox(height: 40),
                        Text(
                          'User Information',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                          ),
                          child: Table(
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      color: Colors.green,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Field',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      color: Colors.green,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Value',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Name'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['name']),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Address'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['address']),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Date of Birth'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['dateOfBirth']),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Age'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['age'].toString()),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Gender'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['gender']),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Weight (Kg)'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['weight']),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Height (cm)'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['height']),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('BMI'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['bmi']),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('Comment'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(userInfo['comment']),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetFields() {
    nameController.clear();
    addressController.clear();
    weightController.clear();
    heightController.clear();
    setState(() {
      gender = null;
      selectedDate = DateTime.now();
      userInfo = {};
    });
  }


  String _getBMIComment(double bmi, int age, String gender) {
    if (gender == 'Male') {
      if (age < 18) {
        if (bmi < 12)
          return 'Underweight';
        else if (bmi >= 12 && bmi <= 18)
          return 'Normal weight';
        else
          return 'Overweight';
      } else {
        if (bmi < 18.5)
          return 'Underweight';
        else if (bmi >= 18.5 && bmi <= 25)
          return 'Normal weight';
        else if (bmi > 25 && bmi <= 30)
          return 'Overweight';
        else
          return 'Obese';
      }
    } else if (gender == 'Female') {
      if (age < 18) {
        if (bmi < 11)
          return 'Underweight';
        else if (bmi >= 11 && bmi <= 17)
          return 'Normal weight';
        else
          return 'Overweight';
      } else {
        if (bmi < 18.5)
          return 'Underweight';
        else if (bmi >= 18.5 && bmi <= 25)
          return 'Normal weight';
        else if (bmi > 25 && bmi <= 30)
          return 'Overweight';
        else
          return 'Obese';
      }
    } else {
      return 'Unknown';
    }
  }


  void calculateBMI() {
    final double weight = double.tryParse(weightController.text) ?? 0;
    final double height = double.tryParse(heightController.text) ?? 0;
    final String name = nameController.text.trim();
    final String address = addressController.text.trim();
    final String dateOfBirth = DateFormat('yyyy-MM-dd').format(selectedDate);
    final int age = DateTime
        .now()
        .year - selectedDate.year;

    double bmi;
    if (height > 0) {
      bmi = weight / pow(height / 100, 2);
    } else {
      bmi = 0;
    }

    final String bmiComment = _getBMIComment(bmi, age, gender ?? '');

    setState(() {
      userInfo = {
        'name': name,
        'address': address,
        'dateOfBirth': dateOfBirth,
        'age': age,
        'gender': gender ?? '',
        'weight': weight.toStringAsFixed(1),
        'height': height.toStringAsFixed(1),
        'bmi': bmi.toStringAsFixed(1),
        'comment': bmiComment,
      };
    });
  }
}