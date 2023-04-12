import 'package:flutter/material.dart';
import 'package:library_app/utils/extension.dart';

import 'package:provider/provider.dart';

import '../blocs/library_page_bloc.dart';
import '../consts/dimes.dart';

import '../consts/strings.dart';
import '../consts/colors.dart';

import '../view_items/library_page_view_item.dart';
import 'your_shelf_page.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryPageBloc>(
        create: (context) => LibraryPageBloc(),
        child: Consumer<LibraryPageBloc>(
          builder: (BuildContext context, bloc, Widget? child) =>
              DefaultTabController(
            length: 2,
            child: Scaffold(
              body: Column(
                children: [
                  const SizedBox(
                    height: kSP30x,
                  ),
                   const TabBar(
                    unselectedLabelColor: kGreyColor,
                    labelColor: kAmberColor,
                    tabs: [
                      Tab(
                        text: kYourBookText,
                      ),
                      Tab(
                        text: kYourShelf,
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        LibraryBooksItemView(
                          updatedLists:
                              context.getLibraryPageBloc().getListVoForLibrary,
                        ),
                        YourShelfPage()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
