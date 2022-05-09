import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/adventureController.dart';
import 'package:flutter_application_1/controllers/memoryController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:flutter_application_1/widgets/talkingPersonDialog.dart';
import 'package:get/get.dart';
import '../../../controllers/levelController.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGameScreen> {
  final MemoryController _memoryController = Get.put(MemoryController());
  final AdventureController _adventureController =
      Get.put(AdventureController());
  int _previousIndex = -1;
  bool _flip = false;
  bool _wait = true;
  int _dialogueCounter = 0;
  late Province selectedProvince = _adventureController.selectedProvince.value;

  final List<bool> _cardFlips = getInitialItemState();
  final List<bool> _visibility = getInitialItemState();
  final List<GlobalKey<FlipCardState>> _cardStateKeys = getCardStateKeys();
  late final List<String> _data = getCards(selectedProvince);
  late final List<String> _dialogues = getDialogue(selectedProvince);
  bool _completed = false;
  final LevelController _levelController = Get.put(LevelController());
  String previousRoute = Get.previousRoute;

  @override
  void initState() {
    super.initState();
    _data.shuffle();
  }

  Widget getItem(int index) {
    if (_visibility[index] == true) {
      return SizedBox(
        height: 120,
        child: Card(
          color: const Color(0xffe9a4f6),
          child: Center(
            child: Image.asset(_data[index]),
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 120,
        child: Card(
          color: Colors.transparent,
        ),
      );
    }
  }

  void checkResult() {
    if (previousRoute != '/') {
      showTalkingPerson(
        context: context,
        dialog:
            'Congratulations! You beat the Memory Portion of the level! I’ll bring you back to the list of tasks.',
      ).then((value) {
        _adventureController
                  .checkIfItWillAddXpForCompletingAllActivities();
        Get.offAndToNamed('/ActivitiesGameScreen');
      });
      Future.delayed(const Duration(milliseconds: 0), () {
        _levelController.addXp('Memory Game', 50);
        _levelController.displayLevelXpModal(context);
        _memoryController.updateProvinceCompletion(selectedProvince);
      });
      print('previus route is' + previousRoute);
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        _levelController.addXp('Memory Game', 50);
        _levelController.displayLevelXpModal(context);
      });
      print('previus route is' + previousRoute);
      _memoryController.incrementMiniGamesWarrior();
    }
  }

  void memoryGameMan() {
    if (previousRoute != '/') {
      showTalkingPerson(
          context: context,
          dialog: _dialogues[_dialogueCounter])
          .then((value) {
        _dialogueCounter++;
        if (_dialogueCounter == 8) {
          setState(() {
            _completed = true;
            _dialogueCounter == 0;
          });
          if (_completed == true) {
            checkResult();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Memory (${selectedProvince.name})',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralWhite01,
                fontWeight: FontWeight.w400),
          ),
          leading: BackButton(onPressed: () {
            Get.back();
          }),
          elevation: 0,
          backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/background_images/adventure_background.png'),
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.10),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) => FlipCard(
                    key: _cardStateKeys[index],
                    onFlip: () {
                      if (!_flip) {
                        _flip = true;
                        _previousIndex = index;
                      } else {
                        _flip = false;
                        if (_previousIndex != index) {
                          if (_data[_previousIndex] != _data[index]) {
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                                  setState(() {
                                    _wait = true;
                                  });
                              _cardStateKeys[_previousIndex]
                                  .currentState!
                                  .toggleCard();
                              _previousIndex = index;
                              _cardStateKeys[_previousIndex]
                                  .currentState!
                                  .toggleCard();
                            });
                              setState(() {
                                _wait = false;
                              });
                          } else {
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              print('previous route is ' + previousRoute);
                              setState(() {
                                _wait = true;
                              });
                              _visibility[_previousIndex] = false;
                              _visibility[index] = false;
                              _cardFlips[_previousIndex] = false;
                              _cardFlips[index] = false;
                              memoryGameMan();
                            });
                              setState(() {
                                _wait = false;
                              });

                            print("counter: " + _dialogueCounter.toString());
                          }
                        }
                      }
                    },
                    flipOnTouch: _wait && _cardFlips[index] ? true : false,
                    front: const SizedBox(
                      height: 120,
                      child: Card(
                        child: Center(
                          child: Image(
                              image:
                                  AssetImage('assets/images/hidden_card.png')),
                        ),
                      ),
                    ),
                    back: getItem(index),
                  ),
                  itemCount: _data.length,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

List<String> getCards(Province province) {
  List<String> provinceCardsList = <String>[];
  List cardSource;
  if (province == Province.Abra) {
    cardSource = abraCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else if (province == Province.Apayao) {
    cardSource = apayaoCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else if (province == Province.Benguet) {
    cardSource = benguetCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else if (province == Province.Ifugao) {
    cardSource = ifugaoCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else if (province == Province.Kalinga) {
    cardSource = kalingaCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else {
    cardSource = mtProvinceCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  }
  return provinceCardsList;
}

List<GlobalKey<FlipCardState>> getCardStateKeys() {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < 16; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}

List<bool> getInitialItemState() {
  List<bool> initialItemState = <bool>[];
  for (int i = 0; i < 16; i++) {
    initialItemState.add(true);
  }
  return initialItemState;
}

List<String> abraCards() {
  return [
    'assets/coping_game/abra/abra_atsuete.png',
    'assets/coping_game/abra/abra_atsuete.png',
    'assets/coping_game/abra/abra_bangued_cathedral.png',
    'assets/coping_game/abra/abra_bangued_cathedral.png',
    'assets/coping_game/abra/abra_barkilya.png',
    'assets/coping_game/abra/abra_barkilya.png',
    'assets/coping_game/abra/abra_kalaleng.png',
    'assets/coping_game/abra/abra_kalaleng.png',
    'assets/coping_game/abra/abra_lalabayan.png',
    'assets/coping_game/abra/abra_lalabayan.png',
    'assets/coping_game/abra/abra_suyod.png',
    'assets/coping_game/abra/abra_suyod.png',
    'assets/coping_game/abra/abra_tabungaw_hats.png',
    'assets/coping_game/abra/abra_tabungaw_hats.png',
    'assets/coping_game/abra/abra_talisay.png',
    'assets/coping_game/abra/abra_talisay.png'
  ];
}

List<String> abraDialogues() {
  return [
    'Depression is a mood disorder, which is a type of mental illness. Mood disorders occur when mood swings go beyond the regular ups and downs that everyone goes through on a daily basis.',
    'Changes in the brain may cause depression. It can either be triggered by a history of depression in your family, or the introduction of stressors in your life.',
    'Depression can be classified into different types. Some examples include Major Depressive Disorder (MDD), Persistent Depressive Disorder (PDD), Postpartum depression, and others.',
    'Being sad is often mistaken as depression. However, depression also has other symptoms that need clinical diagnosis and treatment.',
    'Traumatic and stressful experiences can also be a cause of depression. Some examples of these experiences may include bullying, losing a loved one, or near-death situations.',
    'Depression is treatable and you can seek help from medical professionals. Also, there are a lot of self-help methods that are available that you can do at home.',
    'The timetable of depression varies from person to person. Some episodes can last at least two weeks while some can go for months or even years.',
    'Major depressive disorder (MDD) is the most common type of depression. People with MDD experience symptoms almost the whole day, nearly every day.',
  ];
}

List<String> apayaoCards() {
  return [
    'assets/coping_game/apayao/apayao_aliwa.png',
    'assets/coping_game/apayao/apayao_aliwa.png',
    'assets/coping_game/apayao/apayao_isnag_abag.png',
    'assets/coping_game/apayao/apayao_isnag_abag.png',
    'assets/coping_game/apayao/apayao_mataguisi_church_ruins.png',
    'assets/coping_game/apayao/apayao_mataguisi_church_ruins.png',
    'assets/coping_game/apayao/apayao_pas-ing.png',
    'assets/coping_game/apayao/apayao_pas-ing.png',
    'assets/coping_game/apayao/apayao_pottery1.png',
    'assets/coping_game/apayao/apayao_pottery1.png',
    'assets/coping_game/apayao/apayao_pottery2.png',
    'assets/coping_game/apayao/apayao_pottery2.png',
    'assets/coping_game/apayao/apayao_sinibalu.png',
    'assets/coping_game/apayao/apayao_sinibalu.png',
    'assets/coping_game/apayao/apayao_sipattal.png',
    'assets/coping_game/apayao/apayao_sipattal.png'
  ];
}

List<String> apayaoDialogues() {
  return [
    'Mental Illnesses are brain-based conditions that affect thinking, emotions, and behaviors.',
    'We all experience ups and downs in our physical health. Some days you might feel a little sore, or tired, or sniffly. Something suddenly changes for the worse or Something prevents you from functioning properly.',
    'Most mental illnesses don’t have a single cause. Instead they have a variety of causes, called risk factors.',
    'These risk factors don’t just affect who will develop a mental illness in the first place. They also affect how severe their symptoms will be, and when they will experience those symptoms.',
    'Some therapists actually prefer not to diagnose their clients. And even people who don’t have a mental illness can benefit from therapy or other mental health treatments.',
    'When you’re at your lowest point, it’s hard to imagine ever feeling better. Sometimes you might not even remember what life was like before you started experiencing the signs of mental illness.',
    'People’s experiences vary. Some struggle for a little while and then never experience symptoms of mental illness again. Others struggle off and on throughout their lives. ',
    'If you think you’re experiencing a mental illness, try to find any kind of support earlier than later. Like other illnesses, treating mental illnesses early can help you get better faster.'
  ];
}

List<String> benguetCards() {
  return [
    'assets/coping_game/benguet/benguet_bark_beater.png',
    'assets/coping_game/benguet/benguet_bark_beater.png',
    'assets/coping_game/benguet/benguet_kalasag.png',
    'assets/coping_game/benguet/benguet_kalasag.png',
    'assets/coping_game/benguet/benguet_kalsa.png',
    'assets/coping_game/benguet/benguet_kalsa.png',
    'assets/coping_game/benguet/benguet_kayabang_basket.png',
    'assets/coping_game/benguet/benguet_kayabang_basket.png',
    'assets/coping_game/benguet/benguet_kiyag.png',
    'assets/coping_game/benguet/benguet_kiyag.png',
    'assets/coping_game/benguet/benguet_lions_head.png',
    'assets/coping_game/benguet/benguet_lions_head.png',
    'assets/coping_game/benguet/benguet_obukay.png',
    'assets/coping_game/benguet/benguet_obukay.png',
    'assets/coping_game/benguet/benguet_solibao.png',
    'assets/coping_game/benguet/benguet_solibao.png'
  ];
}

List<String> benguetDialogues() {
  return [
    'Anxiety is an emotion that you feel when you’re worried about something.When anxiety gets out of hand and it starts to interfere with your daily life, you might have an anxiety disorder.',
    'Anxiety disorders are so common, we know a lot about them. Living with anxiety is a challenge, but it can be treated.',
    'Everybody is anxious at times. But there’s a difference between the normal stress, worry, and tension we experience as humans, and a diagnosable anxiety disorder.',
    'Generalized Anxiety Disorder is the most common anxiety disorder and is probably what most people think about when they think about having an “anxiety disorder” as a diagnosis.',
    'People with panic disorder experience panic attacks, which come on fast and hard.',
    'Other types of  anxiety disorders include separation anxiety or anxiety disorder due to another medical condition.',
    'Living in a stressful environment makes anxiety more likely. Things like living in poverty or having an abusive family put a lot of stress on your brain.',
    'Even if you’re no longer in a stressful environment, things that happened to you as a child can have an impact later in life.'
  ];
}

List<String> ifugaoCards() {
  return [
    'assets/coping_game/ifugao/ifugao_balul.png',
    'assets/coping_game/ifugao/ifugao_balul.png',
    'assets/coping_game/ifugao/ifugao_bangibang.png',
    'assets/coping_game/ifugao/ifugao_bangibang.png',
    'assets/coping_game/ifugao/ifugao_dinumog.png',
    'assets/coping_game/ifugao/ifugao_dinumog.png',
    'assets/coping_game/ifugao/ifugao_giniling_and_padang.png',
    'assets/coping_game/ifugao/ifugao_giniling_and_padang.png',
    'assets/coping_game/ifugao/ifugao_hiwang.png',
    'assets/coping_game/ifugao/ifugao_hiwang.png',
    'assets/coping_game/ifugao/ifugao_punamhan.png',
    'assets/coping_game/ifugao/ifugao_punamhan.png',
    'assets/coping_game/ifugao/ifugao_tobayan.png',
    'assets/coping_game/ifugao/ifugao_tobayan.png',
    'assets/coping_game/ifugao/ifugao_warangan.png',
    'assets/coping_game/ifugao/ifugao_warangan.png'
  ];
}

List<String> ifugaoDialogues() {
  return [
    'The average person approximately spends 6 and a half years of their life worrying.',
    'Anxiety comes from the Greek word “angh” which means to ‘press tight or to strangle’.',
    'Anxiety Disorders may make an individual anxious most of the time for no specific reason.',
    'Among all mental health disorders, Anxiety related disorders prove to be the most common.',
    'Always remember that feeling anxious is not your fault but rather it is a serious mood disorder that affects the lifestyle of an individual.',
    'A family’s history and genetics contribute to greater chances for an individual to get an anxiety disorder throughout their lifetime.',
    'On top of increasing stress levels, having an inadequate coping mechanism to manage the stress also greatly contributes to anxiety.',
    'Dialogue 8'
  ];
}

List<String> kalingaCards() {
  return [
    'assets/coping_game/kalinga/kalinga_bamboo_container.png',
    'assets/coping_game/kalinga/kalinga_bamboo_container.png',
    'assets/coping_game/kalinga/kalinga_baskets_labba.png',
    'assets/coping_game/kalinga/kalinga_baskets_labba.png',
    'assets/coping_game/kalinga/kalinga_bungkaka.png',
    'assets/coping_game/kalinga/kalinga_bungkaka.png',
    'assets/coping_game/kalinga/kalinga_ceramics.png',
    'assets/coping_game/kalinga/kalinga_ceramics.png',
    'assets/coping_game/kalinga/kalinga_ceramics2.png',
    'assets/coping_game/kalinga/kalinga_ceramics2.png',
    'assets/coping_game/kalinga/kalinga_earrings.png',
    'assets/coping_game/kalinga/kalinga_earrings.png',
    'assets/coping_game/kalinga/kalinga_tattoo_patterns.png',
    'assets/coping_game/kalinga/kalinga_tattoo_patterns.png',
    'assets/coping_game/kalinga/kalinga_tongatong.png',
    'assets/coping_game/kalinga/kalinga_tongatong.png'
  ];
}

List<String> kalingaDialogues() {
  return [
    'The brains of people who suffer from mental illnesses have a difference that sometimes makes them unable to think, feel or act in the way they want to.',
    'Mental Illnesses are related to problems that start in our brains compared to other general physical illnesses.',
    'To be diagnosed with a mental illness, negative changes in your thinking and emotions must seriously affect your ability to accomplish things you want to do (Pervasive) and the thoughts stick around longer (Persistent).',
    'The occurrence of mental illness is more prominent among women, people of color and people among the LGBTQ+ Community.',
    "A lot of people who experience mental illnesses, do not receive the proper treatment or don't get treatment at all.",
    'Many people are unaware that they have a mental illness. It may take years before they even get diagnosed.',
    'Having a mental illness is not your fault. Nobody deserves to have a mental illness, it just happens and usually without a single cause.',
    'Mental Illness is caused by a variety of risk factors like Genetics, Environment, trauma, etc. These risk factors don’t just affect who develops a mental illness but also affects the severity of their symptoms.'
  ];
}

List<String> mtProvinceCards() {
  return [
    'assets/coping_game/mountain_province/MtProvince_Belt.png',
    'assets/coping_game/mountain_province/MtProvince_Belt.png',
    'assets/coping_game/mountain_province/MtProvince_Buaya.png',
    'assets/coping_game/mountain_province/MtProvince_Buaya.png',
    'assets/coping_game/mountain_province/MtProvince_Diwidiwas.png',
    'assets/coping_game/mountain_province/MtProvince_Diwidiwas.png',
    'assets/coping_game/mountain_province/MtProvince_Gimata.png',
    'assets/coping_game/mountain_province/MtProvince_Gimata.png',
    'assets/coping_game/mountain_province/MtProvince_Kaob.png',
    'assets/coping_game/mountain_province/MtProvince_Kaob.png',
    'assets/coping_game/mountain_province/MtProvince_Lusong.png',
    'assets/coping_game/mountain_province/MtProvince_Lusong.png',
    'assets/coping_game/mountain_province/MtProvince_Saong.png',
    'assets/coping_game/mountain_province/MtProvince_Saong.png',
    'assets/coping_game/mountain_province/MtProvince_Sikwan.png',
    'assets/coping_game/mountain_province/MtProvince_Sikwan.png'
  ];
}

List<String> mtProvDialogues() {
  return [
    'Depression is treatable, you must not just sit around and wait for it to go away on its own. You can seek professional help from a doctor or therapist, or you can work on your mental health on your own.',
    'There are a lot of things that can help to treat your depression such as lifestyle changes, therapy, support, medication, and device-based treatments.',
    "When dealing with negative thoughts, you shouldn't hide your feelings, talk it out, think of a time when you felt better, identify where your expectations are coming from, and try to make peace with being a normal person, who is good at some things and bad at others.",
    'Everyone is different but people can recover from depression with lifestyle changes, support groups, medications, and therapy.',
    'Antidepressants are mostly medications that can be used to treat depression. There are different types and each of them works on different chemicals and affects them differently.',
    'There is no immediate fix, it’s important to give things time to work. People can live full and healthy lives even with depression, with the right combination of support.',
    'Depression is hard to fight. Your brain is a muscle and just like the other muscles, getting better takes time.',
    'Depression, it’s scary to share something especially if it’s very personal, however many people can understand it and it can make you feel not alone anymore.'
  ];
}

List<String> getDialogue(Province province) {
  List<String> dialogueList = <String>[];
  List dialogueSource;
  if (province == Province.Abra) {
    dialogueSource = abraDialogues();
    for (var element in dialogueSource) {
      dialogueList.add(element);
    }
  } else if (province == Province.Apayao) {
    dialogueSource = apayaoDialogues();
    for (var element in dialogueSource) {
      dialogueList.add(element);
    }
  } else if (province == Province.Benguet) {
    dialogueSource = benguetDialogues();
    for (var element in dialogueSource) {
      dialogueList.add(element);
    }
  } else if (province == Province.Ifugao) {
    dialogueSource = ifugaoDialogues();
    for (var element in dialogueSource) {
      dialogueList.add(element);
    }
  } else if (province == Province.Kalinga) {
    dialogueSource = kalingaDialogues();
    for (var element in dialogueSource) {
      dialogueList.add(element);
    }
  } else {
    dialogueSource = mtProvDialogues();
    for (var element in dialogueSource) {
      dialogueList.add(element);
    }
  }
  return dialogueList;
}
