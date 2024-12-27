import 'package:covid_app/Service/widgets/reusable_row.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String image;
  final int totalCases, totalDeaths, totalRecovered, active, critical;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();

  const DetailsScreen(
      {super.key, required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical});
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(

                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .067,
                        ),
                        ReusableRow(
                          title: 'Total',
                          value: widget.totalCases.toString(),
                        ),
                        ReusableRow(
                          title: 'Death',
                          value: widget.totalDeaths.toString(),
                        ),
                        ReusableRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString(),
                        ),
                        ReusableRow(
                          title: 'Active',
                          value: widget.active.toString(),
                        ),
                        ReusableRow(
                          title: 'Critical',
                          value: widget.critical.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
