import 'package:flutter/material.dart';
import 'package:ping_view_widget/ping_view_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ping View Widget Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 240,
          child: PingViewWidget(
            ispInformationText: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "LOREM SERVER\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                    text: "São Paulo, Brasil",
                    style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            locationInformatinText: TextSpan(
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(text: "IP Interno: 198.162.1.8\n"),
                TextSpan(text: "IP Externo: 198.162.1.7\n"),
                TextSpan(
                  text: "Operadora: Jio",
                ),
              ],
            ),
            techInformationText: TextSpan(
              text: "LTE",
              style: TextStyle(color: Color(0xFF3ebdb8), fontSize: 11),
            ),
          ),
        ),
      ),
    );
  }
}
