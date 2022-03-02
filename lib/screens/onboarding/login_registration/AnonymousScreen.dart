//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AboutSelfScreen.dart';
import 'LoginScreen.dart';

void main() {
  runApp(const AnonymousScreen());
}

class AnonymousScreen extends StatelessWidget {
  const AnonymousScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: AnonymousWidget());
  }
}

class AnonymousWidget extends StatefulWidget {
  const AnonymousWidget({Key? key}) : super(key: key);

  @override
  State<AnonymousWidget> createState() => _AnonymousState();
}

class _AnonymousState extends State<AnonymousWidget> {
  String nickName = '';
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Account successfully registered!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Proxima Nova',
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
        ),
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
            padding: const EdgeInsets.only(top: 5.0),
            child: Image.asset('assets/images/yellow_icon.png'),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Check your email to confirm your account in order to log in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Proxima Nova',
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
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
              Get.toNamed('/loginScreen');
            },
            child: const Text(
              'Okay!',
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
          height: 20.0,
        )
      ],
    );
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[850],
            ),
            onPressed: () {
              //Navigation
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Center(
                      child: Text(
                    'Staying Anonymous',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        fontFamily: 'Proxima Nova'),
                  )),
                ),
                const Center(
                  child: Text(
                    'What do you want us to call you?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Proxima Nova',
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35.0,
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
                              'Nickname',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(94, 102, 104, 1),
                                fontFamily: 'Proxima Nova',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              border: const OutlineInputBorder(),
                              hintText: 'Enter your name',
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                  fontFamily: 'Proxima Nova'),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              )),
                            ),
                            onChanged: (val) {
                              setState(() => nickName = val);
                            },
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return 'This field is required.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 400.0,
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
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      Get.to(_buildPopupDialog(context));
                    }
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Proxima Nova',
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
                    Get.toNamed('/aboutselfScreen');
                  },
                  child: Text(
                    'I changed my mind...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Proxima Nova',
                      color: Colors.green[400],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
