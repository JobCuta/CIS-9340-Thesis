import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SideMenu.dart';


class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen>{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: SideMenu(),
      appBar: AppBar(
        primary: true,
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
        title: Text('Daily Entries')
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background_images/blue_background.png',
                    ),
                    fit: BoxFit.cover))),

          SingleChildScrollView(
          child: Column(
            children: [
              // EMOTION CONTAINER
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 120, 25, 0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),

                      
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('/entriesDetailScreen');
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/face_very_bad.png'),
                          width: 62,
                          height: 62,
                        ),
                  
                        const SizedBox(width: 10.0),
                  
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('WEDNESDAY, FEBRUARY 7',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text('Overall Mood: Happy',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                        
                              const SizedBox(height: 10.0),
                        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Evening check  22:21',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                  ),
                        
                                  const Image(
                                    image: AssetImage('assets/images/face_very_bad.png'), 
                                    width: 24, 
                                    height: 24
                                  )
                                ],
                              ),
                        
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Afternoon check  12:21',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                  ),
                        
                                  const Image(
                                    image: AssetImage('assets/images/face_very_bad.png'), 
                                    width: 24, 
                                    height: 24
                                  )
                                ],
                              ),
                        
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Morning check  7:21',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                  ),
                        
                                  const Image(
                                    image: AssetImage('assets/images/face_very_bad.png'), 
                                    width: 24, 
                                    height: 24
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10.0),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),

                      
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/face_very_bad.png'),
                          width: 62,
                          height: 62,
                        ),
                  
                        const SizedBox(width: 10.0),
                  
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('WEDNESDAY, FEBRUARY 7',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text('Overall Mood: Happy',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                        
                              const SizedBox(height: 10.0),
                        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Evening check  22:21',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                  ),
                        
                                  const Image(
                                    image: AssetImage('assets/images/face_very_bad.png'), 
                                    width: 24, 
                                    height: 24
                                  )
                                ],
                              ),
                        
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Afternoon check  12:21',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                  ),
                        
                                  const Image(
                                    image: AssetImage('assets/images/face_very_bad.png'), 
                                    width: 24, 
                                    height: 24
                                  )
                                ],
                              ),
                        
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Morning check  7:21',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                  ),
                        
                                  const Image(
                                    image: AssetImage('assets/images/face_very_bad.png'), 
                                    width: 24, 
                                    height: 24
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                      color: const Color(0xff216CB2).withOpacity(1.00),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Text(
                      '1 Day Missing',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)),
                ),
              ),
            ],
          )
        ),
        
      ]),
    );

    

  }
}