import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/utils/extension.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import '../utils/images_assets.dart';
import '../widgets/easy_Text_widget.dart';

class LibraryBooksItemView extends StatelessWidget {
  const LibraryBooksItemView({Key? key, required this.updatedLists})
      : super(key: key);
  final List<ListsVO> updatedLists;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
          itemCount: updatedLists.length,
          itemBuilder: (context, index) {
            if (index == 0 ||
                !updatedLists[index - 1]
                    .books!
                    .any((bookVO) => bookVO.isSelected == true)) {
              return Visibility(
                visible: updatedLists[index]
                    .books!
                    .any((bookVO) => bookVO.isSelected == true),
                child: Container(
                  margin: const EdgeInsets.only(left: kSP5x),
                  padding: const EdgeInsets.only(left: kSP5x),
                  height: kFavoriteBookSessionHeight355x,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EasyTextWidget(
                        text:  updatedLists[index].listName ?? '',
                        fontWeight: kFontWeightBold,
                      ),


                      const SizedBox(height: kSP8x),
                      FavoriteBookItemView(listsVO: updatedLists[index]),
                      const SizedBox(height: kSP8x),
                    ],
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: updatedLists[index]
                    .books!
                    .any((bookVO) => bookVO.isSelected == true),
                child: Container(
                  margin: const EdgeInsets.only(left: kSP5x),
                  padding: const EdgeInsets.only(left: kSP5x),
                  height: kFavoriteBookSessionHeight355x,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EasyTextWidget(
                        text:  updatedLists[index].listName ?? '',
                        fontWeight: kFontWeightBold,
                      ),

                      const SizedBox(height: kSP8x),
                      FavoriteBookItemView(listsVO: updatedLists[index]),
                      const SizedBox(height: kSP8x),
                    ],
                  ),
                ),
              );
            }
          }),
      Visibility(
          visible: updatedLists.every((list) =>
              list.books!.every((book) => !(book.isSelected ?? false))),
          child: Center(child: Image.asset(kNoDataImageAssets)))
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
              SizedBox(
                height: kCachedNetworkImageHeight250x,
                width: kCachedNetworkImageWidth150x,
                child: Stack(children: [
                  CachedNetworkImage(
                    imageUrl: bookVO?.bookImage ?? kDefaultImageLink,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadiusCircular8x),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          var temp = bookVO;

                          context.getLibraryPageBloc().whenTappedFavIcon(
                              temp?.title ?? '', listsVO.listName ?? '');
                        },
                        child: CircleAvatar(
                          backgroundColor: kDetailsWhiteColor,
                          child: Icon(
                            Icons.favorite,
                            color: (bookVO?.isSelected ?? false)
                                ? kFavoriteColorRed
                                : kUnFavoriteColorAmber,
                          ),
                        ),
                      ))
                ]),
              ),
              const SizedBox(
                height: kSP5x,
              ),
              SizedBox(
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