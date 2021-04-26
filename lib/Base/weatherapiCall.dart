import 'package:flutter/material.dart';
import '../Theme//weathertheme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:water_level_indicator/Api/config.dart';

class weatherApiCall extends StatefulWidget {
  List dataMap;

  weatherApiCall({@required dataMap}) {
    this.dataMap = dataMap;
  }

  @override
  _weatherApiCallState createState() => _weatherApiCallState();
}

class _weatherApiCallState extends State<weatherApiCall> {
  bool _isLoadingWeather = true;
  bool _ApiLoadErrorWeather = false;
  int wlvl;
  String dayOrNight;

  var bg, txt;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
    themeSelector();
  }

  Future start() async {
    await widget.dataMap[0].fetchCity();
    for (int i = 0; i < widget.dataMap[0].cities.length; i++) {
      if (widget.dataMap[0].cities[i].key == widget.dataMap[0].currCity) {
        setState(() {
          wlvl = widget.dataMap[0].cities[i].value;
        });
      }
    }
    await widget.dataMap[0].fetchWeather();
    setState(() {
      _isLoadingWeather = widget.dataMap[0].isLoadingWeather;
      _ApiLoadErrorWeather = widget.dataMap[0].ApiLoadErrorWeather;
    });
    dayNight();
  }

  themeSelector() {
    if (widget.dataMap[1].dark) {
      bg = widget.dataMap[1].darkBG;
      txt = widget.dataMap[1].darkAppBarTxt;
    } else {
      bg = widget.dataMap[1].lightBG;
      txt = widget.dataMap[1].lightAppBarTxt;
    }
  }

  dayNight() {
    setState(() {
      if (widget.dataMap[0].IsDayTime == null) {
        dayOrNight = widget.dataMap[1].day;
      }
    });
    setState(() {
      if (widget.dataMap[0].IsDayTime) {
        dayOrNight = widget.dataMap[1].day;
      } else
        dayOrNight = widget.dataMap[1].night;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text.rich(
              TextSpan(
                text: 'Current Conditions',
                style: TextStyle(
                    color: HexColor(txt),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          backgroundColor: HexColor(bg),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: HexColor(txt),
              ),
              onPressed: () => {

                    Navigator.pop(context),
                  }),
        ),
        body: RefreshIndicator(
            // ignore: missing_return
            onRefresh: start,
            child: (_isLoadingWeather)
                ? Center(child: CircularProgressIndicator())
                : (_ApiLoadErrorWeather)
                    ? Center(
                        child: Text("Refresh Your Page The API Didnt Work"),
                      )
                    : weatherTheme(
                        city: widget.dataMap[0].currCity,
                        wlvl: wlvl,
                        time: widget.dataMap[0].time,
                        the: widget.dataMap[1],
                        con: widget.dataMap[0],
                        image: dayOrNight,
                      )));
  }
}
