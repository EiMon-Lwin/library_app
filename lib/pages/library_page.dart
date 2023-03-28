import 'package:flutter/material.dart';
import 'package:library_app/consts/api_consts.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/persistent/lists_dao/lists_dao_impl.dart';
import 'package:provider/provider.dart';

import '../blocs/library_page_bloc.dart';
import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../persistent/lists_dao/lists_dao.dart';
import '../widgets/text_field_widget.dart';
import 'home_page.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListsDAO _listDAO=ListsDAOImpl();
   var temp= _listDAO.getListOfListsFromDataBase(kPublishedDate)?.where((event) {
     var temp=event.books;
     temp?.map((e) => e.isSelected);
     return false;
     
   }).toList();
print("|||||||||||||||||||||||||||||||||||||||||||||||||||||$temp");
    // for(ListsVO listsVo in widget.listsList){
    //   var temp=listsVo.books;
    //   for(BooksVO book in temp!) {
    //     print("---------->${book.title}");
    //   }
    // }
    return ChangeNotifierProvider<LibraryPageBloc>(
      create: (context) => LibraryPageBloc(),
      child: Selector<LibraryPageBloc, List<BooksVO>>(
        selector: (_, bloc) => bloc.getFavoriteBooksList,
        builder: (context, value, child) => Scaffold(
          body: SizedBox(
              height: 600,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: kSP50x,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 30),
                        padding: const EdgeInsets.only(left: 3),
                        width: kTextFieldSizedWidth300x,
                        height: kTextFieldSizedHeight70x,
                        child: TextFieldWidget(
                          icon: const Icon(Icons.saved_search),
                          text: kHomePageHintText,
                        )),
                    const SizedBox(
                      height: kSP30x,
                    ),
                    const DefaultTabController(
                        length: 2,
                        child: TabBar(
                          tabs: [Text('Your Books'), Text('Your Shelves')],
                          isScrollable: true,
                          labelColor: kTabBarBlackColor,
                          indicatorColor: kIndicatorColor,
                        )),
                    (value.isEmpty)? const Center(child: Text("Your Library is Empty!")):
                   // SingleChildScrollView(child: BooksSessionItemView(value: temp ?? [],))
                    Container()
                  ],
                ),

            ),

        ),
      ),
    );
  }
}
