import 'dart:async';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Timer",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int hour = 0;
  int minute = 0;
  int second = 0;
  String timetodisplay= "";
  bool isstarted=true;
  bool isstopped=true;
  bool canceltimer=false;
  int timeforTimer;
  

  void start(){
    timeforTimer=hour*3600+minute*60+second;
    Timer.periodic(Duration(seconds:1), (Timer t) {
      if(timeforTimer<1 )
      {
        t.cancel();
        hour=0;minute=0;second=0;
        setState(() {
            isstarted=true;
            isstopped=true;
        });
      }
      
      else if(canceltimer)
      {
        t.cancel();
        canceltimer=false;

      }
      else
      {
        timeforTimer--;
        setState(() {
           isstarted=true;
           isstopped=false;
        });
      }
      setState(() {
        String hr,min,sec;
        int seconds=timeforTimer;
      
        seconds ~/ 3600 <10 ? hr='0'+(seconds ~/ 3600).toString():hr= (seconds ~/ 3600).toString(); 
        hour=seconds~/3600;
        seconds%=3600;         
        seconds ~/ 60 < 10 ? min='0'+(seconds ~/ 60).toString(): min=(seconds ~/ 60).toString(); 
        minute=seconds~/60;
        seconds%=60;
        seconds  < 10  ? sec='0'+(seconds).toString(): sec=(seconds).toString(); 
        second=seconds;

        timetodisplay= "$hr : $min : $sec";
        
        
      });
     });
  }

  void stop()
  {
    setState(() {
      isstarted=false;
      isstopped=true;
      canceltimer=true;
    });
  }


  Widget numberPickerColumn(String txt, int minval, int maxval, int setVal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 60.0),
            child: Text(
              "$txt",
            )),
        NumberPicker(
            value: setVal,
            minValue: minval,
            maxValue: maxval,
            onChanged: (val) {
              setState(() {
                setVal = val;
              });
            }),
      ],
    );
  }

  Widget timer() {

    

    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // numberPickerColumn("HH", 0, 23, hour),
              // numberPickerColumn("MM", 0, 59, minute),
              // numberPickerColumn("SS", 0, 59, second),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "HH",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      )
                  ),
                  NumberPicker(
                      value: hour,
                      minValue: 0,
                      maxValue: 23,
                      itemWidth: 60.0,
                      onChanged: (val) {
                        setState(() {
                          hour = val;
                          if(hour==0 && minute==0 && second==0) 
                            isstarted=true;
                          else if(isstopped)
                           isstarted=false;
                        });
                      }
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "MM",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      )
                  ),
                  NumberPicker(
                      value: minute,
                      minValue: 0,
                      maxValue: 59,
                      itemWidth: 60.0,
                      onChanged: (val) {
                        setState(() {
                          minute = val;
                          // hour==0 && minute==0 && second==0 ? isstarted=true :  isstarted=false;
                          if(hour==0 && minute==0 && second==0) 
                            isstarted=true;
                          else if(isstopped)
                           isstarted=false;
                        });
                      }
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "SS",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      )
                  ),
                  NumberPicker(
                      value: second,
                      minValue: 0,
                      maxValue: 59,
                      itemWidth: 60.0,
                      onChanged: (val) {
                        setState(() {
                          second = val;
                          if(hour==0 && minute==0 && second==0) 
                            isstarted=true;
                          else if(isstopped)
                           isstarted=false;
                        });
                      }
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            timetodisplay,
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed:isstarted ? null : start ,
                  color: Colors.green,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: Text(
                    "START",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: isstopped ? null : stop,
                  color: Colors.red,
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: Text(
                    "STOP",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            )),
      ],
    ));
  }

  TabController tb;
  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Timer",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text(
              "Timer",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Stopwatch",
              style: TextStyle(color: Colors.white),
            )
          ],
          labelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
          labelPadding: EdgeInsets.only(bottom: 10.0),
          unselectedLabelColor: Colors.white60,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          Text(
            "Stopwattch",
          )
        ],
        controller: tb,
      ),
    );
  }
}
