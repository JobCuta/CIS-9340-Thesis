import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:get/get.dart';

void main() => runApp(const LevelExperienceModal());

class LevelExperienceModal extends StatelessWidget {
  const LevelExperienceModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: LevelWidgets(),
    );
  }
}

class LevelWidgets extends StatefulWidget {
  const LevelWidgets({Key? key}) : super(key: key);

  @override
  State<LevelWidgets> createState() => _LevelWidgetsState();
}

class _LevelWidgetsState extends State<LevelWidgets> {
  final LevelController _levelController = Get.put(LevelController());
  Map<String, int> experiences = {
    'Daily Entry' : 50,
    'Exercise' : 100
  };
  int totalXp = 0;

  SizedBox addXp(int xp) {
    _levelController.addXp(xp);

    return const SizedBox(height: 10.0);
  }

  @override
  Widget build(BuildContext context) {
    List<String> experienceKeys = experiences.keys.toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 50),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                    child: Text('Congratulations',
                        style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.accentBlue04))),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  'Your just gained your first experience!',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.accentBlue04),
                ),
              ),

              const Divider(
                color: Color(0xffF0F1F1),
                height: 25,
                thickness: 1,
              ),

              ListView.builder(
                shrinkWrap: true,
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  String key = experienceKeys[index];
                  int xp = experiences[key] as int;
                  totalXp += xp;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(key,
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralBlack02),
                          ),
                          Text(xp.toString() + ' ' + 'xp',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.accentBlue04),
                          ),
                        ],
                      ),

                      const Divider(
                        color: Color(0xffF0F1F1),
                        height: 25,
                        thickness: 1,
                      ),
                    ],
                  );
                }
              ),
              Text(_levelController.currentLevel.value.toString(),
                  style: Theme.of(context).textTheme.headline1?.copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.accentBlue04),
              ),
              Text('LEVEL',
                  style: Theme.of(context).textTheme.headline2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.accentIndigo04),
              ),
              Text(
                _levelController.currentXp.toString() + "/" + _levelController.xpForNextLevel().toString() + " till next level up",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.accentBlue04),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: GetBuilder<LevelController>(
                        builder: (value) => ElevatedButton(
                            child: Text(
                              'Great!',
                              style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.all(10),
                              primary:const Color(0xffFFBE18)
                            ),
                            onPressed: () {
                              Get.back();
                            }),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}