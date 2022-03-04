
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'AnonymousScreen.dart';
import 'LoginScreen.dart';
//import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const AboutSelfScreen());
}

class AboutSelfScreen extends StatelessWidget {
  const AboutSelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const AboutSelfWidget(),
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color.fromRGBO(242, 255, 245, 1.0),
        )
      ),
    );
  }
}

class AboutSelfWidget extends StatefulWidget {
  const AboutSelfWidget({Key? key}) : super(key: key);

  @override
  State<AboutSelfWidget> createState() => _AboutSelfState();
}

class _AboutSelfState extends State<AboutSelfWidget> {
  String firstName = '';
  String lastName = '';
  String nickName = '';
  String? gender;
  String birthDate = '';

  DateTime selectedDate = DateTime.now();
  bool isButtonActive = false;
  final TextEditingController birthDateController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;

  handleUserInfo() async {
    var response = await UserProvider()
        .updateUser(UserForm(nickName, firstName, lastName, birthDate, gender!));
    return response;
  }

/*Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }*/

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget ? child) {
        return Theme(
          data: ThemeData(
            textTheme: TextTheme(
              subtitle1: const TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.green[500]),
            ),
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.black,
              secondary: Colors.black,),
              dialogBackgroundColor: Colors.white,
            ),
          child: child ?? const Text(''),
          );
      },
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    birthDateController.text = DateFormat('yyyy-MM-d').format(selectedDate);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_images/bahag_background.png'),
            fit: BoxFit.fill,
          )
      ),
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey[700],
              ),
              onPressed: () {
                Get.back();
              },
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                    child: Center(
                        child: Text(
                          'Tell us about yourself',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              fontFamily: 'Proxima Nova'),
                        )),
                  ),
                  const Center(
                    child: Text(
                      'Please enter your credentials to continue',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                'First name',
                                style: captionTextStyle(),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14.0),
                              decoration: textFormFieldDecoration('Enter your first name'),
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return 'This field is required.';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() => firstName = val);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Last name',
                                style: captionTextStyle(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14.0,),
                              decoration: textFormFieldDecoration('Enter your last name'),
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return 'This field is required.';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() => lastName = val);
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Text(
                                  'Nickname (optional)',
                                  style: captionTextStyle()
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              decoration: textFormFieldDecoration('Enter your Nickname'),
                              onChanged: (val) {
                                setState(() => nickName = val);
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Text(
                                'Gender',
                                style: captionTextStyle(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            child: DropdownButtonFormField(
                              decoration: textFormFieldDecoration('Enter your gender'),
                              value: gender,
                              icon: const Icon(Icons.arrow_drop_down),
                              items: const [
                                DropdownMenuItem<String>(
                                  child: Text('Male'),
                                  value: 'Male',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Female'),
                                  value: 'Female',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Rather not to say...'),
                                  value: 'Rather not to say...',
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                              validator: (input) {
                                if (input == null) {
                                  return 'This field is required.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Text(
                                'Birthday',
                                style: captionTextStyle(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            child: TextFormField(
                              controller: birthDateController,
                              onTap: () {
                                // Below line stops keyboard from appearing
                                FocusScope.of(context).requestFocus(FocusNode());
                                // Show Date Picker Here
                                _selectDate(context);
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Enter your birthday',
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'Proxima Nova'
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    )
                                ),
                                suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color.fromRGBO(94, 102, 104, 1),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                              ),
                              onChanged: (val) {
                                setState(
                                        () => birthDate = birthDateController.text);
                              },
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return 'This field is required.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 200.0,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            width: double.infinity,
            height: 120,
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
            child: ListView(
              children: [
                SizedBox(
                  width: 328,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(10),
                      primary: Colors.green[400],
                    ),
                    onPressed: () async {
                      if (_form.currentState!.validate()) {
                        if (await handleUserInfo()) {
                          Get.to(_buildPopupDialog(context));
                        } else {
                          Get.snackbar(
                            "Registration Error",
                            "Something went wrong. Please try again",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 328,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: Colors.grey.shade300)
                      ),
                      padding: const EdgeInsets.all(10),
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      //navigate to next page
                      Get.to(const AnonymousWidget());
                    },
                    child: Text(
                      'Stay Anonymous',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green[300],
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Account successfully registered!',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Divider(
            height: 1.0,
            thickness: 1.0,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset('assets/images/yellow_icon.png'),
          ),
          const Text(
            'Check your email to confirm your account in order to log in',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(10),
              primary: Colors.green[400],
              fixedSize: const Size(245, 50),
            ),
            onPressed: () {
              Get.to(const LoginWidgets());
            },
            child: const Text(
              'Okay!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tableCalendar(BuildContext context) {
    return AlertDialog(
      content: Center(
        child: SizedBox(
          width: 328,
          height: 400,
          child: TableCalendar(
            firstDay: DateTime(1950),
            lastDay: DateTime.now(),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
                titleTextFormatter: (date, locale) => DateFormat.yMMM(locale).format(date),
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'IBM Plex Sans',
                ),
                formatButtonVisible: false,
                leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.green[400]),
                rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.green[400]
                )
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) => DateFormat('E').format(date).toUpperCase(),
              weekdayStyle: daysTextStyle(),
              weekendStyle: daysTextStyle(),
            ),
            calendarStyle: CalendarStyle(
              isTodayHighlighted: false,
              selectedDecoration: BoxDecoration(
                color: Colors.green[500],
                shape: BoxShape.circle,
              ),
            ),
            selectedDayPredicate: (DateTime date) {
              return isSameDay(_selectedDay, date);
            },
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                _selectedDay = selectDay;
                _focusedDay = focusDay;
              });
            },
          ),
        ),
      ),
    );
  }

  TextStyle captionTextStyle() {
    return const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(94, 102, 104, 1),
        fontFamily: 'Proxima Nova',
    );
  }

  InputDecoration textFormFieldDecoration(String hintText) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade600,
          fontFamily: 'Proxima Nova'
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          )
      ),
    );
  }

  TextStyle daysTextStyle() {
    return TextStyle(
      fontFamily: 'IBM Plex Sans',
      fontSize: 10.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey[400],
      letterSpacing: 1.5,
    );
  }
}
/**
 * errorText: 'This Field is Required',
 * validator: (String value) {
    print('date:: ${date.toString()}');
    if (value.isEmpty) {
    return 'birthday is Required.';
    }
    return null;
    },
**/