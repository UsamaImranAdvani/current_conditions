import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:water_level_indicator/Api/config.dart';
import 'package:jiffy/jiffy.dart';
import 'package:water_level_indicator/Api/config.dart';

// ignore: camel_case_types
class weatherTheme extends StatelessWidget {
  const weatherTheme({
    @required this.city,
    @required this.wlvl,
    @required this.time,
    @required this.the,
    @required this.con,
    @required this.image,
  });

  final String city;
  final int wlvl;
  final String time;
  final theme the;
  final config con;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(int.tryParse(the.container)),
        height: MediaQuery.of(context).size.height - 56,
        child: getBody(city, wlvl, time, the, con, image),
      ),
    );
  }
}

waterLevel(int lvl) {
  return 0.142 * lvl;
}

Widget getBody(String city, int wlvl, String time, theme the, config con, String image) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (ctx, index) {
        return body(city, wlvl, time, the, con, image);
      });
}

Widget body(String city, int wlvl, String time, theme the, config con, String image) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        height: 220,
        width: 220,
        child: Image(
          image: AssetImage(the.logo),
        ),
      ),
      Container(
        child: Text(
          Jiffy(DateTime.now()).yMMMMd,
          style: TextStyle(
            color: Color(int.tryParse(the.txt)),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.all(20),
        child: Text(
          city,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(int.tryParse(the.txt)),
            fontSize: 30,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                child: Text(
                  "Water Level",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                height: 90,
                width: 90,
                margin: EdgeInsets.only(top: 10),
                child: LiquidCircularProgressIndicator(
                  value: waterLevel(wlvl),
                  valueColor:
                      AlwaysStoppedAnimation(Color(int.tryParse(the.liquid))),
                  backgroundColor: Color(int.tryParse(the.container)),
                  direction: Axis.vertical,
                  center: Text(
                    wlvl.toString() + " ft",
                    style: TextStyle(
                        color: Color(int.tryParse(the.liquidTxt)),
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "${con.temp}°C",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(int.tryParse(the.txt)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 50, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "RealFeelTemperature",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                  ),
                ),
                Text(
                  "${con.RealFeelTemperature}°C",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                  ),
                )
              ],
            ),
            // VerticalDivider(
            //   color: Colors.black,
            //   thickness: 5,
            //   indent: 40,
            //   endIndent: 40,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "RelativeHumidity",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                  ),
                ),
                Text(
                  "${con.RelativeHumidity}",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      Divider(
        color: Color(int.tryParse(the.txt)),
        thickness: 3,
        indent: 35,
        endIndent: 35,
      ),
      Container(
        margin: EdgeInsets.only(top: 30, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Wind Speed",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                  ),
                ),
                Text(
                  "${con.WindSpeed} km/h",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Wind Gust",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                  ),
                ),
                Text(
                  "${con.WindGust} km/h",
                  style: TextStyle(
                    color: Color(int.tryParse(the.txt)),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
      Container(
        child: Text(
          "Developed in 2021",
          style: TextStyle(
            color: Color(int.tryParse(the.txt)),
          ),
        ),
      )
    ],
  );
}
