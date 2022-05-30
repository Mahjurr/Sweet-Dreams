import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/rounded_button.dart';
import '../utils/dreams_firebase.dart';
import '../utils/app_colors.dart' as AppColors;

class CountdownPage extends StatefulWidget {
  @override
  _CountdownPageState createState() => _CountdownPageState();
}
class _CountdownPageState extends State<CountdownPage> {
  static const countdownDuration = Duration(seconds:10);
  Duration duration = Duration();
  Timer? timer;
  bool isCountDown = false;

  @override
  void initState() {
    super.initState();
    reset();
  }

  double secondsToHours(String time){
    double timeToDouble = double.parse(time);
    double totalTime = timeToDouble/60/60;
    return totalTime;
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void reset() {
    if(isCountDown){
      setState(()=>duration = countdownDuration);
    }
    else{
      setState(() => duration = Duration());
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  void startTimer({bool resets = true}) {
    if(resets){
      reset();
  }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              buildTime(),
              const SizedBox(height: 80),
              buildButtons(),
            ],
        ),
      ),
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedButton(
          title: isRunning ? 'STOP' : 'RESUME',
          onPressed: () {
            if(isRunning){
              stopTimer(resets:false);
            }
            else{
              startTimer(resets: false);
            }
          }, colour: AppColors.textField,
        ),
        const SizedBox(width: 8),
        RoundedButton(
          title: 'RESET',
          onPressed: () {
            addDataToDate("SleepTimeInHours",secondsToHours(duration.inSeconds.toString()));
            stopTimer();
          }, colour: AppColors.textField,
        ),
      ],
    )
        :
    RoundedButton(
      title: 'Start Timer',
      onPressed: () {
        startTimer();
      }, colour: AppColors.textField,
    );
  }


  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours.remainder(60));
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimeCard(time: hours, header: 'Hours'),
          const SizedBox(width: 8),
          buildTimeCard(time: minutes, header: 'Minutes'),
          const SizedBox(width: 8),
          buildTimeCard(time: seconds, header: 'Seconds'),
          const SizedBox(width: 8)
        ]
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.textField,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                  time,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                      fontSize: 72
                  )

              ),
            ),
            const SizedBox(height: 24),
            Text(
                header,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textFieldText,
      )
            ),
          ]
      );


}


