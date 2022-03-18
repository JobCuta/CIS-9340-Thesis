import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/AccountCreationPopOut.dart';

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
  String nickName = '';
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

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
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontWeight: FontWeight.w600),
                    )),
                  ),
                  Center(
                    child: Text(
                      'What do you want us to call you?',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: Colors.black),
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
                                    .bodyText2
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(
                                            94, 102, 104, 1)),
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
                        buildPopupDialog(context);
                        Get.offAllNamed('/accountScreen');
                      }
                    },
                    child: Text(
                      'Continue',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.white),
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
                          side: BorderSide(color: Colors.grey.shade300)),
                      padding: const EdgeInsets.all(10),
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      //navigate to next page
                      Get.offNamed('/aboutSelfScreen',
                          arguments: {"email": ""});
                    },
                    child: Text(
                      'I changed my mind...',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.green[400]),
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
