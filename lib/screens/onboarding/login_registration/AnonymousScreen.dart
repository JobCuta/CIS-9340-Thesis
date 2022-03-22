import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

import '../../../apis/apis.dart';
import '../../../constants/forms.dart';
import '../../../widgets/AccountCreationPopOut.dart';
import '../../../widgets/errorDialog.dart';

void main() {
  runApp(const AnonymousScreen());
}

class AnonymousScreen extends StatelessWidget {
  const AnonymousScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AnonymousWidget();
  }
}

class AnonymousWidget extends StatefulWidget {
  const AnonymousWidget({Key? key}) : super(key: key);

  @override
  State<AnonymousWidget> createState() => _AnonymousState();
}

class _AnonymousState extends State<AnonymousWidget> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String email = '';
  String pass1 = '';
  String pass2 = '';
  String nickName = '';
  bool anon = true;

  handleUserInfo() async {
    print('arguments ${Get.arguments}');
    email = Get.arguments["email"];
    pass1 = Get.arguments["pass1"];
    pass2 = Get.arguments["pass2"];
    var response = await UserProvider()
        .register(RegisterForm.anon(email, pass1, pass2, nickName, anon));
    return response;
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
                color: Colors.grey[850],
              ),
              onPressed: () {
                Get.back();
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Center(
                        child: Text(
                      'Staying anonymous',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.neutralBlack02),
                    )),
                  ),
                  Center(
                    child: Text(
                      'What do you want us to call you?',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Theme.of(context).colorScheme.neutralBlack03,
                          fontWeight: FontWeight.w400),
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
                            children: [
                              Text(
                                'Nickname',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray04),
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
                                hintText: 'Enter your nickname',
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .neutralWhite01,
                                filled: true,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralGray03,
                                    ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15.0),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralGray01,
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
            width: MediaQuery.of(context).size.width,
            height: 120,
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
            child: ListView(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).colorScheme.intGreenMain,
                    ),
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
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.neutralWhite01),
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
                          color: Theme.of(context).colorScheme.neutralGray01),
                      primary: Theme.of(context).colorScheme.neutralWhite01,
                    ),
                    onPressed: () {
                      //navigate to next page
                      Get.back();
                    },
                    child: Text(
                      'I changed my mind...',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.intGreenMain),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
