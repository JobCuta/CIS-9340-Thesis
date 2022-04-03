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
    int noEntriesCount = _emotionController.noEntriesCount.value;
    if (noEntriesCount > 0) {
      _emotionController.checkNoEntriesCount();
      noEntriesCount = _emotionController.noEntriesCount.value;
    }

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
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
              // EMOTION CONTAINER
              
              (noEntriesCount > 0) 
              ? Padding(
                padding: const EdgeInsets.fromLTRB(15, 100, 15, 0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                      color: const Color(0xff216CB2).withOpacity(1.00),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Text(
                      (noEntriesCount == 1) ? '1 Day Missing' : '$noEntriesCount Days Missing',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white)),
                ),
              ) 
              : const SizedBox(height: 10.0),

              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: emotionEntries.length,
                physics: const NeverScrollableScrollPhysics(),      // so that it won't conflict with SingleChildScrollView
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
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
                                  RichText(
                                    text: TextSpan(
                                        text: 'Overall Mood: ',
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: (emotionEntries[index].overallMood == 'NoData' 
                                                  ? 'Empty' : emotionEntries[index].overallMood == 'VeryHappy' 
                                                  ? 'Very Happy' : emotionEntries[index].overallMood == 'VeryBad'
                                                  ? 'Very Bad' : emotionEntries[index].overallMood),
                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  fontWeight: FontWeight.w600, color: moodColor[emotionEntries[index].overallMood])),
                                        ]
                                    ),
                                  ),
                            
                                  const SizedBox(height: 10.0),
                            
                                  SizedBox(
                                    height: 35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Evening check ', 
                                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (emotionEntries[index].eveningCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                              children: <TextSpan>[
                                                TextSpan(text: (emotionEntries[index].eveningCheck.mood != 'NoData') ? emotionEntries[index].eveningCheck.time : 'missed', style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0))
                                              )]
                                            ),
                                          ),
                                        ),
                            
                                        (emotionEntries[index].eveningCheck.mood != 'NoData') 
                                        ? Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Image(
                                            image: moodMap[emotionEntries[index].eveningCheck.mood]!.icon, 
                                            width: 24, 
                                            height: 24
                                          ),
                                        )
                                        : Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: InkWell(
                                            onTap: () {
                                                _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Evening);
                                                _emotionController.updateIfAddingFromDaily(false);
                                                _emotionController.updateEditMode(false);
                                                _emotionController.updateDateTime(emotionEntries[index].month, emotionEntries[index].day, emotionEntries[index].year);
                                                Get.toNamed('/emotionStartScreen');
                                              }, 
                                            child: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0))
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                            
                                  SizedBox(
                                    height: 35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Afternoon check ', 
                                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (emotionEntries[index].afternoonCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                              children: <TextSpan>[
                                                TextSpan(text: (emotionEntries[index].afternoonCheck.mood != 'NoData') ? emotionEntries[index].afternoonCheck.time : 'missed', style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0))
                                              )]
                                            ),
                                          ),
                                        ),
                            
                                      (emotionEntries[index].afternoonCheck.mood != 'NoData') 
                                        ? Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Image(
                                            image: moodMap[emotionEntries[index].afternoonCheck.mood]!.icon, 
                                            width: 24, 
                                            height: 24
                                          ),
                                        )
                                        : Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: InkWell(
                                            onTap: () {
                                                _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Afternoon);
                                                _emotionController.updateIfAddingFromDaily(false);
                                                _emotionController.updateEditMode(false);
                                                _emotionController.updateDateTime(emotionEntries[index].month, emotionEntries[index].day, emotionEntries[index].year);
                                                Get.toNamed('/emotionStartScreen');
                                              }, 
                                            child: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0))
                                          )
                                        )
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
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Morning check ', 
                                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: (emotionEntries[index].morningCheck.mood != 'NoData') ? const Color(0xff161818).withOpacity(1.0) : const Color(0x00C7CBCC).withOpacity(1.0)),
                                              children: <TextSpan>[
                                                TextSpan(text: (emotionEntries[index].morningCheck.mood != 'NoData') ? emotionEntries[index].morningCheck.time : 'missed', style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0x00C7CBCC).withOpacity(1.0))
                                              )]
                                            ),
                                          ),
                                        ),
                            
                                      (emotionEntries[index].morningCheck.mood != 'NoData') 
                                        ? Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Image(
                                            image: moodMap[emotionEntries[index].morningCheck.mood]!.icon, 
                                            width: 24, 
                                            height: 24
                                          ),
                                        )
                                        : Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: InkWell(
                                            onTap: () {
                                                _emotionController.updatePartOfTheDayCheck(PartOfTheDay.Morning);
                                                _emotionController.updateIfAddingFromDaily(false);
                                                _emotionController.updateEditMode(false);
                                                _emotionController.updateDateTime(emotionEntries[index].month, emotionEntries[index].day, emotionEntries[index].year);
                                                Get.toNamed('/emotionStartScreen');
                                              }, 
                                            child: Icon(Icons.add_circle, color: const Color(0x004CA7FC).withOpacity(1.0))
                                          )
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
        
              const SizedBox(height: 100.0),

            ],
          )
        ),
        
      ]),
    );

    

  }
}