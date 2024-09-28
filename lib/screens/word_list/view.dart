import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/word_list/search_field/view.dart';
import 'package:rasaank_labzbalad/screens/word_list/search_field/provider.dart';
import 'package:rasaank_labzbalad/screens/add_word/view.dart';
import 'package:rasaank_labzbalad/screens/word_list/word_tile/view.dart';

class WordList extends StatefulWidget {
  const WordList({super.key});

  @override
  WordListState createState() => WordListState();
}

class WordListState extends State<WordList> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<SearchProvider>(context, listen: false).getAllWords();
    textController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    String searchText = textController.text.toLowerCase();
    Provider.of<SearchProvider>(context, listen: false)
        .setSearchText(searchText);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, searchProvider, child) {
      TextDirection textDirection = searchProvider.selectedLanguage == "BL" ||
              searchProvider.selectedLanguage == "UR"
          ? TextDirection.rtl
          : TextDirection.ltr;

      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: SearchField(
              textController: textController,
              textDirection: textDirection,
              labelText: "Search",
              selectedItem: searchProvider.selectedLanguage,
              onLanguageChange: (newValue) {
                searchProvider.setSelectedLanguage(newValue!);
              },
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: searchProvider.searchWords.length,
            itemBuilder: (context, index) {
              return WordTile(
                word: searchProvider.searchWords[index],
                textDirection: textDirection,
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddWord()),
            );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: textDirection == TextDirection.rtl
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,
      );
    });
  }
}
