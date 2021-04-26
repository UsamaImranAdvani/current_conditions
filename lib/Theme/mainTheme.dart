import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:water_level_indicator/Api/config.dart';

// ignore: camel_case_types
class mainTheme extends StatelessWidget {
  const mainTheme({
    @required this.con,
    @required this.the,
  });

  final config con;
  final theme the;

  waterLevel(int lvl) {
    return 0.142 * lvl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(int.tryParse(the.container)),
            height: MediaQuery.of(context).size.height - 118.2,
            child: getBody(context),
          ),
        ],
      ),
    );
  }

  Widget getBody(context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: con.cities.length,
        itemBuilder: (ctx, index) {
          return getCard(context, con.cities[index]);
        });
  }

  Widget getCard(context, index) {
    // print(index.key);
    var city = index.key;
    var lvl = index.value;

    return Card(
        child: GestureDetector(
      onTap: () async {
        con.currCity = city;
        await Navigator.pushNamed(
          context,
          "/weatherApiCall",
          arguments: [con, the],
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(int.tryParse(the.card)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0.75, 0.75), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 220,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      (city != null) ? city : "Cant Access Area" ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(int.tryParse(the.txt)),
                        fontSize: 24,
                      ),
                    ),
                    Text("Last Updated:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(int.tryParse(the.txt)),
                        )),
                    Text((con.time != null) ? con.time : "Cant Access Time",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(int.tryParse(the.txt)),
                        )),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              width: 60,
            ),
            Container(
              height: 90,
              width: 90,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: LiquidCircularProgressIndicator(
                  value: waterLevel(lvl),
                  // Defaults to 0.5.
                  valueColor: AlwaysStoppedAnimation(Color(int.tryParse(the.liquid))),
                  // Defaults to the current Theme's accentColor.
                  backgroundColor: Color(int.tryParse(the.container)),
                  // Defaults to the current Theme's backgroundColor.
                  // borderColor: Colors.black,
                  // borderWidth: 1.0,
                  direction: Axis.vertical,
                  // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                  center: Text(
                    lvl.toString() + " ft",
                    style: TextStyle(color: Color(int.tryParse(the.liquidTxt)), fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
