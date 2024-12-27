import 'package:covid_app/Model/WorldStatesModel.dart';
import 'package:covid_app/Service/state_services/states_services.dart';
import 'package:covid_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Service/app_theme/text_theme/text_theme.dart';
import '../Service/widgets/reusable_row.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final pieColorList = <Color>[
    Colors.blue,
    Colors.green,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    final mediaQuiry = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: mediaQuiry.height * .01,
                  ),
                  FutureBuilder(
                    future: statesServices.fetchWorldStateRecords(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height:
                              mediaQuiry.height * 0.7, // Ensure enough height
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50,
                              controller: _controller,
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                  snapshot.data!.cases!.toString(),
                                ),
                                "Recovered": double.parse(
                                  snapshot.data!.recovered!.toString(),
                                ),
                                "Death": double.parse(
                                  snapshot.data!.deaths!.toString(),
                                ),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartRadius: mediaQuiry.width / 2,
                              legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left,
                                legendTextStyle: AppText.bold22,
                              ),
                              colorList: pieColorList,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 32, bottom: 16.0),
                              child: Card(
                                color: Color(0xff2a2929),
                                child: Column(
                                  children: [
                                    ReusableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases!.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Death',
                                      value: snapshot.data!.deaths!.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered!.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active!.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical!.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Population',
                                      value:
                                          snapshot.data!.population!.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Affected Countries',
                                      value: snapshot.data!.affectedCountries!
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>CountriesList(),),);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Track Countries"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
