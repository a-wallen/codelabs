import 'package:ffigen_app/ffigen_app.dart';
import 'package:flutter/material.dart';

const String jsCode = '1+2';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Duktape duktape;
  String output = '';

  @override
  void initState() {
    super.initState();
    duktape = Duktape();
    setState(() {
      output = 'Initialized Duktape';
    });
  }

  @override
  void dispose() {
    duktape.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Duktape Test'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  output,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                ElevatedButton(
                  child: const Text('Run JavaScript'),
                  onPressed: () async {
                    duktape.evalString(jsCode);
                    setState(() {
                      output = '$jsCode => ${duktape.getInt(-1)}';
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
