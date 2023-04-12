import 'package:flutter/material.dart';
import 'package:library_app/blocs/shelf_page_bloc.dart';
import 'package:provider/provider.dart';

import 'navigate_pages.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShelfPageBloc(),
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index)=>
              setState(() {
                currentIndex=index;
              }),
          items:const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Library", icon: Icon(Icons.library_books)),

          ],
        ),
      ),
    );
  }
}