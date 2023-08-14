import 'package:flutter/material.dart';
import 'package:js/js.dart' as js;
import 'package:js/js_util.dart' as js_util;

typedef Handler = void Function(String text);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _StateMainApp();
}

@js.JSExport()
class _StateMainApp extends State<MainApp> {
  final _controller = TextEditingController();

  late Handler _handler;

  @js.JSExport()
  void inputText(String text) {
    _controller.text = text;
  }

  @js.JSExport()
  void addHandler(Handler handler) {
    _handler = handler;
  }

  @override
  void initState() {
    super.initState();
    final export = js_util.createDartExport(this);
    js_util.setProperty(js_util.globalThis, '_flutterApp', export);
    js_util.callMethod<void>(js_util.globalThis, '_init', []);

    _controller.addListener(() {
      _handler(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectionArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Selection Area'),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Message'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
