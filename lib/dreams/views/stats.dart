import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import '../utils/dreams_firebase.dart';
import '../utils/app_colors.dart' as AppColors;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

class Stats extends StatefulWidget {
  final String? documentId = currentUser?.email;
  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<AppUsageInfo> _infos = [];
  Timer? timer;
  late double totalScreenTime;
  @override
  initState() {
    pushScreenTime();
    super.initState();
    //timer =
    //Timer.periodic(Duration(seconds: 10), (timer) async {
    //getTotalScreenTime();
    //);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      //DateTime startDate =
      //new DateTime(endDate.year, endDate.month, endDate.day);
      List<AppUsageInfo> infoList =
          await AppUsage.getAppUsage(startDate, endDate);
      setState(() {
        _infos = infoList;
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  Future<double> getTotalScreenTime() async {
    double time = 0;
    await getUsageStats();
    for (AppUsageInfo i in _infos) {
      time += i.usage.inSeconds;
    }
    setState(() {
      totalScreenTime = roundDouble(time / 60 / 60);
    });
    return totalScreenTime;
  }

  Future<void> pushScreenTime() async {
    double screenTime = await getTotalScreenTime();
    addDataToDate("screenTime", screenTime);
  }

  double roundDouble(double value) {
    return ((value * 1000).round().toDouble() / 1000);
  }

  List<_ChartData> populateData(
      Map<int, QueryDocumentSnapshot<Object?>> data) {
    List<_ChartData> time = [];
    data.forEach((key, value) {

      var dat = value.data() as Map<String, dynamic>;
      double screenTime = dat["screenTime"];
      num sleepTimeInHours = 0.0;
      if(dat["SleepTimeInHours"] != null){
        sleepTimeInHours = dat["SleepTimeInHours"];
      }

      DateTime date = convertDateToDateTime(dat['date']);

      //highlight the current day
      Color color = AppColors.darkAccent;
      var curdate = DateTime.now();
      if (date.year == curdate.year && date.day == curdate.day && date.month == curdate.month){
        color =  AppColors.lightAccent;
      }

      time.add(_ChartData(dateTimeToWeekday(date), screenTime, sleepTimeInHours,  color));
    });
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
        body: FutureBuilder<QuerySnapshot>(
            future: getDataFromDate(DateTime.now().subtract(Duration(days: 7))),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              List<Widget> children;

              if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Something went wrong'),
                  )
                ];
              }
              if (snapshot.hasData) {
                var data = snapshot.data!.docs.asMap();
                var screenTimeList = populateData(data);
                //Map<int, dynamic> data = snapshot.data!.docs.asMap();
                //print(data);
                //List<_ScreenTimeData> screenTimeList = populateData(data);
                //print(screenTimeList);

                children = <Widget>[
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        borderColor: Colors.white,
                      ),
                      // Chart title
                      title: ChartTitle(
                          text: 'Screen Time Past Week',
                        textStyle: TextStyle(
                          color: Colors.white
                        )
                      ),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_ChartData, String>>[
                        ColumnSeries<_ChartData, String>(
                            dataSource: screenTimeList,
                            xValueMapper: (_ChartData Screentime, _) =>
                                Screentime.weekday,
                            yValueMapper: (_ChartData Screentime, _) =>
                                Screentime.screenTime,
                            pointColorMapper: (_ChartData Screentime, _) =>
                                Screentime.color,
                            name: 'Screen Time',
                            dataLabelSettings:
                                DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        color: Colors.white
                                    )
                                )
                        )
                      ]),
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        borderColor: Colors.white,
                      ),
                      // Chart title
                      title: ChartTitle(text: 'Sleep Hours Past Week',
                          textStyle: TextStyle(
                              color: Colors.white
                          )
                      ),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_ChartData, String>>[
                        ColumnSeries<_ChartData, String>(
                            dataSource: screenTimeList,
                            xValueMapper: (_ChartData Screentime, _) =>
                            Screentime.weekday,
                            yValueMapper: (_ChartData Screentime, _) =>
                            Screentime.sleepTime,
                            pointColorMapper: (_ChartData Screentime, _) =>
                            Screentime.color,
                            name: 'Sleep Hours',
                            dataLabelSettings:
                            DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(
                                    color: Colors.white
                                )
                            )
                        )
                      ]),
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                ),
              );
            }));
  }
}

class _ChartData {
  _ChartData(this.weekday, this.screenTime, this.sleepTime, this.color);
  @override
  String toString() {
    return "ScreenTimeData : {weekday: $weekday, screenTime: $screenTime}";
  }

  final String weekday;
  final double screenTime;
  final Color color;
  final num sleepTime;
}
