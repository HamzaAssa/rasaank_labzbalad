import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/word_list/search_field/search_field.dart';
import 'package:rasaank_labzbalad/screens/word_list/search_field/search_provider.dart';
import 'package:rasaank_labzbalad/screens/add_word/add_word.dart';

class WordList extends StatefulWidget {
  const WordList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  final TextEditingController textController = TextEditingController();
  final List<String> words = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
  ];

  @override
  void initState() {
    super.initState();
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          toolbarHeight: 75,
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: SearchField(
              textController: textController,
              textDirection: textDirection,
              hintText: "Search",
              selectedItem: searchProvider.selectedLanguage,
              onLanguageChange: (newValue) {
                searchProvider.setSelectedDropdownValue(newValue!);
              },
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: searchProvider.searchedWords.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchProvider.searchedWords[index]["word"],
                    textDirection: textDirection),
                subtitle: Text(
                  searchProvider.selectedLanguage,
                  textDirection: textDirection,
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddWord()),
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
