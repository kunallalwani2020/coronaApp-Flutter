import 'package:corona_app/model/78_affected_countries_230.dart';
import 'package:corona_app/services/state_services.dart';
import 'package:corona_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  _WorldStateState createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color.fromRGBO(76, 175, 80, 1),
    const Color(0xffd32f2f),
  ];

  // final colorList = <Color>[
  //   const Color(0xfffdcb6e),
  //   const Color(0xff0984e3),
  //   const Color(0xfffd79a8),
  //   const Color(0xffe17055),
  //   const Color(0xff6c5ce7),
  // ];

  @override
  Widget build(BuildContext context) {
    StateService stateService = StateService();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: stateService.fetchWorldStateData(),
                builder: (context, AsyncSnapshot<worldStatemodel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                ReuseableRow(
                                    title: "Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                ReuseableRow(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                ReuseableRow(
                                    title: "Active",
                                    value: snapshot.data!.active.toString()),
                                ReuseableRow(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                ReuseableRow(
                                    title: "Today Deaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                ReuseableRow(
                                    title: "Today Recovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(76, 175, 80, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text("Track Country"),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
