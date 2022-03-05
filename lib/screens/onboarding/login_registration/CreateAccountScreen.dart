import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

void main() {
  runApp(const CreateAccountScreen());
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration:
              const BoxDecoration(color: Color.fromRGBO(242, 255, 245, 1.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 60, 15, 15),
                child: Text(
                  'Before we continue...',
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Proxima Nova'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset('assets/images/create.svg'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                'Create an account!',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    fontFamily: 'Proxima Nova'),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'All interactions and data are fully encrypted and secure. Your data is safe with us!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Proxima Nova',
                      color: Colors.teal[900]),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(12),
                      primary: Colors.green[400],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                          ),
                          useRootNavigator: true,
                          isScrollControlled: true,
                          builder: (context) {
                            return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: const RegisterWidget());
                          });
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Already have an account?',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(78, 78, 78, 1),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: Colors.grey.shade300)),
                      padding: const EdgeInsets.all(12),
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                          ),
                          useRootNavigator: true,
                          isScrollControlled: true,
                          builder: (context) {
                            return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: const LoginWidgets());
                          });
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green.shade400,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
