import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AnonymousScreen.dart';
import 'LoginScreen.dart';


void main() {
  runApp(const AboutSelfScreen());
}

class AboutSelfScreen extends StatelessWidget {
  const AboutSelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: AboutSelfWidget(),
        ),
      ),
    );
  }
}

class AboutSelfWidget extends StatefulWidget {
  const AboutSelfWidget({Key? key}) : super(key: key);

  @override
  State<AboutSelfWidget> createState() => _AboutSelfState();
}

class _AboutSelfState extends State<AboutSelfWidget>{
  String firstName = '';
  String lastName = '';
  String nickName = '';
  String? gender;
  DateTime selectedDate = DateTime.now();
  late bool _validate = false;
  bool isButtonActive = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(() {
      var firstNameFilled = firstNameController.text.isNotEmpty;
      lastNameController.addListener(() {
        var lastNameFilled = lastNameController.text.isNotEmpty;
            if (firstNameFilled && lastNameFilled == true){
              const isButtonActive = true;
              setState(() => this.isButtonActive = isButtonActive);
            } else {
              const isButtonActive = false;
              setState(() => this.isButtonActive = isButtonActive);
            }
          });
        });
        lastNameController.addListener(() {
          var lastNameFilled = lastNameController.text.isNotEmpty;
          firstNameController.addListener(() {
            var firstNameFilled = firstNameController.text.isNotEmpty;
            if (lastNameFilled && firstNameFilled == true){
              const isButtonActive = true;
              setState(() => this.isButtonActive = isButtonActive);
            } else {
              const isButtonActive = false;
              setState(() => this.isButtonActive = isButtonActive);
            }
          });
        });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Account successfully Registered!', textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset('assets/images/yellow_icon.png'),
          ),
          const Text('Check your email to confirm your account in order to log in', textAlign: TextAlign.center,),
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
            onPressed: (){
              //navigate to next page
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const LoginScreen()
              ));
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget> [
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(
              child: Text('Tell us about yourself',
                style: TextStyle(fontWeight: FontWeight.w800,
                    fontSize: 30,
                    fontFamily: 'Header 5'),
              )
          ),
        ),
        const Center(
          child: Text('Please enter your credentials to continue',
            style: TextStyle(fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 1,
              fontFamily: 'Body 2',
            ),
          ),
        ),
        const SizedBox(height: 20.0,),
        Padding(padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            child: Column(
              children: <Widget> [
                Row(
                  children: const [
                    Text('First name',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(94, 102, 104, 1)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                TextFormField(
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  controller: firstNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your name',
                    errorText: _validate ? 'This field is required' : null,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                  ),
                  onChanged: (val) {
                    setState(() => firstName = val);
                  },
                  onTap: (){
                    setState(() {
                      firstNameController.text.isNotEmpty ? _validate = false : _validate = false;
                    });
                  },
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: const [
                    Text('Last name',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(94, 102, 104, 1)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                TextFormField(
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  controller: lastNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your name',
                    errorText: _validate ? 'This field is required' : null,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                  ),
                  onChanged: (val) {
                    setState(() => lastName = val);
                  },
                  onTap: (){
                    setState(() {
                      lastNameController.text.isNotEmpty ? _validate = false : _validate = false;
                    });
                  },
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: const [
                    Text('Nickname [Optional]',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(94, 102, 104, 1)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                  ),
                  onChanged: (val) {
                    setState(() => lastName = val);
                  },
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: const [
                    Text('Gender',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(94, 102, 104, 1)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                DropdownButtonFormField(
                  decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Choose your Gender',
                    errorText: _validate ? 'This field is required' : null,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                  ),
                     value: gender,
                     icon: const Icon(Icons.keyboard_arrow_down),
                     items:const [
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
                     onChanged: (String? value){
                      setState(() {
                        gender = value;
                      });
                     },
                  validator: (value) => value == null ? 'field required' : null,
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: const [
                    Text('Birthday',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(94, 102, 104, 1)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                TextFormField(
                  controller: birthDateController,
                  onTap: (){
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(FocusNode());
                    // Show Date Picker Here
                    _selectDate(context);
                    birthDateController.text = DateFormat('yyyy/MM/dd').format(selectedDate);
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your birthday',
                    errorText: _validate ? 'This field is required' : null,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: const Icon(Icons.calendar_today_rounded,color: Colors.green,),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                  ),
                  onSaved: (String? value) {
                    selectedDate = value! as DateTime;
                    setState(() {
                      birthDateController.text.isNotEmpty ? _validate = false : _validate = false;
                    });
                  },
                ),
                const SizedBox(height: 20.0,),
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
                    onPressed: (){
                      //navigate to next page
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => _buildPopupDialog(context),
                      ));
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
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
                    onPressed: (){
                      //navigate to next page
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const AnonymousScreen()
                      ));
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