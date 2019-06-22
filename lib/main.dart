import 'package:flutter/material.dart';
import 'package:stomp_client/stomp_client.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    StompClient stomp = StompClient(urlBackend: "ws://192.168.1.6:8080/ws-flutter");
    stomp.connectWithToken(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0YXhpc3RhMUB0YXhpc3RhLmNvbSIsIm5vbWJyZSI6IlRheGlzdGEiLCJhcGVsbGlkbzEiOiJhcGVsbGlkbyIsImFwZWxsaWRvMiI6ImFwZWxsaWRvIiwidGVsZWZvbm8iOiIxMTExMTExMSIsImZvdG9VcmwiOiJmb3RvIiwicGVybWlzb3MiOlsiMjAwIl0sInJvbCI6IlRheGlzdGEiLCJlc3RhZG8iOmZhbHNlLCJqdXN0aWZpY2FjaW9uIjoianVzdGlmaWNhY2nDs24gTGljZW5jaWEgdmVuY2lkYS4iLCJpYXQiOjE1NjEyNDM2MzEsImV4cCI6MTU2MTI0NzIzMX0.U679nYd93Jm37eF-xyYK3cWPcP7_Xrgba8cCjdd16xs");
    //sleep(Duration(seconds: 2));
    stomp.subscribe(topic: "/queue/a").stream.listen((message) {
      // handling of the incoming messages
      print(message.toString());
      //messageReceieved(message);
    }, onError: (error, StackTrace stackTrace) {
      // error handling
    }, onDone: () {
      // communication has been closed
    });
    stomp.send(topic: "/queue/a", message: "holas");

    stomp.send(topic: "/queue/a", message: "holas2");
    

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  void printStream(Stream<dynamic> stream) async {
  
  await for (var value in stream) {
    print(value.toString());
  }
  
}
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
