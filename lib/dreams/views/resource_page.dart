import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/rounded_button.dart';
import '../presenter/dreams_presenter.dart';
import '../utils/dreams_utils.dart';
import '../utils/app_colors.dart' as AppColors;




class ResourcesPage extends StatefulWidget {
  final UNITSPresenter presenter;

  ResourcesPage (this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(100, 56),
          child: Hero(
            tag: 'appBar',
            child: AppBar(
              title: Text("Resources"), 
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      backgroundColor: AppColors.darkBackground,
      resizeToAvoidBottomInset: true,


      body: Center(
        child: ListView(
          shrinkWrap: true,

          children: <Widget>[

            new Container(
              margin: EdgeInsets.all(30.0),
              child: new Card(
                color: Colors.transparent,
                elevation: 400.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset("lib/assests/images/Headspace.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                          child: new Text('Headspace',
                            style: TextStyle(
                                color: colorStyle("main"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          onTap: () => launch('https://www.headspace.com/meditation/sleep')
                      ),
                    ),
                    Text('Healthy sleep has more to do with quality of rest than quantity of hours. Sleep meditations help create the inner conditions needed for a truly restful night. Because when we settle the mind, we rest the body — and that restfulness is what makes it easier to wind down and drift off. Here is a link with exercises and tips that will help you with sleep ',
                      style: TextStyle(
                          color: colorStyle("main"),
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),


            new Container(
              margin: EdgeInsets.all(30.0),
              child: new Card(
                color: Colors.transparent,
                elevation: 400.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset("lib/assests/images/NSF.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                          child: new Text('National Sleep Foundation',
                            style: TextStyle(
                                color: colorStyle("main"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          onTap: () => launch('https://www.sleepfoundation.org/sleep-hygiene/healthy-sleep-tips')
                      ),
                    ),
                    Text('It’s well-established that sleep is essential to our physical and mental health. But despite its importance, a troubling percentage of people find themselves regularly deprived of quality sleep and are notably sleepy during the day. So here is a link to the National Sleep Foundation website that has healthy sleeping tips for you to take advantage of.',
                      style: TextStyle(
                          color: colorStyle("main"),
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),

            new Container(
              margin: EdgeInsets.all(30.0),
              child: new Card(
                color: Colors.transparent,
                elevation: 400.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset("lib/assests/images/AASM.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                          child: new Text('American Academy of Sleep Medicine',
                            style: TextStyle(
                                color: colorStyle("main"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          onTap: () => launch('https://sleepeducation.org/sleep-disorders/')
                      ),
                    ),
                    Text('There are a variety of sleep disorders. Some are common, like insomnia, while others are rare. About 70 million people experience sleep disorders each year. Practice healthy sleep habits to promote restful sleep every night, and talk to your doctor if your sleep problem persists. By clicking on this link, you will be provided with information on the different sleep disorders that exist.',
                      style: TextStyle(
                          color: colorStyle("main"),
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),

            new Container(
              margin: EdgeInsets.all(30.0),
              child: new Card(
                color: Colors.transparent,
                elevation: 400.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset("lib/assests/images/SRS.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                          child: new Text('Sleep Research Society',
                            style: TextStyle(
                                color: colorStyle("main"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          onTap: () => launch('https://sleepresearchsociety.org/')
                      ),
                    ),
                    Text('In 1961, a small group of researchers founded what eventually became the Sleep Research Society (SRS). Since then, membership has grown to all levels and disciplines in sleep and circadian science across the globe.This link will allow you to provide information towards their research, as well as information on sleeping submitted by others around the world for you to learn more about.',
                      style: TextStyle(
                          color: colorStyle("main"),
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),

            new Container(
              margin: EdgeInsets.all(30.0),
              child: new Card(
                color: Colors.transparent,
                elevation: 400.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset("lib/assests/images/CDC.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                          child: new Text('Centers for Disease Control and Prevention',
                            style: TextStyle(
                                color: colorStyle("main"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          onTap: () => launch('https://www.cdc.gov/sleep/resources.html')
                      ),
                    ),
                    Text('The Centers for Disease Control and Prevention is the national public health agency of the United States. It is a United States federal agency, under the Department of Health and Human Services. This link will take you to resources that the CDC gathered and provided for others to learn from/take advantage of.',
                      style: TextStyle(
                          color: colorStyle("main"),
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),

            new Container(
              margin: EdgeInsets.all(30.0),
              child: new Card(
                color: Colors.transparent,
                elevation: 400.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset("lib/assests/images/Narcolepsy Network.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                          child: new Text('Narcolepsy Network',
                            style: TextStyle(
                                color: colorStyle("main"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          onTap: () => launch('https://narcolepsynetwork.org/')
                      ),
                    ),
                    Text('Narcolepsy is a medical disorder that impacts 1 in approximately 2,000 people in the United States of America. The disease is a sleep disorder, involving irregular patterns in Rapid Eye Movement (REM) Sleep and significant disruptions of the normal sleep/wake cycle. While the cause of narcolepsy is not completely understood, current research points to a combination of genetic and environmental factors that influence the immune system. Here is a link that will provide you with information about Narcolepsy',
                      style: TextStyle(
                          color: colorStyle("main"),
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),

            new Container(
              margin: EdgeInsets.all(30.0),
              child: new Card(
                color: Colors.transparent,
                elevation: 400.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset("lib/assests/images/Mayo Clinic.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                          child: new Text('Mayo Clinic',
                            style: TextStyle(
                                color: colorStyle("main"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          onTap: () => launch('https://www.mayoclinic.org/diseases-conditions/insomnia/symptoms-causes/syc-20355167')
                      ),
                    ),
                    Text('Insomnia is a common sleep disorder that can make it hard to fall asleep, hard to stay asleep, or cause you to wake up too early and not be able to get back to sleep. You may still feel tired when you wake up. Insomnia can sap not only your energy level and mood but also your health, work performance and quality of life. Here is a link that will provide you more information on Insomnia, as well as ways to help insomnia from happening by the Mayo Clinic.',
                      style: TextStyle(
                          color: colorStyle("main"),
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),

            new Container(
              margin: EdgeInsets.all(30.0),
              child: new Card(
                color: Colors.transparent,
                elevation: 400.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset("lib/assests/images/UMD Health Services.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                          child: new Text('University of Minnesota Duluth Health Services',
                            style: TextStyle(
                                color: colorStyle("main"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          onTap: () => launch('https://health-services.d.umn.edu/health-education/sleep-education-initiatives')
                      ),
                    ),
                    Text('Physicians, nurse practitioners, and registered nurses are available for medical appointments.  If you are taking 6+ credits, your medical consultations are free of charge. UMD Health Services also provides free and confidential counseling, drop-in Consultations ("Lets Talk") and grief support groups. Here is a link that will take you to all of that information.',
                      style: TextStyle(
                          color: colorStyle("main"),
                          fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),

            RoundedButton(
              colour: AppColors.textField,
              title: 'Video Resources',
              onPressed: () {
                Navigator.pushNamed(context, 'video_resources');
              },
            ),

          ],
        ),
      ),
    );

  }
}
