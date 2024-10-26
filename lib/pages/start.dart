import 'package:flutter/cupertino.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: Center(child: Text("Start Page")));
  }
}
