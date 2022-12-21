import 'package:corona_app/view/worldState.dart';
import 'package:flutter/material.dart';

class ScreenDetails extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalRecoverd,
      totalDeaths,
      totalActive,
      totalCritical,
      todayRecovery,
      test;
  ScreenDetails({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalRecoverd,
    required this.totalActive,
    required this.totalCritical,
    required this.totalDeaths,
    required this.todayRecovery,
    required this.test,
  });

  //const ScreenDetails({Key? key}) : super(key: key);

  @override
  _ScreenDetailsState createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        //elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      ReuseableRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReuseableRow(
                          title: 'Total Recovered',
                          value: widget.totalRecoverd.toString()),
                      ReuseableRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString()),
                      ReuseableRow(
                          title: 'Critical',
                          value: widget.totalCritical.toString()),
                      ReuseableRow(
                          title: 'Active',
                          value: widget.totalActive.toString()),
                      ReuseableRow(
                          title: 'Today Recovery',
                          value: widget.todayRecovery.toString()),
                      ReuseableRow(
                          title: 'Tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      )),
    );
  }
}
