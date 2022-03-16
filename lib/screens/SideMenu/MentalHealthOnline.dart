import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class MentalHealthOnlineScreen extends StatefulWidget {
  const MentalHealthOnlineScreen({key}) : super(key: key);

  @override
  State<MentalHealthOnlineScreen> createState() => _MentalHealthOnlineScreenState();
}

class _MentalHealthOnlineScreenState extends State<MentalHealthOnlineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text(
            'Mental Health Online',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          leading: BackButton(onPressed: () => {Get.offAndToNamed('/homepage')}),
          primary: true,
          elevation: 0,
          backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
      ),
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background_images/blue_background.png',),
                    fit: BoxFit.cover))
        ),
        SafeArea(
          child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
            decoration: BoxDecoration(
                color: const Color(0xff3290FF).withOpacity(0.60),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                decoration: BoxDecoration(
                    color: const Color(0xff216CB2).withOpacity(0.20),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child:Text('Speak with someone from your area’s mental health or crisis hotline service. Although we encourage you to use the hotline, we cannot guarantee its availability or the quality of its service.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400)),
              ),
              const SizedBox(height: 20.0),
              ListView(
                shrinkWrap: true,
                children: [
                  Text('Available Hotlines:',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15.0),
                  Text('Luzon-wide Landline toll-free:',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1553',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        IconButton(icon: const Icon(Icons.content_copy, color: Colors.white),
                          onPressed: () => Clipboard.setData(const ClipboardData(text: '1553')),)
                      ]),
                  Text('GLOBE / TM Subscribers:',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0966-351-4518',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        IconButton(icon: const Icon(Icons.content_copy, color: Colors.white),
                          onPressed: () => Clipboard.setData(const ClipboardData(text: '0966-351-4518')),)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0917-899-8727',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        IconButton(icon: const Icon(Icons.content_copy, color: Colors.white),
                          onPressed: () => Clipboard.setData(const ClipboardData(text: '0917-899-8727')),)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0917-899-USAP',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        IconButton(icon: const Icon(Icons.content_copy, color: Colors.white),
                          onPressed: () => Clipboard.setData(const ClipboardData(text: '0917-899-USAP')),)
                      ]),
                  Text('National Center for Mental Health 24/7:',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0966-351-4518',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        IconButton(icon: const Icon(Icons.content_copy, color: Colors.white),
                          onPressed: () => Clipboard.setData(const ClipboardData(text: '0966-351-4518')),)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0917-899-8727',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        IconButton(icon: const Icon(Icons.content_copy, color: Colors.white),
                          onPressed: () => Clipboard.setData(const ClipboardData(text: '0917-899-8727')),)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0917-899-USAP',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        IconButton(icon: const Icon(Icons.content_copy, color: Colors.white),
                          onPressed: () => Clipboard.setData(const ClipboardData(text: '0917-899-USAP')),)
                      ]),
                  Text('SMART/SUN/TNT Subscribers:',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0908-639-2672',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        IconButton(icon: const Icon(Icons.content_copy, color: Colors.white),
                          onPressed: () => Clipboard.setData(const ClipboardData(text: '0908-639-2672')),)
                      ]),
                ],
              ),
            ]),
          ),
        ),
        ),
      ],),
    );
  }
}

