import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SideMenu.dart';


class EntriesDetailScreen extends StatefulWidget {
  const EntriesDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EntriesDetailScreenState();
}

class _EntriesDetailScreenState extends State<EntriesDetailScreen>{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: SideMenu(),
      appBar: AppBar(
        primary: true,
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
        title: Text('Feb 5, 2022')
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // EMOTION CONTAINER
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 120, 25, 0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),

                  child: Column(
                    children: [
                      Row(
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
                                Text('Overall Mood: Very Bad',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                          
                                const SizedBox(height: 15.0),
                        
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
                                )                                                                    
                              ],
                            ),
                          ),
                        ]
                      ),

                      const Divider(
                        color: Color(0xffF0F1F1),
                        height: 25,
                        thickness: 1,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15.0),
                          Text('Notes',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                          ),

                          const SizedBox(height: 5.0),
                          Text('Nothing happened',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                          ),

                          const SizedBox(height: 15.0),
                          Text('Emotions you felt at this time:',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                          ),

                          const SizedBox(height: 10.0),
                          Text('Positive',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                          ),

                          const SizedBox(height: 10.0),
                          Text('Negative',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                          ),
                        ],
                      ),        
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 140,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 18.0),
                  decoration: BoxDecoration(
                      color: const Color(0xff3290FF).withOpacity(0.60),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4))),
                  child: Column(children: [
                    Text('You missed some entries!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white)),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                          color: const Color(0xff216CB2).withOpacity(0.20),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Text(
                          'Make sure to add your missed entries to ensure that your wellness is being properly tracked by you and the app.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white)),
                    )
                  ])
                ),
              ),
            ],
          )
        ),
        
      ]),
    );
  }
}