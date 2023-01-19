
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Model/ApiModel.dart';
import '../Services/states.services.dart';
import 'countries_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds: 5), vsync: this)
    ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    Color(0xff348ab4),
    Color(0xff1aa260),
    Color(0xffde5246),
    //Color(0xFFE91E63),
  ];
  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();
    print(statesServices.data);
    var _mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("world Covid-19 States"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future: statesServices.fetchData(),
                    builder: (context, AsyncSnapshot<ApiModel> snapshot) {
                      final result= snapshot.data!;
                      if (!snapshot.hasData) {
                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(result.cases.toString()),
                                "Recovered": double.parse(result.recovered.toString()),
                                "Deaths": double.parse(result.deaths.toString()),
                                //  "Upadted": double.parse(result.updated.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorlist,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: _mediaquery.height * .03),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: "Total", value: result.cases.toString()),
                                    ReusableRow(title: "Recovered", value: result.recovered.toString()),
                                    ReusableRow(title: "Death", value: result.deaths.toString()),
                                    ReusableRow(title: "Updated", value: result.updated.toString()),
                                    ReusableRow(title: "Critical", value: result.critical),

                                    ReusableRow(title: "Today Recovered", value: result.todayRecovered),

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesList()));
                            },

                              child: Container(
                                height: _mediaquery.height * .05,
                                //height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(child: Text("Track Country")),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value.toString()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
        ],
      ),
    );
  }
}
