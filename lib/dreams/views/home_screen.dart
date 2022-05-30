import 'package:flutter/material.dart';
import 'package:units/dreams/services/notification_api.dart';
import 'package:units/dreams/views/stopwatch_page.dart';
import '../utils/dreams_firebase.dart';
import '../Widgets/rounded_button.dart';
import '../views/dreams_component.dart';
import '../presenter/dreams_presenter.dart';
import 'stats.dart';
import 'Log_Page.dart';
import 'media_component.dart';
import 'resource_page.dart';
import '../utils/app_colors.dart' as AppColors;
import 'calendar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    updateCurrentUser();

  }

  final screens = [
    Stats(),
    HomePage(
      new BasicPresenter(),
      title: 'Sweet Dreams',
      key: Key("CALCULATOR"),
    ),
    Home(),
    Log(),
    CountdownPage(),
  ];
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text("Sweet Dreams"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Row(children: <Widget>[
            //Text("Log Out", style: const TextStyle(fontSize: 12)),
            IconButton(
              icon: Icon(Icons.logout),
              tooltip: "Logout",
              onPressed: () {
                auth.signOut();
                Navigator.pop(context);
              },
            ),
          ])
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(                                             
        decoration: BoxDecoration(                                                   
          borderRadius: BorderRadius.only(                                           
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),            
          boxShadow: [                                                               
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),       
          ],                                                                         
        ),                                                                           
        child: ClipRRect(                                                            
          borderRadius: BorderRadius.only(                                           
            topLeft: Radius.circular(10.0),                                            
            topRight: Radius.circular(10.0),
          ),
          child: BottomNavigationBar(
            unselectedFontSize: 10,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: "Stats",
                  backgroundColor: Colors.indigo
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: "Calculator",
                backgroundColor: Colors.indigo,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.indigo,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Journal",
                backgroundColor: Colors.indigo,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.watch_later),
                label: "Stop Watch",
                backgroundColor: Colors.indigo,
              ),
            ],
          ),
        ),
      ),
    );                                                                     
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        RoundedButton(
          colour: AppColors.textField,
          title: 'Music',
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return MediaScreen();
            }));
          },
        ),
        RoundedButton(
          colour: AppColors.textField,
          title: 'Video Resources',
          onPressed: () {
            Navigator.pushNamed(context, 'video_resources');
          },
        ),  
          RoundedButton(
            colour: AppColors.textField,
            title: 'CheckList',
            onPressed: () {
              Navigator.pushNamed(context, 'CheckList');
            }
          ),
         RoundedButton(
              colour: AppColors.textField,
              title: 'Resource Page',
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ResourcePage();
                }));
              },
            ),
         RoundedButton(
          colour: AppColors.textField,
          title: 'Calendar',
          onPressed: () {
            Navigator.pushNamed(context, "Calendar");
            }
        ),
        RoundedButton(
          colour: AppColors.textField,
          title: 'Set Reminder',
          onPressed: () {
            final snackBar = SnackBar(
              content: Text(
                  'Reminders set for 8:30am & 9:30pm',
                style:TextStyle(fontSize: 24),
              ),
              backgroundColor: AppColors.lightAccent,
              );
            ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
            NotificationApi.showScheduledNotification(
              title: 'Kick Start Your Day!',
              body: 'The day has started! Time to get up and make the most of it',
              payload: 'wakeupReminder',
              scheduledDate: DateTime.now(), // DateTime.now() is set to 8:30am
            );
            NotificationApi.showScheduledNotification(
                title: 'Time for bed!',
                body: 'Get to bed on time to get every hour of sleep you can!',
                payload: 'sleepReminder',
                scheduledDate: DateTime.now().add(Duration(hours: 13)) // 8:30am + 13 hours = 9:30pm
            );
          },
        ),
      ]),
    );
  }
}

class MediaScreen extends StatefulWidget {
  @override
  _MediaScreen createState() => _MediaScreen();
}

class _MediaScreen extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    return new MediaPage(
      new MediaPresenter(),
      title: 'Media',
      key: Key("MEDIA"),
    );
  }
}

//Button Directory that leads us to the Resource Page
class ResourcePage extends StatefulWidget {
  @override
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  Widget build(BuildContext context) {
    return new ResourcesPage (new BasicPresenter(), title: 'Sweet Dreams', key: Key("UNITS"),);
  }
}
