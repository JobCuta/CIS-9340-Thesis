import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/enums/PartOfTheDay.dart';
import 'package:flutter_application_1/models/Mood.dart';
import 'package:get/get.dart';
import 'SideMenu.dart';


class EntriesScreen extends StatefulWidget {
  const EntriesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EntriesScreenState();
}


final EmotionController _emotionController = Get.put(EmotionController());

class _EntriesScreenState extends State<EntriesScreen>{
  List<EmotionEntryHive> emotionEntries = _emotionController.getAllEmotionEntries();
  Map<int, String> weekdayString = {
    1 : 'Monday',
    2 : 'Tuesday',
    3 : 'Wednesday',
    4 : 'Thursday',
    5 : 'Friday',
    6 : 'Saturday',
    7 : 'Sunday'
  }; 

  Container _checkIfMonthLabelToDisplay(int index) {
    if (emotionEntries[index].month != emotionEntries[index--].month) {
          return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
          vertical: 12.0, horizontal: 12.0),
      decoration: BoxDecoration(
          color: const Color(0xff216CB2).withOpacity(1.00),
          borderRadius:
              const BorderRadius.all(Radius.circular(10))),
      child: Text(
          emotionEntries[index--].month + " " + emotionEntries[index--].day.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)),
    );
    }
    return Container();
  }

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

              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: emotionEntries.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(25, 120, 25, 0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),

                          
                      child: InkWell(
                        onTap: () {
                          _emotionController.updateSelectedEmotionEntry(emotionEntries[index]);
                          Get.toNamed('/entriesDetailScreen');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: moodMap[emotionEntries[index].overallMood]!.icon, 
                              width: 62,
                              height: 62,
                            ),
                      
                            const SizedBox(width: 10.0),
                      
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text((emotionEntries[index].weekday + " " + emotionEntries[index].month + " " + emotionEntries[index].day.toString()).toUpperCase(),
                                    style: Theme.of(context).textTheme.caption!.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0)),
                                  ),
                                  Text('Overall Mood: ' + emotionEntries[index].overallMood,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                                  ),
                            
                                  const SizedBox(height: 10.0),
                            
                                  SizedBox(
                                    height: 35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text('Evening check ' + emotionEntries[index].eveningCheck.time,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                          ),
                                        ),
                            
                                        (emotionEntries[index].eveningCheck.mood != 'NoData') 
                                        ? Image(
                                          image: moodMap[emotionEntries[index].eveningCheck.mood]!.icon, 
                                          width: 24, 
                                          height: 24
                                        )
                                        : IconButton(onPressed: () {
                                            _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Evening);
                                            _emotionController.updateIfAddingFromDaily(false);
                                            _emotionController.updateEditMode(false);
                                            Get.toNamed('/emotionStartScreen');
                                          }, icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)))
                                      ],
                                    ),
                                  ),
                            
                                  SizedBox(
                                    height: 35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text('Afternoon check ' + emotionEntries[index].afternoonCheck.time,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                          ),
                                        ),
                            
                                      (emotionEntries[index].afternoonCheck.mood != 'NoData') 
                                        ? Image(
                                          image: moodMap[emotionEntries[index].afternoonCheck.mood]!.icon, 
                                          width: 24, 
                                          height: 24
                                        )
                                        : IconButton(onPressed: () {
                                            _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Afternoon);
                                            _emotionController.updateIfAddingFromDaily(false);
                                            _emotionController.updateEditMode(false);
                                            Get.toNamed('/emotionStartScreen');
                                          }, icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)))
                                      ],
                                    ),
                                  ),
                            
                                  SizedBox(
                                    height: 35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text('Morning check ' + emotionEntries[index].morningCheck.time,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))
                                          ),
                                        ),
                            
                                      (emotionEntries[index].morningCheck.mood != 'NoData') 
                                        ? Image(
                                          image: moodMap[emotionEntries[index].morningCheck.mood]!.icon, 
                                          width: 24, 
                                          height: 24
                                        )
                                        : IconButton(onPressed: () {
                                            _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Morning);
                                            _emotionController.updateIfAddingFromDaily(false);
                                            _emotionController.updateEditMode(false);
                                            Get.toNamed('/emotionStartScreen');
                                          }, 
                                          icon: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0)),
                                        )
                                      ],
                                    ),
                                  ),

                                  _checkIfMonthLabelToDisplay(index)
                                ],
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  );
                }
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