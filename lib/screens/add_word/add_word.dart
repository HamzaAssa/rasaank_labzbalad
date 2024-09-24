import 'package:flutter/material.dart';
import 'package:rasaank_labzbalad/screens/add_word/word_field/word_field.dart';

class AddWord extends StatelessWidget {
  const AddWord({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        Theme.of(context).colorScheme.primary.withBlue(100).withGreen(100);
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(
          width: 0,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontSize: 22,
        ),
        title: const Text('Add Word'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WordField(
                title: "Balochi",
              ),
              SizedBox(
                height: 10,
              ),
              WordField(
                title: "Urdu",
              ),
              SizedBox(
                height: 10,
              ),
              WordField(
                title: "English",
              ),
              SizedBox(
                height: 10,
              ),
              WordField(
                title: "Roman Balochi",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
