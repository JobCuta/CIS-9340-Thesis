import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

class UserProfileDeactivateSuccessfulScreen extends StatefulWidget {
  const UserProfileDeactivateSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileDeactivateSuccessfulScreen> createState() =>
      _UserProfileDeactivateSuccessfulScreenState();
}

class _UserProfileDeactivateSuccessfulScreenState
    extends State<UserProfileDeactivateSuccessfulScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {});
      }
      // closes the app
      SystemNavigator.pop();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
          appBar: AppBar(
              elevation: 1,
              backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
              title: Text('Deactivated Sucessfully',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.neutralBlack02))),
          primary: true,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                    child: Wrap(
                        runSpacing: 25,
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 50),
                            child: SvgPicture.asset(
                              'assets/images/deactivateWave.svg',
                              height: 200,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 25),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .neutralWhite04,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Text(
                                'You have successfully deactivated your Kasiyanna account. Please note that it may take 7 days to complete the deactivation process.\nThank you for using our app.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray04)),
                          ),
                        ])),
              ],
            ),
          )),
    );
  }
}
