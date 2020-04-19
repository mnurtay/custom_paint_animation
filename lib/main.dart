import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Point Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      // home: CustomDemo(),
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final asset = AssetFlare(bundle: rootBundle, name: 'assets/progress_bar.flr');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlareActor.asset(
            asset,
            animation: 'run',
          ),
        ),
      ),
    );
  }
}
