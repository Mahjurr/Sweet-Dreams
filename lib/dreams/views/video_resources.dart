import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/rounded_button.dart';
import '../utils/app_colors.dart' as AppColors;

class VideoScreen extends StatefulWidget {
  @override
  _VideoResourcesState createState() => _VideoResourcesState();
}

class _VideoResourcesState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Sleep Tips and Techniques"),
        ),
        backgroundColor: AppColors.darkBackground,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RoundedButton(
                    colour: AppColors.textField,
                    title: 'TED: Sleeping with Science',
                    onPressed: _TEDlaunchURL
                    ),
                RoundedButton(
                    colour: AppColors.textField,
                    title: 'Mayo Clinic Sleep Tips',
                    onPressed: _MayolaunchURL
                    ),
                RoundedButton(
                    colour: AppColors.textField,
                    title: 'Progressive Muscle Relaxation',
                    onPressed: _PMRlaunchURL
                    ),
                RoundedButton(
                    colour: AppColors.textField,
                    title: 'Autogenic Training',
                    onPressed: _ATlaunchURL
                    ),
                RoundedButton(
                    colour: AppColors.textField,
                    title: '4-7-8 Breathing',
                    onPressed: _FSElaunchURL
                    ),
              ]),
        ));
  }
}

// ignore: non_constant_identifier_names
_TEDlaunchURL() async {
  const urlTED = 'https://www.youtube.com/watch?v=t0kACis_dJE';
  if (await canLaunch(urlTED))
   {print("launching $urlTED");
    await launch(urlTED);}
  else {throw 'Could not launch maps';}
}

// ignore: non_constant_identifier_names
_MayolaunchURL() async {
  const urlMayo = 'https://www.youtube.com/watch?v=s2lwUIKsRWg';
  if (await canLaunch(urlMayo))
  {print("launching $urlMayo");
  await launch(urlMayo);}
  else {throw 'Could not launch maps';}
}

// ignore: non_constant_identifier_names
_PMRlaunchURL() async {
  const urlPMR = 'https://www.youtube.com/watch?v=MGxk12mI4t8';
  if (await canLaunch(urlPMR))
  {print("launching $urlPMR");
  await launch(urlPMR);}
  else {throw 'Could not launch maps';}
}

// ignore: non_constant_identifier_names
_ATlaunchURL() async {
    const urlAT = 'https://www.youtube.com/watch?v=DgykgvAFf8I';
    if (await canLaunch(urlAT))
    {print("launching $urlAT");
  await launch(urlAT);}
  else {throw 'Could not launch maps';}
}

// ignore: non_constant_identifier_names
_FSElaunchURL() async {
  const urlFSE = 'https://www.youtube.com/watch?v=kpSkoXRrZnE';
  if (await canLaunch(urlFSE))
  {print("launching $urlFSE");
  await launch(urlFSE);}
  else {throw 'Could not launch maps';}
}
