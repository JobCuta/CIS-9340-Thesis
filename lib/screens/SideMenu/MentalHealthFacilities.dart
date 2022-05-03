import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/main/SideMenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/constants/Facilities.dart'
as constants;

class MentalHealthFacilitiesScreen extends StatefulWidget {
  const MentalHealthFacilitiesScreen({key}) : super(key: key);

  @override
  State<MentalHealthFacilitiesScreen> createState() =>
      _MentalHealthFacilitiesScreenState();
}

class _MentalHealthFacilitiesScreenState extends State<MentalHealthFacilitiesScreen> {
  _buildTextField(text, value) {
    return Container(
        height: 40,
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    fontWeight: FontWeight.w400)),
            GestureDetector(
                onTap: () {
                  //  Clipboard.setData(ClipboardData(text: value));
                  launch('tel:$value');
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
                            _buildTextField('Philippine Mental Health Association-Baguio, BGH Exit Rod, Marcos Highway, Baguio City, 2600', constants.paid1),
                            _buildTextField('Roseville Rehabilitation Center, 59 Balacbac Road, Sto. Tomas Proper, Baguio City', constants.paid2),
                            _buildTextField('Serenity in the Steps, Mararahay Ka Rehab and Treatment Facility, 26 The Steps, Gulf View Horizon, Suello Village, Marcos Hi-way, Baguio City, Benguet, Philippines', constants.paid3),
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
                            _buildTextField('Shalom House, Incorporated Drug Abuse Prevention, Treatment and Recovery Center, Philippine Nurses Association Building, Upper Session Road Extension, Baguio, Benguet', constants.free),
                            Text(
                              'Support Groups accessible through FB:',
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
                            _buildTextField('Baguio Mental Health Support Group', constants.support1),
                            _buildTextField('Mental Health Matters by Kylie Verzosa', constants.support2),
                            _buildTextField('MentalHealthPH', constants.support4),
                            _buildTextField('No To Mental Health Stigma PH', constants.support5),
                            _buildTextField('Philippine Mental Health Association, Inc.', constants.support6),
                            _buildTextField('Anxiety and Depression Support Philippines', constants.support7),
                            _buildTextField('SOS Philippines', constants.support8),
                            _buildTextField('Tala Mental Wellness', constants.support9),
                            _buildTextField('Youth For Mental Health Coalition', constants.support10),
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
