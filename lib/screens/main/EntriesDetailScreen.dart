import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/enums/PartOfTheDay.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:get/get.dart';
import 'SideMenu.dart';


class EntriesDetailScreen extends StatefulWidget {
  const EntriesDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EntriesDetailScreenState();
}


final EmotionController _emotionController = Get.put(EmotionController());

class _EntriesDetailScreenState extends State<EntriesDetailScreen>{
  EmotionEntryHive emotionEntry = _emotionController.getSelectedEmotionEntry();

  Map<int, String> month = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: SideMenu(),
      appBar: AppBar(
        primary: true,
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
        title: Text(emotionEntry.date)
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
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),

                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                image: moodMap[emotionEntry.eveningCheck.mood]!.icon,
                                width: 62,
                                height: 62,
                              ),
                          
                              const SizedBox(width: 10.0),
                          
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Overall Mood: ' + (emotionEntry.eveningCheck.mood != 'NoData' ? emotionEntry.eveningCheck.mood : 'Empty'),
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                                        ),

                                        PopupMenuButton(
                                          onSelected: (value) {
                                            if (value == 'Edit') {
                                              _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Evening);
                                              _emotionController.updateSelectedEmotionEntry(emotionEntry);
                                              _emotionController.updateEditMode(true);
                                              _emotionController.updateIfAddingFromDaily(false);
                                              Get.toNamed('/emotionStartScreen');
                                            } else if (value == 'Delete') {
                                              _emotionController.deleteEmotionEntry(PartOfTheDay.Evening);
                                              Get.toNamed('/entriesScreen');
                                            }
                                          },
                                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                            PopupMenuItem(
                                              value: 'Edit',
                                              child: Text('Edit', style: Theme.of(context).textTheme.bodyText2),
                                            ),
                                            PopupMenuItem(
                                              value: 'Delete',
                                              child: Text('Delete', style: Theme.of(context).textTheme.bodyText2),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                              
                                    const SizedBox(height: 5.0),
                            
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Evening check ' + (emotionEntry.eveningCheck.mood != 'NoData' ? emotionEntry.eveningCheck.time : 'missed'),
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                        ),

                                        (emotionEntry.eveningCheck.mood != 'NoData') 
                                        ? Image(
                                          image: moodMap[emotionEntry.eveningCheck.mood]!.icon, 
                                          width: 24, 
                                          height: 24
                                        )
                                        : IconButton(onPressed: () {
                                            _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Evening);
                                            _emotionController.updateIfAddingFromDaily(false);
                                            _emotionController.updateEditMode(false);
                                            _emotionController.updateIfAddingFromDaily(false);

                                            Get.toNamed('/emotionStartScreen');
                                          }, icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)))
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
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0), fontWeight: FontWeight.w600)
                              ),
                  
                              const SizedBox(height: 5.0),
                              Text(emotionEntry.eveningCheck.note,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),
                  
                              const SizedBox(height: 15.0),
                              Text('Emotions you felt at this time:',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0), fontWeight: FontWeight.w600)
                              ),
                  
                              const SizedBox(height: 10.0),
                              Text('Positive',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),

                              Text(emotionEntry.eveningCheck.positiveEmotions.toString(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),

                              const SizedBox(height: 10.0),
                              Text('Negative',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),

                              Text(emotionEntry.eveningCheck.negativeEmotions.toString(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),
                            ],
                          ),        
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
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
                              Image(
                                image: moodMap[emotionEntry.afternoonCheck.mood]!.icon,
                                width: 62,
                                height: 62,
                              ),
                          
                              const SizedBox(width: 10.0),
                          
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Overall Mood: ' + (emotionEntry.afternoonCheck.mood != 'NoData' ? emotionEntry.afternoonCheck.mood : 'Empty'),
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                                        ),

                                        PopupMenuButton(
                                          onSelected: (value) {
                                            if (value == 'Edit') {
                                              _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Afternoon);
                                              _emotionController.updateSelectedEmotionEntry(emotionEntry);
                                              _emotionController.updateEditMode(true);
                                              _emotionController.updateIfAddingFromDaily(false);

                                              Get.toNamed('/emotionStartScreen');
                                            }  else if (value == 'Delete') {
                                              _emotionController.deleteEmotionEntry(PartOfTheDay.Afternoon);
                                              Get.toNamed('/entriesScreen');
                                            }
                                          },
                                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                            PopupMenuItem(
                                              value: 'Edit',
                                              child: Text('Edit', style: Theme.of(context).textTheme.bodyText2),
                                            ),
                                            PopupMenuItem(
                                              value: 'Delete',
                                              child: Text('Delete', style: Theme.of(context).textTheme.bodyText2),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                              
                                    const SizedBox(height: 5.0),
                            
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Afternoon check ' + (emotionEntry.afternoonCheck.mood != 'NoData' ? emotionEntry.afternoonCheck.time : 'missed'),
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                        ),
                              
                                        (emotionEntry.afternoonCheck.mood != 'NoData') 
                                        ? Image(
                                          image: moodMap[emotionEntry.afternoonCheck.mood]!.icon, 
                                          width: 24, 
                                          height: 24
                                        )
                                        : IconButton(onPressed: () {
                                            _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Afternoon);
                                            _emotionController.updateIfAddingFromDaily(false);
                                            _emotionController.updateEditMode(false);
                                            _emotionController.updateIfAddingFromDaily(false);

                                            Get.toNamed('/emotionStartScreen');
                                          }, icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)))
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
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0), fontWeight: FontWeight.w600)
                              ),
                  
                              const SizedBox(height: 5.0),
                              Text(emotionEntry.afternoonCheck.note,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),
                  
                              const SizedBox(height: 15.0),
                              Text('Emotions you felt at this time:',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0), fontWeight: FontWeight.w600)
                              ),
                  
                              const SizedBox(height: 10.0),
                              Text('Positive',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),

                              Text(emotionEntry.afternoonCheck.positiveEmotions.toString(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),

                              const SizedBox(height: 10.0),
                              Text('Negative',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),

                              Text(emotionEntry.afternoonCheck.negativeEmotions.toString(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                              ),
                            ],
                          ),        
                        ],
                      ),
                )
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
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
                        Image(
                          image: moodMap[emotionEntry.morningCheck.mood]!.icon,
                          width: 62,
                          height: 62,
                        ),
                    
                        const SizedBox(width: 10.0),
                    
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Overall Mood: ' + (emotionEntry.morningCheck.mood != 'NoData' ? emotionEntry.morningCheck.mood : 'Empty'),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                                  ),

                                  PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 'Edit') {
                                        _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Morning);
                                        _emotionController.updateSelectedEmotionEntry(emotionEntry);
                                        _emotionController.updateEditMode(true);
                                        _emotionController.updateIfAddingFromDaily(false);

                                        Get.toNamed('/emotionStartScreen');
                                      }  else if (value == 'Delete') {
                                          _emotionController.deleteEmotionEntry(PartOfTheDay.Morning);
                                          Get.toNamed('/entriesScreen');
                                        }
                                    },
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                      PopupMenuItem(
                                        value: 'Edit',
                                        child: Text('Edit', style: Theme.of(context).textTheme.bodyText2),
                                      ),
                                      PopupMenuItem(
                                        value: 'Delete',
                                        child: Text('Delete', style: Theme.of(context).textTheme.bodyText2),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                        
                              const SizedBox(height: 5.0),
                      
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Morning check ' + (emotionEntry.morningCheck.mood != 'NoData' ? emotionEntry.morningCheck.time : 'missed'),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                    ),
                                    
                                    (emotionEntry.morningCheck.mood != 'NoData') 
                                        ? Image(
                                          image: moodMap[emotionEntry.morningCheck.mood]!.icon, 
                                          width: 24, 
                                          height: 24
                                        )
                                        : IconButton(onPressed: () {
                                            _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Morning);
                                            _emotionController.updateIfAddingFromDaily(false);
                                            _emotionController.updateEditMode(false);
                                            _emotionController.updateIfAddingFromDaily(false);
                                            
                                            Get.toNamed('/emotionStartScreen');
                                          }, icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)))
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
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0), fontWeight: FontWeight.w600)
                        ),
            
                        const SizedBox(height: 5.0),
                        Text(emotionEntry.morningCheck.note,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                        ),
            
                        const SizedBox(height: 15.0),
                        Text('Emotions you felt at this time:',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0), fontWeight: FontWeight.w600)
                        ),
            
                        const SizedBox(height: 10.0),
                        Text('Positive',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                        ),

                        Text(emotionEntry.morningCheck.positiveEmotions.toString(),
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                        ),

                        const SizedBox(height: 10.0),
                        Text('Negative',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                        ),

                        Text(emotionEntry.morningCheck.negativeEmotions.toString(),
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                        ),
                      ],
                    ),        
                  ],
                ),
                )),

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