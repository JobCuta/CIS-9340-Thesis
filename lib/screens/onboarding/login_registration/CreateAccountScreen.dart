import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../widgets/LoginModal.dart';
import '../../../widgets/RegisterModal.dart';

void main() {
  runApp(const CreateAccountScreen());
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: Container(
          decoration:
              const BoxDecoration(color: Color.fromRGBO(242, 255, 245, 1.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 60, 15, 15),
                child: Text(
                  'Before we continue...',
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.teal[900]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset('assets/images/create.svg'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Create an account!',
                style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'All interactions and data are fully encrypted and secure. Your data is safe with us!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.teal[900]),
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
                    style: Theme.of(context).elevatedButtonTheme.style,
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
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Already have an account?',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color.fromRGBO(78, 78, 78, 1)),
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
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.green.shade400),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
