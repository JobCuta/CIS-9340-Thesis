import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:flutter_application_1/constants/colors.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../widgets/AccountCreationPopOut.dart';
import '../../../widgets/errorDialog.dart';

void main() {
  runApp(const AboutSelfScreen());
}

class AboutSelfScreen extends StatelessWidget {
  const AboutSelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const AboutSelfWidget();
}

class AboutSelfWidget extends StatefulWidget {
  const AboutSelfWidget({Key? key}) : super(key: key);

  @override
  State<AboutSelfWidget> createState() => _AboutSelfState();
}

class _AboutSelfState extends State<AboutSelfWidget> {
  String email = '';
  String pass1 = '';
  String pass2 = '';
  String firstName = '';
  String lastName = '';
  String nickName = '';
  String? gender;
  String birthDate = '';

  DateTime selectedDate = DateTime.now();
  bool isButtonActive = false;
  final TextEditingController birthDateController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  CalendarFormat format = CalendarFormat.month;

  handleUserInfo() async {
    print('arguments ${Get.arguments}');
    email = Get.arguments["email"];
    pass1 = Get.arguments["pass1"];
    pass2 = Get.arguments["pass2"];
    var response = await UserProvider().register(RegisterForm(
        email,
        pass1,
        pass2,
        firstName,
        lastName,
        nickName,
        birthDateController.text,
        gender!));
    return response;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            textTheme: TextTheme(
              subtitle1: TextStyle(
                  color: Theme.of(context).colorScheme.neutralBlack02),
              button:
                  TextStyle(color: Theme.of(context).colorScheme.intGreenMain),
            ),
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.intGreenMain,
              onSecondary: Theme.of(context).colorScheme.neutralBlack02,
              onPrimary: Theme.of(context).colorScheme.neutralWhite01,
              surface: Theme.of(context).colorScheme.neutralBlack02,
              onSurface: Theme.of(context).colorScheme.neutralBlack02,
              secondary: Theme.of(context).colorScheme.neutralBlack02,
            ),
            dialogBackgroundColor: Theme.of(context).colorScheme.neutralWhite01,
          ),
          child: child ?? const Text(''),
        );
      },
      initialDate: selectedDate = DateTime.now(),
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
      )),
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.neutralGray04,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                    child: Center(
                        child: Text(
                      'Tell us about yourself',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.neutralBlack02),
                    )),
                  ),
                  Center(
                    child: Text(
                      'Please enter your credentials to continue',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Theme.of(context).colorScheme.neutralBlack03,
                          fontWeight: FontWeight.w400),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray04,
                                        fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(fontSize: 14.0),
                              decoration: textFormFieldDecoration(
                                  'Enter your first name'),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray04,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              decoration: textFormFieldDecoration(
                                  'Enter your last name'),
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
                              Text('Nickname (optional)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralGray04,
                                          fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14.0),
                              decoration: textFormFieldDecoration(
                                  'Enter your nickname'),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray04,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            height: 50,
                            child: DropdownButtonFormField(
                              style: const TextStyle(fontSize: 14.0),
                              decoration:
                                  textFormFieldDecoration('Enter your gender'),
                              value: gender,
                              icon: const Icon(Icons.arrow_drop_down),
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Male',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .neutralBlack02)),
                                  value: 'M',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Female',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .neutralBlack02)),
                                  value: 'F',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Rather not say...',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .neutralBlack02)),
                                  value: 'P',
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
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray04,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                            child: TextFormField(
                              controller: birthDateController,
                              style: Theme.of(context).textTheme.bodyText1,
                              onTap: () {
                                // Below line stops keyboard from appearing
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                // Show Date Picker Here
                                _selectDate(context);
                              },
                              decoration: textFormFieldDecoration(
                                  'Enter your birthday'),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            width: MediaQuery.of(context).size.width,
            height: 110,
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 20),
            child: ListView(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () async {
                      if (_form.currentState!.validate()) {
                        var response = await handleUserInfo();
                        if (response["status"]) {
                          registeredDialog(context);
                        } else {
                          errorDialog(response["message"]);
                        }
                      }
                    },
                    child: Text(
                      'Continue',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.neutralWhite01,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: BorderSide(
                            color:
                                Theme.of(context).colorScheme.neutralWhite04),
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        //navigate to next page
                        Get.toNamed('/anonScreen', arguments: {
                          "email": Get.arguments["email"],
                          "pass1": Get.arguments["pass1"],
                          "pass2": Get.arguments["pass2"]
                        });
                      },
                      child: Text(
                        'Stay Anonymous',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: Theme.of(context).colorScheme.intGreenMain,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration textFormFieldDecoration(String hintText) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      fillColor: Theme.of(context).colorScheme.neutralWhite01,
      filled: true,
      hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.neutralGray03,
          fontFamily: 'Proxima Nova'),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Colors.grey.shade300,
      )),
    );
  }

  /**TextStyle daysTextStyle() {
    return TextStyle(
      fontFamily: 'IBM Plex Sans',
      fontSize: 10.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey[400],
      letterSpacing: 1.5,
    );
  } **/
}
