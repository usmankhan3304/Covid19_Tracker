import 'dart:math';

import 'package:flutter/material.dart';

class Animation1 extends StatefulWidget {
  const Animation1({Key? key}) : super(key: key);

  @override
  State<Animation1> createState() => _Animation1State();
}

class _Animation1State extends State<Animation1> {
  double width=100;
  double height=100;
  Color color= Colors.blue;
  double opicity=0.5;
  BorderRadius radius= BorderRadius.circular(200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  color: color,
                ),
                duration: Duration(microseconds: 500)),
          ),
          AnimatedOpacity(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(400),
                ),
              ),
              opacity: opicity,
              duration: Duration(milliseconds: 600))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        // double random= Random().nextDouble(300);
          final random= Random();
          height= random.nextInt(500).toDouble();
          width=random.nextInt(600).toDouble();

          // color= Color.fromRGBO(
          //     random.nextInt(256),
          //     random.nextInt(256),
          //     random.nextInt(256),
          //     2);
          setState(() {
            opicity= opicity == 0.4 ? 1.0 : 0.4;
            // width=random.nextInt(300).toDouble();
            // height=Random().nextInt(300).toDouble();
          });

        },
        child: Icon(Icons.refresh),

      ),
    );
  }
}
