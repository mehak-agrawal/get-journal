import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'global/constants/colors.dart';
import 'providers/paper_provider.dart';
import 'screens/base/base_screen.dart';
import 'screens/landing/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  runApp(const GetJournal());
}

class GetJournal extends StatelessWidget {
  const GetJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaperProvider(),
      child: MaterialApp(
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: kPrimaryBlue,
            selectionColor: kLightBlue,
          ),
          primaryColor: kPrimaryBlue,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: kPrimaryBlue,
              ),
          textTheme:
              GoogleFonts.montserratTextTheme().apply(bodyColor: kPrimaryBlue),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: LandingScreen.id,
        routes: {
          LandingScreen.id: (context) => const LandingScreen(),
          BaseScreen.id: (context) => BaseScreen(),
        },
      ),
    );
  }
}
