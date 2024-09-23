import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/components/search_field/search.dart';
import 'package:rasaank_labzbalad/components/search_field/search_provider.dart';

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
    // Add more words...
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
      String searchText = searchProvider.searchText;
      List<String> filteredWords = words
          .where((word) => word.toLowerCase().contains(searchText))
          .toList();
      TextDirection textDirection =
          searchProvider.selectedDropdownValue == "BL" ||
                  searchProvider.selectedDropdownValue == "UR"
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
              selectedItem: searchProvider.selectedDropdownValue,
              onLanguageChange: (newValue) {
                searchProvider.setSelectedDropdownValue(newValue!);
              },
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: filteredWords.length, // Change here
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredWords[index], textDirection: textDirection),
                subtitle: Text(
                  searchProvider.selectedDropdownValue,
                  textDirection: textDirection,
                ), // Optional
              );
            },
          ),
        ),
      );
    });
  }
}
