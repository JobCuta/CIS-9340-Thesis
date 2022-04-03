import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';

class UserJourneyScreen extends StatefulWidget {
  const UserJourneyScreen({key}) : super(key: key);

  @override
  State<UserJourneyScreen> createState() => _UserJourneyScreenState();
}

class _UserJourneyScreenState extends State<UserJourneyScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Your Adventure',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Theme.of(context).colorScheme.neutralWhite01,
              fontWeight: FontWeight.w400),
        ),
        leading: BackButton(onPressed: () => {Get.offAndToNamed('/adventureHome')}),
        primary: true,
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
      ),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background_images/adventure_background.png',),
                      fit: BoxFit.cover))),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: ListView(
                  children: [
                    Image.asset('assets/images/Apayao.png',
                    width: 328,
                    height: 100,
                    fit: BoxFit.cover,),
                    const SizedBox(height: 5.0),
                    Image.asset('assets/images/Kalinga.png',
                      width: 328,
                      height: 100,
                      fit: BoxFit.cover,),
                    const SizedBox(height: 5.0),
                    Image.asset('assets/images/Abra.png',
                      width: 328,
                      height: 100,
                      fit: BoxFit.cover,),
                    const SizedBox(height: 5.0),
                    Image.asset('assets/images/Mt Province.png',
                      width: 328,
                      height: 100,
                      fit: BoxFit.cover,),
                    const SizedBox(height: 5.0),
                    Image.asset('assets/images/Ifugao.png',
                      width: 328,
                      height: 100,
                      fit: BoxFit.cover,),
                    const SizedBox(height: 5.0),
                    Image.asset('assets/images/Benguet.png',
                      width: 328,
                      height: 100,
                      fit: BoxFit.cover,),
                    const SizedBox(height: 5.0),
                  ],
                )
                ),
              )
        ],
      )
    );
  }

}