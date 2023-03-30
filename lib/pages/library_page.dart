import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';

import 'package:library_app/persistent/favorite_dao/favorite_dao_impl.dart';
import 'package:library_app/utils/extension.dart';
import 'package:provider/provider.dart';

import '../blocs/library_page_bloc.dart';
import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../persistent/favorite_dao/favorite_dao.dart';
import '../widgets/easy_Text_widget.dart';
import '../widgets/text_field_widget.dart';
import 'home_page.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key}) : super(key: key);
  final FavoriteDAOImpl _favoriteDAO = FavoriteDAOImpl();

  @override
  Widget build(BuildContext context) {
    print(
        "FavoriteBooks------------>${_favoriteDAO.getFavoriteBooksBox.values}");

    return ChangeNotifierProvider<LibraryPageBloc>(
        create: (context) => LibraryPageBloc(),
        child: Selector<LibraryPageBloc,List<ListsVO>>(
          selector: (_, bloc) => bloc.getListVoForLibrary,

          builder: (BuildContext context, value, Widget? child) =>
              DefaultTabController(
                length: 2,
                child: Scaffold(
            body:  Column(
                  children:
                  [
                    const SizedBox(
                      height: kSP30x,
                    ),
                    const TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.amber,
                      tabs: [
                        Tab(
                          text: 'Your Book',
                        ),
                        Tab(
                          text: 'Your Shelf',
                        ),

                      ],
                    ),

                       Expanded(
                         child: TabBarView(children: [
                            (value.isEmpty)
                                ? const Center(child: Text("\nYour Library is Empty!"))
                                : BooksSessionItemView(
                              listsList: value,
                            ),


                            Container()
                      ]),
                       ),


                  ],
              ),
            
          ),
              ),
        ));
  }
}
