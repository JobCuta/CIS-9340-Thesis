import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/background_images/blue_background.png',
                          ),
                          fit: BoxFit.cover))),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 100, 25, 0),
                    child: Container(

                        alignment: Alignment.center,
                        height: 100,
                        padding:
                        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                        decoration: BoxDecoration(
                            color: const Color(0xff3290FF).withOpacity(0.60),
                            borderRadius: const BorderRadius.all(Radius.circular(4))),
                        child: Column(
                            children: [
                              const Text('Welcome!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w600)
                              ),

                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                                decoration: BoxDecoration(
                                    color: const Color(0x216CB2).withOpacity(0.20),
                                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                                child: const Text('Remember, all is well and all will be well.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Proxima Nova',
                                        fontWeight: FontWeight.w400)
                                ),
                              )
                            ]
                        )
                    ),
                  ),

                  const SizedBox(height: 50.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your dailies for today',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0x4ca7fc).withOpacity(1.0),
                                  fontSize: 20,
                                  fontFamily: 'Proxima Nova',
                                  fontWeight: FontWeight.w600)
                          ),

                          const SizedBox(height: 10.0),

                          Text('Start your journey to wellness!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0x161818).withOpacity(1.0),
                                  fontSize: 14,
                                  fontFamily: 'Proxima Nova',
                                  fontWeight: FontWeight.w400)
                          ),

                          const Divider(
                            color: Color(0xffF0F1F1),
                            height: 25,
                            thickness: 1,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Do your daily exercise',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0x161818).withOpacity(1.0),
                                      fontSize: 16,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w400)
                              ),

                              Text('Go',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xACB2B4).withOpacity(1.0),
                                      fontSize: 16,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w400)
                              ),
                            ],
                          ),

                          const Divider(
                            color: Color(0xffF0F1F1),
                            height: 25,
                            thickness: 1,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Add today's entry",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0x161818).withOpacity(1.0),
                                      fontSize: 16,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w400)
                              ),

                              TextButton(
                                onPressed: () {Get.toNamed('/emotionStartScreen');},
                                child: Text('Go',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xACB2B4).withOpacity(1.0),
                                      fontSize: 16,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w400)
                              )),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: () {
                      Get.toNamed('/shakeScreen', arguments: {'initial?': false});
                    },
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(290, 15, 0, 0),
                        child: SvgPicture.asset(
                          'assets/images/meditating.svg',
                          height: 95,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFC122).withOpacity(0.60),
                        ),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.vertical,
                          children: [
                            const Text('Daily Wellness Exercise',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'Proxima Nova')),
                            Text('Keep your mind and body in shape!',
                                style: Theme.of(context).textTheme.bodyText2?.apply(
                                    color: Colors.white, fontFamily: 'Proxima Nova'))
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ]),
        bottomSheet: bottomNavigationBar(),
    );
  }

  Container bottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(76, 167, 252, 1.0),
      ),
      child: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(76, 167, 252, 1.0),
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Icon(Icons.notes),
            ),
            label: 'Entries',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Icon(Icons.calendar_today_outlined),
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 10.0), child: Icon(Icons.home),
              ),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 10.0), child: Icon(Icons.directions_walk),
              ),
              label: 'Adventure Mode'
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10.0), child: Icon(Icons.widgets_outlined),
            ),
            label: 'Mini-games',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromRGBO(33, 108, 178, 1.0),
        iconSize: 32.0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Proxima Nova',
            fontSize: 8.0,
            fontWeight: FontWeight.bold
        ),
        unselectedLabelStyle: const TextStyle(
            fontFamily: 'Proxima Nova',
            fontSize: 8.0,
            fontWeight: FontWeight.bold
        ),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}