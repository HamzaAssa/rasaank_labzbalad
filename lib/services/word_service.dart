import 'package:share_plus/share_plus.dart';

class WordService {
  static int getNewDataFromServer() {
    return 0;
  }

  static int sendNewDataFromServer() {
    return 0;
  }

  static void shareWord(String text) async {
    await Share.share(text);
  }
}
