import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:library_app/data/vos/home_screen_api_vos/results_vo/results_vo.dart';
import 'package:library_app/data/vos/shelf_vos/shelf_vo.dart';
import 'package:library_app/pages/navigate_page.dart';

import 'consts/persistent_const.dart';
import 'data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'data/vos/home_screen_api_vos/buy_links_vo/buy_links_vo.dart';
import 'data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ResultsVOAdapter());
  Hive.registerAdapter(BooksVOAdapter());
  Hive.registerAdapter(BuyLinksVOAdapter());
  Hive.registerAdapter(ListsVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<ResultsVO>(kHiveBoxResultsName);
   await Hive.openBox<BooksVO>(kFavoriteBooksListBoxName);
  await Hive.openBox<ListsVO>(kListOfListsBoxName);
  await Hive.openBox<String>(kBoxNameForSearchHistoryVO);
  await Hive.openBox<ShelfVO>(kBoxNameForListShelfVO);

  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBarPage(),
    );
  }
}
