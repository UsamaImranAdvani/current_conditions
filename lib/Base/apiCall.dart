import 'package:flutter/material.dart';
import 'dart:async';
import '../Api/config.dart';
import '../Theme//mainTheme.dart';
import 'package:hexcolor/hexcolor.dart';

class apiCall extends StatefulWidget {
  @override
  _apiCallState createState() => _apiCallState();
}

class _apiCallState extends State<apiCall> {
  bool _isLoading = true;
  bool _ApiLoadError;
  String time;
  List cities;
  var bg, txt;
  config con = new config();
  theme the = new theme();
  bool dark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeSelector();
    caller();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeSelector();
    caller();
  }

  Future caller() async {
    await con.fetchCity();
    setState(() {
      _isLoading = con.isLoading;
      _ApiLoadError = con.ApiLoadError;
    });
  }

  themeSelector() {
    dark = the.dark;
    if (dark) {
      bg = the.darkBG;
      txt = the.darkAppBarTxt;
    } else {
      bg = the.lightBG;
      txt = the.lightAppBarTxt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text.rich(
              TextSpan(
                text: 'Water Level Indicator',
                style: TextStyle(
                    color: HexColor(txt),
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          backgroundColor: HexColor(bg),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.invert_colors,
                  color: HexColor(txt),
                ),
                onPressed: () => {
                      setState(() {
                        the.changer();
                        themeSelector();
                      })
                    })
          ],
        ),
        body: RefreshIndicator(
            onRefresh: caller,
            child: (_isLoading)
                ? Center(child: CircularProgressIndicator())
                : (_ApiLoadError == true)
                    ? Center(
                        child: Text("Refresh Your Page The API Didnt Work"),
                      )
                    : mainTheme(
                            con: con,
                            the: the,
                          )));
  }
}
