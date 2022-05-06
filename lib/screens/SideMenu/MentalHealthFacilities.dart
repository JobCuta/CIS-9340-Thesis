import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/SideMenu/SideMenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/constants/Facilities.dart' as constants;

class MentalHealthFacilitiesScreen extends StatefulWidget {
  const MentalHealthFacilitiesScreen({key}) : super(key: key);

  @override
  State<MentalHealthFacilitiesScreen> createState() =>
      _MentalHealthFacilitiesScreenState();
}

class _MentalHealthFacilitiesScreenState
    extends State<MentalHealthFacilitiesScreen> {
  _buildTextFieldURL(text, value) {
    return Container(
        height: 40,
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(text,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.neutralWhite01,
                      fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
                onTap: () {
                  launch('https:$value');
                },
                child: SvgPicture.asset('assets/images/copy_icon.svg')),
          ],
        ));
  }

  _buildTextFieldGeo(text, coordinates) {
    return Container(
        // height: 40,
        padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(text,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.neutralWhite01,
                      fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
                onTap: () async {
                  String query = Uri.encodeComponent(text);
                  var mapSchema =
                      'geo:${coordinates[0]},${coordinates[1]}?q=$query';
                  if (await canLaunch(mapSchema)) {
                    await launch(mapSchema);
                  } else {
                    throw 'Could not launch $mapSchema';
                  }
                },
                child: SvgPicture.asset('assets/images/copy_icon.svg')),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Mental Health Facilities',
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
                    vertical: 15.0, horizontal: 20.0),
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
                                  const BorderRadius.all(Radius.circular(12))),
                          child: Text(
                              'Speak with someone from your area’s mental health or crisis facility.',
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
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Text(
                              'Available Facilities:',
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
                              'Paid Facilities:',
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
                            _buildTextFieldGeo(
                                constants.paid1, constants.paid1Coordinates),
                            _buildTextFieldGeo(
                                constants.paid2, constants.paid2Coordinates),
                            _buildTextFieldGeo(
                                constants.paid3, constants.paid3Coordinates),
                            Text(
                              'Free Facility:',
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
                            _buildTextFieldGeo(
                                constants.free, constants.freeCoordinates),
                            Text(
                              'Facebook Support Groups:',
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
                            _buildTextFieldURL(
                                'Baguio Mental Health Support Group',
                                constants.support1),
                            _buildTextFieldURL(
                                'Mental Health Matters by Kylie Verzosa',
                                constants.support2),
                            _buildTextFieldURL(
                                'MentalHealthPH', constants.support4),
                            _buildTextFieldURL('No To Mental Health Stigma PH',
                                constants.support5),
                            _buildTextFieldURL(
                                'Philippine Mental Health Association, Inc.',
                                constants.support6),
                            _buildTextFieldURL(
                                'Anxiety and Depression Support Philippines',
                                constants.support7),
                            _buildTextFieldURL(
                                'SOS Philippines', constants.support8),
                            _buildTextFieldURL(
                                'Tala Mental Wellness', constants.support9),
                            _buildTextFieldURL(
                                'Youth For Mental Health Coalition',
                                constants.support10),
                          ],
                        ),
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
