import 'package:educa_app/core/common/app/providers/course_of_the_day_provider.dart';
import 'package:educa_app/core/common/app/providers/user_provider.dart';
import 'package:educa_app/core/injection/injection_container.dart';
import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/fonts.dart';
import 'package:educa_app/core/router/router.dart';
import 'package:educa_app/firebase_options.dart';
import 'package:educa_app/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

  await init();

  runApp(const EducaApp());
}

class EducaApp extends StatelessWidget {
  const EducaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
        ChangeNotifierProvider(create: (_) => CourseOfTheDayProvider()),
      ],
      child: MaterialApp(
        title: 'Educa App',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colours.primaryColour,
            backgroundColor: Colours.whiteColour,
          ),
        ),
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
