import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rasaank_labzbalad/screens/components/bottom_navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);

    return Theme(
      data: _themeData(context, primaryColor),
      child: Scaffold(
        appBar: _appBar(context, primaryColor),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.9),
                    fontSize: 16,
                    wordSpacing: 4,
                    letterSpacing: 0.5,
                  ),
                  children: [
                    TextSpan(
                      text: '''Welcome''',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const TextSpan(text: '\nWelcome to '),
                    const TextSpan(
                      text: 'Rasaank Labz Balad',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text:
                          ''', a community-driven Balochi dictionary designed to celebrate and preserve balochi language. Our goal is to use technology to create a comprehensive and crowdsourced balochi dictionary with your help.''',
                    ),
                    const TextSpan(
                      text:
                          ''' \nBalochi language is diverse, but many words remain undocumented. ''',
                    ),
                    const TextSpan(
                      text: 'Rasaank Labz Balad',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text:
                          ''' aims to fill this gap by inviting everyone to contribute. We believe that language belongs to its speakers, and your input is crucial in building a dictionary.''',
                    ),
                    TextSpan(
                      text: "\n\nJoin the Community",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const TextSpan(
                      text:
                          '''\nYou can add new words. If you notice a missing word, you can suggest it along with its meaning. Our admin team will review and add it to the dictionary.''',
                    ),
                    const TextSpan(
                      text:
                          '''\nYou can verify words. If you have knowledge of balochi language and linguistics. If interested, you can contact us through the provided email.''',
                    ),
                    TextSpan(
                      text: "\n\nContact US ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    WidgetSpan(
                        child: GestureDetector(
                      child: Text(
                        '''rasaank.labz.balad@gmail.com.''',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      onTap: () async {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'rasaank.labz.balad@gmail.com',
                        );
                        if (await canLaunchUrl(emailLaunchUri)) {
                          launchUrl(emailLaunchUri);
                        }
                      },
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavbar(
          selected: 4,
        ),
      ),
    );
  }

  ThemeData _themeData(context, primaryColor) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }

  AppBar _appBar(context, primaryColor) {
    return AppBar(
      toolbarHeight: 35,
      scrolledUnderElevation: 0.0,
      leading: const SizedBox(),
      leadingWidth: 0,
      titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 22,
      ),
      title: SizedBox(
        height: 35,
        child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
            )),
            Container(
              height: 35,
              padding: const EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              child: const Text('Rasaank Labz Balad'),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
