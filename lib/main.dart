import 'package:archive/firebase_options.dart';
import 'package:archive/pages/main_tab_navigator.dart';
import 'package:archive/pages/start.dart';
import 'package:archive/pages/arTesting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupernino_bottom_sheet/flutter_cupernino_bottom_sheet.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? user = FirebaseAuth.instance.currentUser;

  runApp(ARchive(user: user));
}

class ARchive extends StatelessWidget {
  final User? user;

  const ARchive({super.key, required this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoBottomSheetRepaintBoundary(
        child: CupertinoApp(
      title: "ARchive",
      navigatorKey: cupertinoBottomSheetNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      home: user != null ? const MainTabNavigator() : const StartPage(),
    ));
  }
}
