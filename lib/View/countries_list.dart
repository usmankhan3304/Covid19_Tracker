import 'package:covid_api/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/states.services.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textEditingController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: "Search with country name",
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesServices.countriesData(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                  child: Column(
                                    children: [
                                      ListTile(
                                          title: Container(
                                            height: 10,
                                            width: 80,
                                            color: Colors.white,
                                          ),
                                          subtitle: Container(
                                            height: 10,
                                            width: 80,
                                            color: Colors.white,
                                          ),
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ));
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = (snapshot.data![index]['country']);
                              if (textEditingController.text.isEmpty) {
                                return InkWell(
                                  onTap: () {Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => DetailsScreen(
                                          image: snapshot.data![index]['countryInfo']['flag'].toString(),
                                          name: snapshot.data![index]['country'].toString(),
                                          totalcase:snapshot.data![index]['cases'],
                                          totalDeath: snapshot.data![index]['recovered'],
                                          totalRecovered: snapshot.data![index]['deaths'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          active: snapshot.data![index]['active'],
                                          critical:snapshot.data![index]['critical'],
                                          test: snapshot.data![index]['active'],
                                      )));
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(snapshot.data![index]
                                                ['country']
                                            .toString()),
                                        subtitle: Text("Cases:" +
                                            snapshot.data![index]['cases']
                                                .toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (name.toLowerCase().contains(
                                  textEditingController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(snapshot.data![index]
                                              ['country']
                                          .toString()),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index]['country']
                                        .toString()),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  ),
                                ],
                              );
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
