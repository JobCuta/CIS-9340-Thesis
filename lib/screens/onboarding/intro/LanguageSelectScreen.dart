import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/settingsController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

void main() => runApp(const LanguageSelect());

class LanguageSelect extends StatefulWidget {
  const LanguageSelect({Key? key}) : super(key: key);

  @override
  State<LanguageSelect> createState() => _LanguageSelectState();
}

final SettingsController _settingsController = Get.put(SettingsController());

class _LanguageSelectState extends State<LanguageSelect> {
  @override
  Widget build(BuildContext context) {
    bool absorbing = true;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SvgPicture.asset(
                            'assets/images/language-select.svg')),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text("Select language",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralBlack02)),
                    ),
                    Text(
                      'Which language would you like to access the app in',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.accentIndigo01),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8.0),
                      child: Text(
                        "Language",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.neutralGray02),
                      ),
                    ),
                    ListView(shrinkWrap: true, //just set this property
                        children: [
                          RadioListTile(
                            title: Text('English',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralBlack02)),
                            value: 'English',
                            activeColor:
                                Theme.of(context).colorScheme.intGreenMain,
                            controlAffinity: ListTileControlAffinity.trailing,
                            groupValue: _settingsController.language.value,
                            onChanged: (String? value) {
                              _settingsController.language.value =
                                  value.toString();
                            },
                          ),
                        ]),
                    AbsorbPointer(
                      absorbing: absorbing,
                      child: RadioListTile(
                        tileColor: Theme.of(context).colorScheme.neutralWhite04,
                        title: Text('Ilocano',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02)),
                        value: 'Ilocano',
                        activeColor: Theme.of(context).colorScheme.intGreenMain,
                        controlAffinity: ListTileControlAffinity.trailing,
                        groupValue: _settingsController.language.value,
                        onChanged: (String? value) {
                          absorbing
                              ? _settingsController.language.value =
                                  value.toString()
                              : '';
                        },
                      ),
                    ),
                    // Remove after localization is integrated
                    AbsorbPointer(
                      absorbing: absorbing,
                      child: RadioListTile(
                        tileColor: Theme.of(context).colorScheme.neutralWhite04,
                        title: Text('Tagalog',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02)),
                        value: 'Tagalog',
                        activeColor: Theme.of(context).colorScheme.intGreenMain,
                        groupValue: _settingsController.language.value,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (String? value) {
                          absorbing
                              ? _settingsController.language.value =
                                  value.toString()
                              : '';
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.intGreenMain),
              onPressed: () {
                _settingsController.updateLanguageSettings(
                    newLanguage: _settingsController.language.value);
                Get.toNamed('/introScreen');
              },
              child: Text('Continue',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralWhite01))),
        ),
      ),
    );
  }
}
