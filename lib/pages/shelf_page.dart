import 'package:flutter/material.dart';
import 'package:library_app/blocs/shelf_page_bloc.dart';
import 'package:library_app/consts/dimes.dart';

import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/shelf_vos/shelf_vo.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/view_items/shelf_page_and_your_shelf_page_view_items.dart';
import 'package:library_app/widgets/easy_Text_widget.dart';
import 'package:library_app/widgets/network_image_widget.dart';
import 'package:library_app/widgets/no_data_image_widget.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../consts/strings.dart';

class ShelfPage extends StatelessWidget {
  const ShelfPage({Key? key, required this.booksVO}) : super(key: key);
  final BooksVO booksVO;

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      create: (context) => ShelfPageBloc(),
      child: Scaffold(
        floatingActionButton: const SizedBox(
          width: kFloatingActionButtonWidth150x,
          child: FloatingActionButtonItemView(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: kDetailsWhiteColor,
          title: const EasyTextWidget(
            text: kAddToShelfText,
            fontWeight: kFontWeightBold,
          ),
          leading: GestureDetector(
              onTap: () {
                context.navigateBack(context);
              },
              child: const Icon(Icons.arrow_back_ios_rounded,
                  color: kTabBarBlackColor)),
        ),
        body: Selector<ShelfPageBloc, List<ShelfVO>>(
          selector: (_, bloc) => bloc.getShelfList,
          builder: (context, value, child) => (value.isEmpty)
              ? const NoDataImageWidget()
              : ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => ShelfItemView(
                    shelfVO: value[index], booksVO: booksVO,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: kSP1x,
                      ),
                  itemCount: value.length),
        ),
      ),
    );
  }
}

class ShelfItemView extends StatelessWidget {
  const ShelfItemView({
    super.key,
    required this.shelfVO, required this.booksVO,
  });


  final ShelfVO shelfVO;
  final BooksVO booksVO;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        context
            .getShelfPageBlocInstance()
            .addBookToShelf(shelfVO, booksVO);
        context.navigateBack(context);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: kDetailsBackgroundColor,
            content: EasyTextWidget(
                text: '${booksVO.title} $kSnackBarText'))));
      },

      child: Card(
        color: kDetailsBackgroundColor,
        child: Row(children: [

          Container(
            padding: const EdgeInsets.only(left: kSP10x),
            child: NetworkImageWidget(
                imgUrl: (shelfVO.shelfBooks?.isEmpty ?? false)
                      ? kDefaultImageLink
                      : shelfVO.shelfBooks?.first.bookImage ?? '',
                borderRadius: kImageBorderCircular8x,
                imageWidth: kShelfImageWidth90x,
                imageHeight: kShelfImageHeight60x),
          ),
          Container(
            padding: const EdgeInsets.only(left: kSP10x),
              child: ShelfNameAndBookCountView(shelfVO: shelfVO))
        ]),
      ),
    );
  }
}




