import 'package:covid_app/Service/app_theme/text_theme/text_theme.dart';
import 'package:covid_app/Service/state_services/states_services.dart';
import 'package:covid_app/view/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Country List'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 16,
            children: [
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search with country name',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesList(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          name: snapshot.data![index]['country'],
                                          image:snapshot.data![index]['countryInfo']['flag'],
                                            totalCases: snapshot.data![index]['cases'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                        snapshot.data![index]['countryInfo']
                                            ['flag'],
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data![index]["country"],
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]["cases"].toString(),
                                      style: AppText.bold16,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      name: snapshot.data![index]['country'],
                                      image:snapshot.data![index]['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalRecovered: snapshot.data![index]['recovered'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                        snapshot.data![index]['countryInfo']
                                            ['flag'],
                                      ),
                                    ),
                                    title: Text(
                                      snapshot.data![index]["country"],
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]["cases"].toString(),
                                      style: AppText.bold16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
