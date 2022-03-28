import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/main/SideMenu.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/constants/HotlineNumbers.dart'
    as constants;

class MentalHealthOnlineScreen extends StatefulWidget {
  const MentalHealthOnlineScreen({key}) : super(key: key);

  @override
  State<MentalHealthOnlineScreen> createState() =>
      _MentalHealthOnlineScreenState();
}

class _MentalHealthOnlineScreenState extends State<MentalHealthOnlineScreen> {
  _buildNumberField(number, value) {
    return Container(
        height: 40,
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(number,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    fontWeight: FontWeight.w400)),
            IconButton(
                icon: Icon(Icons.content_copy,
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    size: 20),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: value));
                  launch('tel:$value');
                })
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Mental Health Online',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Theme.of(context).colorScheme.neutralWhite01,
              fontWeight: FontWeight.w400),
        ),
        // leading: BackButton(onPressed: () => {Get.offAndToNamed('/homepage')}),
        primary: true,
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
      ),
      drawer: const SideMenu(),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background_images/blue_background.png',
                      ),
                      fit: BoxFit.cover))),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 18.0),
                decoration: BoxDecoration(
                    color: const Color(0xff3290FF).withOpacity(0.60),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 18.0),
                          decoration: BoxDecoration(
                              color: const Color(0xff216CB2).withOpacity(0.20),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                          child: Text(
                              'Speak with someone from your area’s mental health or crisis hotline service. Although we encourage you to use the hotline, we cannot guarantee its availability or the quality of its service.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      fontWeight: FontWeight.w400)),
                        ),
                        const SizedBox(height: 20.0),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Text(
                              'Available Hotlines:',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 15.0),
                            Text(
                              'Luzon-wide Landline toll-free:',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      fontWeight: FontWeight.w600),
                            ),
                            _buildNumberField('1553', constants.luzonLandline),
                            Text(
                              'GLOBE / TM Subscribers:',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      fontWeight: FontWeight.w600),
                            ),
                            _buildNumberField(
                                '0966-351-4518', constants.globeSubscribers1),
                            _buildNumberField(
                                '0917-899-8727', constants.globeSubscribers2),
                            _buildNumberField(
                                '0917-899-USAP', constants.globeSubscribers3),
                            Text(
                              'National Center for Mental Health 24/7:',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      fontWeight: FontWeight.w600),
                            ),
                            _buildNumberField(
                                '0966-351-4518', constants.nationalCenter1),
                            _buildNumberField(
                                '0917-899-8727', constants.nationalCenter2),
                            _buildNumberField(
                                '0917-899-USAP', constants.nationalCenter3),
                            Text(
                              'SMART/SUN/TNT Subscribers:',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      fontWeight: FontWeight.w600),
                            ),
                            _buildNumberField(
                                '0908-639-2672', constants.smartSubscribers),
                          ],
                        ),
                        SizedBox(height: 100)
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
