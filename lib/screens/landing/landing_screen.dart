import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../global/constants/colors.dart';
import '../../global/utilities/size_helper.dart';
import '../../global/widgets/reusable_button.dart';
import '../../services/auth_service.dart';
import '../base/base_screen.dart';

class LandingScreen extends StatefulWidget {
  static const id = '/landing_screen';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late Widget _toDisplay;
  final AuthService _authService = AuthService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _toDisplay = Column(
      key: const ValueKey<int>(1),
      children: [
        const SizedBox(height: 40.0),
        SizedBox(
          // TODO Remove hardcoded values
          height: 60.0,
          width: 300.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 45.0,
                  fontFamily: GoogleFonts.spartan().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  pause: const Duration(milliseconds: 100),
                  repeatForever: true,
                  animatedTexts: [
                    RotateAnimatedText('Find'),
                    RotateAnimatedText('Read'),
                    RotateAnimatedText('Save'),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              const Text(
                'papers.',
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Text(
          'All in one place.',
          style: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 80.0),
        SwipeButton(
          activeTrackColor: Colors.white.withOpacity(0.4),
          elevation: 5.0,
          height: 60.0,
          activeThumbColor: kPrimaryBlue,
          thumb: const Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 45.0,
          ),
          width: SizeHelper(context).width * 0.75,
          child: const Text(
            'Start your research',
            style: TextStyle(fontSize: 18.0),
          ),
          onSwipe: () {
            if (AuthService.signedIn()) {
              Navigator.popAndPushNamed(context, BaseScreen.id);
            } else {
              setState(
                () {
                  _toDisplay = Column(
                    key: const ValueKey<int>(2),
                    children: [
                      const SizedBox(height: 40.0),
                      Image.asset(
                        'images/app_icon.png',
                        width: SizeHelper(context).width * 0.2,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'GetJournal',
                        style: TextStyle(
                          fontSize: 45.0,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      ReusableButton(
                        text: 'Sign In',
                        onTap: () async {
                          await _authService.signInWithGoogle(() {}).then(
                            (loggedInUser) {
                              if (loggedInUser.user != null) {
                                if (loggedInUser
                                    .additionalUserInfo!.isNewUser) {
                                  _authService.writeUserData();
                                }
                                Navigator.popAndPushNamed(
                                  context,
                                  BaseScreen.id,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kPrimaryGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20.0),
              Image.asset(
                'images/landing_page_image.png',
                height: SizeHelper(context).height * 0.4,
              ),
              const SizedBox(height: 20.0),
              AnimatedSwitcher(
                transitionBuilder: (child, animation) => ScaleTransition(
                  child: child,
                  scale: animation,
                ),
                duration: const Duration(
                  milliseconds: 500,
                ),
                child: _toDisplay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
