import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/components/bottom_navbar.dart';
import 'package:rasaank_labzbalad/screens/favorites/provider.dart';
import 'package:rasaank_labzbalad/screens/favorites/word_tile/view.dart';
import 'package:rasaank_labzbalad/screens/word_list/search_field/view.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  FavoriteListState createState() => FavoriteListState();
}

class FavoriteListState extends State<FavoriteList> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text =
        Provider.of<FavoriteProvider>(context, listen: false).searchText;
    Provider.of<FavoriteProvider>(context, listen: false).getAllFavoriteWords();
    textController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    String searchText = textController.text.toLowerCase();
    Provider.of<FavoriteProvider>(context, listen: false)
        .setSearchText(searchText);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
      TextDirection textDirection = favoriteProvider.selectedLanguage == "BL" ||
              favoriteProvider.selectedLanguage == "UR"
          ? TextDirection.rtl
          : TextDirection.ltr;

      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            primary: true,
            leading: const SizedBox(),
            leadingWidth: 0,
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: SearchField(
                textController: textController,
                textDirection: textDirection,
                labelText: "Search Favorites",
                selectedItem: favoriteProvider.selectedLanguage,
                onLanguageChange: (newValue) {
                  textController.text = "";
                  favoriteProvider.setSelectedLanguage(newValue!);
                },
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: favoriteProvider.searchFavoriteWords.length,
              itemBuilder: (context, index) {
                return FavoriteWordTile(
                  word: favoriteProvider.searchFavoriteWords[index],
                  textDirection: textDirection,
                );
              },
            ),
          ),
          bottomNavigationBar: const BottomNavbar(
            selected: 1,
          ));
    });
  }
}
