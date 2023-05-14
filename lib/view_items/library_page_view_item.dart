import 'package:flutter/material.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/network_image_widget.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import '../widgets/easy_Text_widget.dart';
import '../widgets/no_data_image_widget.dart';

class TabBarItemView extends StatelessWidget {
  const TabBarItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
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
    );
  }
}

class LibraryBooksItemView extends StatelessWidget {
  const   LibraryBooksItemView({Key? key, required this.listVOs})
      : super(key: key);
  final List<ListsVO> listVOs;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
          itemCount: listVOs.length,
          itemBuilder: (context, index) {
            if (index == 0 ||
                !listVOs[index - 1]
                    .books!
                    .any((bookVO) => bookVO.isSelected == true)) {
              return Visibility(
                visible: listVOs[index]
                    .books!
                    .any((bookVO) => bookVO.isSelected == true),
                child: SizedBox(
                  height: kFavoriteBookSessionHeight380x,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: kSP10x),
                        child: EasyTextWidget(
                          text:  listVOs[index].listName ?? '',
                          fontWeight: kFontWeightBold,
                        ),
                      ),


                      const SizedBox(height: kSP20x),
                      FavoriteBookItemView(listsVO: listVOs[index]),
                    ],
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: listVOs[index]
                    .books!
                    .any((bookVO) => bookVO.isSelected == true),
                child:
                SizedBox(
                  height: kFavoriteBookSessionHeight380x,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: kSP10x),
                        child: EasyTextWidget(
                          text:  listVOs[index].listName ?? '',
                          fontWeight: kFontWeightBold,
                        ),
                      ),

                      const SizedBox(height: kSP20x),
                      FavoriteBookItemView(listsVO: listVOs[index]),
                    ],
                  ),
                ),
              );
            }
          }),
      Visibility(
          visible: listVOs.every((list) =>
              list.books!.every((book) => !(book.isSelected ?? false))),
          child: const NoDataImageWidget())
    ]);
  }
}

class FavoriteBookItemView extends StatelessWidget {
  const FavoriteBookItemView({
    super.key,
    required this.listsVO,
  });

  final ListsVO listsVO;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kFavoriteBookItemViewHeight320x,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: kSP5x,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: listsVO.books?.length ?? 0,
        itemBuilder: (context, index) {
          var bookVO = listsVO.books?[index];

          return (bookVO?.isSelected ?? false)
              ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FavoriteBookImageView(bookVO: bookVO, listsVO: listsVO),

              const SizedBox(
                height: kSP5x,
              ),
              Container(
                margin: const EdgeInsets.only(left: kSP10x),
                height: kTitleHeight60x,
                width: kTitleWidth150x,
                child: EasyTextWidget(text: bookVO?.title ?? ''),
              )
            ],
          )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}

class FavoriteBookImageView extends StatelessWidget {
  const FavoriteBookImageView({
    super.key,
    required this.bookVO,
    required this.listsVO,
  });

  final BooksVO? bookVO;
  final ListsVO listsVO;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [

      Container(
        margin: const EdgeInsets.only(right: kSP10x,left: kSP10x),

        child: NetworkImageWidget(
            imgUrl: bookVO?.bookImage ?? kDefaultImageLink,
            borderRadius: kBorderRadiusCircular8x,
            imageWidth: kBookImageItemViewWidth150x,
            imageHeight: kImageHeight250x),
      ),
      Padding(
          padding: const EdgeInsets.only(left: kSP115x,top: kSP5x),
          child: GestureDetector(
            onTap: () {
              var temp = bookVO;

              context.getLibraryPageBloc().whenTappedFavIcon(
                  temp?.title ?? '', listsVO.listName ?? '');
            },
            child: CircleAvatar(
              backgroundColor: kWhite70Color,
              child: Icon(
                Icons.favorite,
                color: (bookVO?.isSelected ?? false)
                    ? kFavoriteColorRed
                    : kUnFavoriteColorAmber,
              ),
            ),
          ))
    ]);
  }
}