import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_svg/svg.dart';
import '../../../widgets/LoginModal.dart';
import '../../../widgets/RegisterModal.dart';

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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 60, 15, 15),
                child: Text(
                  'Before we continue...',
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.intGreen07,
                      fontWeight: FontWeight.w600),
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
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.neutralBlack02),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'All interactions and data are fully encrypted and secure. Your data is safe with us!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.intGreen07,
                      height: 2),
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
                        elevation: 0,
                        primary: Theme.of(context).colorScheme.intGreenMain),
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
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.neutralWhite01,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Already have an account?',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: const Color(0xff4E4E4E)),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.neutralWhite04),
                      primary: Theme.of(context).colorScheme.neutralWhite01,
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
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Theme.of(context).colorScheme.intGreenMain,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
