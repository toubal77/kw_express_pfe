import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kw_express_pfe/app/landing_screen.dart';
import 'package:kw_express_pfe/app/models/cart.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/services/firebase_auth.dart';
import 'package:kw_express_pfe/services/firestore_database.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(create: (context) => FirebaseAuthService()),
        Provider<Database>(create: (context) => FirestoreDatabase()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
          title: 'K&W Express',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LandingScreen(),
        ),
      ),
    );
  }
}
