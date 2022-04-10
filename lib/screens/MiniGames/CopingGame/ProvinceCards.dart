import 'package:flutter/material.dart';
import 'package:flutter_application_1/enums/Province.dart';

class ProvinceCards {
  AssetImage image;
  String info;
  String tipsTitle;
  String tips;

  ProvinceCards({required this.image, required this.info, required this.tipsTitle, required this.tips});
}

  Map<Province, List<ProvinceCards>> provinceCards = {
    Province.Abra: [
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_lalabayan.png'), info: 'Among the Tingguian, and their neighboring Ilocano, skeining was done using a wooden contraption called lalabayan. The size of the lalabayan enables the simultaneous skeining of multiple sets of yarn', tipsTitle: "Get some exercise", tips: 'Taking care of your physical health can also improve your mental health. Light jogging for a couple of minutes can go a long way.'),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_tabungaw_hats.png'), info: 'Made by Teofilo Garcis, a National Living Treasure Awardee from Abra who specializes in making these traditional hats that are made from gourds (upo)', tipsTitle: "Acknowledge your loneliness", tips: "The first step to change is always acknowledgement. Having a better understanding of why and how you're lonely can make the process of feeling better easier."),      
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_suyod.png'), info: 'This reed was traditionally used in pedal frame looms. The material is made of bamboo but modern versions of this object has now been using metal versions', tipsTitle: "Improve your sleeping habits", tips: "Getting the right amount of sleep works wonders on how our brains function. It prevents the build up of toxins in the brain which can result in an increased risk of depression."),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_barkilya.png'), info: 'A barkilya or a "boat shuttle" is a device used to hold the weft yarns, wound a tagintor, across the waro of a pedal frame loom', tipsTitle: "Set limits on time on news social media", tips: "Witnessing negative news can stir more negativity in your head. Better spend your time in relaxing and uplifting activities."),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_atsuete.png'), info: 'Also known as anatto is a plant that is most used as a condiment. It provides a natural food coloring and is also a source of orange dye for textiles and is also a source of red dyes once its fruit or seeds are crushed', tipsTitle: "Make Time for Self-Care", tips: 'Taking a hot bath sometimes can make you feel refreshed and valued.'),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_talisay.png'), info: 'Internationally know as the Indian Almond but locally it is called Talisay which is a large tropical tree. Aside from its seeds being edible, it is also a asource of yellow dye. Among the Tingguian tribe, this dye is used to color the threads of their woven blankets.', tipsTitle: "Explore the great outdoors", tips: "Spending some time outdoors lessens the symptoms of depression. Indulging yourself in a green environment can also improve your mood and self-esteem."),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_kalaleng.png'), info: 'The Kalaleng or also known as the bamboo nose flute is an instrument played where one nostril of the player is plugged and the air is blown from the other end of the flute. Notes are made by the fingers coveing the holes like any other flute. This instrument is most used by men.', tipsTitle: "Do things that you love", tips: "Expressing yourself through something you love doing can make you feel better. It makes you more upbeat and energetic as you do fun-filled activities."),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_bangued_cathedral.png'), info: 'This church was built in the 19th century originally by the Augustinians but it was greatly damaged during World War II when American warplanes bombed its location. The original altar was destroyed but its tower and walls stood strong. The Secular took over the church and rebuilt it right after the war ended.', tipsTitle: "Eat healthy", tips: "The things we eat can have a direct impact on what we feel or our moods. Here's a tip: foods rich in omega-3 fatty acids can boost your mood."),
    ],
  };
