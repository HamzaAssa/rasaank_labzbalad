import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/add_word/add_word_provider.dart';
import 'package:rasaank_labzbalad/screens/add_word/word_field/word_field.dart';

class AddWord extends StatelessWidget {
  final TextEditingController balochiTextController = TextEditingController();
  final TextEditingController urduTextController = TextEditingController();
  final TextEditingController englishTextController = TextEditingController();
  final TextEditingController romanBalochiTextController =
      TextEditingController();
  AddWord({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: const SizedBox(width: 0),
        centerTitle: true,
        titleTextStyle: TextStyle(color: primaryColor, fontSize: 22),
        title: const Text('Add Word'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WordField(
                    title: "Balochi",
                    textDirection: TextDirection.rtl,
                    textEditingController: balochiTextController),
                const SizedBox(height: 10),
                WordField(
                  title: "Urdu",
                  textDirection: TextDirection.rtl,
                  textEditingController: urduTextController,
                ),
                const SizedBox(height: 10),
                WordField(
                  title: "English",
                  textDirection: TextDirection.ltr,
                  textEditingController: englishTextController,
                ),
                const SizedBox(height: 10),
                WordField(
                  title: "Roman Balochi",
                  textDirection: TextDirection.ltr,
                  textEditingController: romanBalochiTextController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final balochi = balochiTextController.text.trim();
                    final urdu = urduTextController.text.trim();
                    final english = englishTextController.text.trim();
                    final romanBalochi = romanBalochiTextController.text.trim();

                    if (balochi.isEmpty &&
                        urdu.isEmpty &&
                        english.isEmpty &&
                        romanBalochi.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('One Word must be filled!')),
                      );
                      return;
                    }

                    Provider.of<AddWordProvider>(context, listen: false)
                        .addWord(balochi, urdu, english, romanBalochi)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Word added successfully!')),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Add Word',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
