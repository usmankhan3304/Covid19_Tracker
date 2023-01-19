import 'package:covid_api/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String image;
  String name;
  int totalcase,
      totalDeath,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailsScreen(
      { required this.image,
        required this.name,
      required this.totalcase,
      required this.totalDeath,
      required this.totalRecovered,
      required this.todayRecovered,
      required this.active,
      required this.critical,
      required this.test});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name.toString()),
          centerTitle: true,
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.068),
              child: Card(
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height *.06),
                   ReusableRow(title: "Cases", value: widget.totalcase),
                  ReusableRow(title: "totalDeath", value: widget.totalDeath),
                  ReusableRow(title: "totalRecovered", value: widget.totalRecovered),
                  ReusableRow(title: "active", value: widget.active),
                  ReusableRow(title: "critical", value: widget.critical),

                  ReusableRow(title: " Total Tests", value: widget.test),



                ],),
              ),
            ),
            CircleAvatar(
              radius: 30,
                backgroundImage: NetworkImage(widget.image.toString()),
            )
          ],
        )
      ],),
    );
  }
}
