import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'RegisterScreen.dart';
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
    return const GetMaterialApp(home: AboutSelfWidget());
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

  handleUserInfo() async {
    var response = await UserProvider()
        .updateUser(UserForm(nickName, firstName, lastName, birthDate, gender!));
    return response;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[850],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: ListView(
              //scrollDirection: Axis.vertical,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                      child: Text(
                    'Tell us about yourself',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                        fontFamily: 'Header 5'),
                  )),
                ),
                const Center(
                  child: Text(
                    'Please enter your credentials to continue',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 1,
                      fontFamily: 'Body 2',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const [
                            Text(
                              'First name',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(94, 102, 104, 1)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Enter your first name',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 14.0),
                          ),
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Last name',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(94, 102, 104, 1)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Enter your last name',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 14.0),
                          ),
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Nickname [Optional]',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(94, 102, 104, 1)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Enter your Nickname',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 14.0),
                          ),
                          onChanged: (val) {
                            setState(() => nickName = val);
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Gender',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(94, 102, 104, 1)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Choose your Gender',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 14.0),
                          ),
                          value: gender,
                          icon: const Icon(Icons.keyboard_arrow_down),
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Birthday',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(94, 102, 104, 1)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          controller: birthDateController,
                          onTap: () {
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
                            // Show Date Picker Here
                            _selectDate(context);
                            birthDateController.text =
                                DateFormat('yyyy-MM-d').format(selectedDate);
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your birthday',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            suffixIcon: Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.green,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 14.0),
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
                        const SizedBox(
                          height: 200.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
                  primary: Colors.green,
                ),
                onPressed: () async {
                  if (_form.currentState!.validate()) {
                    if (await handleUserInfo()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  _buildPopupDialog(context)));
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(10),
                  primary: Colors.white,
                ),
                onPressed: () {
                  //navigate to next page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AnonymousScreen()));
                },
                child: const Text(
                  'Stay Anonymous',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
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
              primary: Colors.green,
              fixedSize: const Size(245, 50),
            ),
            onPressed: () {
              //navigate to next page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
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