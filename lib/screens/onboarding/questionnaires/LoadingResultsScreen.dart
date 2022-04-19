import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/nextScreenModal.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';
import 'dart:async';

class LoadingResultsScreen extends StatelessWidget {
  const LoadingResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const LoadingResultsScreenWidget();
}

class LoadingResultsScreenWidget extends StatefulWidget {
  const LoadingResultsScreenWidget({Key? key}) : super(key: key);

  @override
  State<LoadingResultsScreenWidget> createState() =>
      _LoadingResultsScreenState();
}

class _LoadingResultsScreenState extends State<LoadingResultsScreenWidget> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() => Get.off(const nextScreenModal(),
      transition: Transition.fadeIn, duration: const Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: MediaQuery.of(context).size.height,
        widthFactor: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 145.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  'assets/images/flower_fill.gif',
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Evaluating your answers, your results are now being prepared...',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.neutralGray04),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
