import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scifi_ui/animated_border_container.dart';
import 'package:scifi_ui/glitch.dart';
import 'package:scifi_ui/glitch_text.dart';
import 'package:scifi_ui/minimal_bar_chart.dart';
import 'package:scifi_ui/text_style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retro Sci-Fi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Rubik',
        backgroundColor: Colors.white,
      ),
      home: MyHomePage(title: 'Retro Sci-Fi Demo'),
//      showPerformanceOverlay: true,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// declare the text style
class _MyHomePageState extends State<MyHomePage> {
  static final BoxDecoration _blackBorderDecoration =
      BoxDecoration(border: _blackBorder);

  static final Border _blackBorder = Border.all(
    width: 1.0,
    color: const Color(0xFFFF000000),
  );

  static final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: _itemBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    const versions = 6;
    if (index == 0) return Text("\n\n\n");
    switch (index % versions) {
      case 0:
        return _itemBuilder0(context);
      case 1:
        return _itemBuilder1(context, index);
      case 2:
        return _itemBuilder2(context, index);
      case 3:
        return _itemBuilder3(context, index);
      case 4:
        return _itemBuilder4(context, index);
      case 5:
        return _itemBuilder5(context, index);
    }

    throw StateError("bad");
  }

  Widget _itemBuilder0(BuildContext context) {
    final lorem =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";
    return _itemContainer(Glitch(
      useRotation: false,
      delay: _randomDelay(),
      child: Text(
        lorem,
        style: textStyle,
      ),
    ));
  }

  Widget _itemBuilder1(BuildContext context, int index) {
    final row = Row(children: <Widget>[
      Expanded(
          child: GlitchText(
        "VESSEL REV0${index}3-T",
        delay: 300,
        style: textStyleLargeBold,
      )),
      Glitch(
        delay: _randomDelay(),
        child: _sciFiButton("OK"),
      ),
    ]);
    return _itemContainer(row);
  }

  Widget _itemBuilder2(BuildContext context, int index) {
    return _itemContainer(Glitch(
      useRotation: false,
      delay: _randomDelay(),
      child: Image.asset(index == 2 || _random.nextBool()
          ? 'assets/space-station.gif'
          : 'assets/P-valor.gif'),
    ));
  }

  Widget _itemBuilder3(BuildContext context, int index) {
    final text =
        "Animation of the night sky showing the apparent retrograde motion of the planet Mars in August and September of 2003 in the constellation Aquarius. The time period depicted spans from June 15, 2003 to November 18, 2003 in 2-day increments where each day is at 00:00 UTC. All stars brighter than 5.0 magnitude are shown and labelled. ";
    final image = Image.asset(_random.nextBool()
        ? 'assets/mars-in-2013-negated.gif'
        : 'assets/fourier.gif');

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
            flex: 1,
            child: AnimatedBorderContainer(
                duration: 1000,
                delay: _randomDelay(),
                padding: EdgeInsets.all(5.0),
                child: Glitch(
                  delay: _randomDelay(),
                  useRotation: false,
                  useDistortion: false,
                  useFlicker: false,
                  child: image,
                ))),
        Flexible(
          flex: 2,
          child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Glitch(
                delay: _randomDelay(),
                useDistortion: false,
                useRotation: false,
                child: Text(
                  text,
                  maxLines: 5,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ),
      ],
    );
    return _itemContainer(row);
  }

  Widget _itemBuilder4(BuildContext context, int index) {
    return _itemContainer(MinimalBarChart());
  }

  Widget _itemBuilder5(BuildContext context, int index) {
    return _itemContainer(AnimatedBorderContainer(
        delay: _randomDelay(),
        child: Center(
            widthFactor: 16.0,
            heightFactor: 9.0,
            child: GlitchText(
              ":: LAUNCH IMMINENT ::",
              delay: _randomDelay() ~/ 2,
              style: textStyleBold,
            ))));
  }

  Container _itemContainer(Widget child) => Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: child);

  Widget _sciFiButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      decoration: _blackBorderDecoration,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }

  Widget _sciFiContainer(Widget child) {
    return AnimatedBorderContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: child,
    );
  }

  static int _randomDelay() {
    return 300 + _random.nextInt(600);
  }
}
