import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/utils/extension.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import '../pages/details_page.dart';
import '../widgets/easy_Text_widget.dart';
import '../widgets/show_bottom_sheet_widget.dart';

class BooksSessionItemView extends StatelessWidget {
  const BooksSessionItemView({super.key, required this.listsList,required this.scaffoldKey});

  final List<ListsVO> listsList;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
     physics:  const NeverScrollableScrollPhysics(),
      itemCount: listsList.length,

      separatorBuilder: (BuildContext context, int index) => Container(
        height: kSP10x,
      ),
      itemBuilder: (BuildContext context, int index) =>
      // SizedBox(
      //   height: kOneShelfHeight360x,
      //   child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: kSP10x),
              height: kTitleHeight60x,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  EasyTextWidget(
                    text: listsList[index].listName ?? '',
                    fontWeight: kFontWeightBold,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: kIconSize15x,
                  )
                ],
              ),
            ),
            BookImageView(
              listsVo: listsList[index],
              scaffoldKey: scaffoldKey,
            ),
          ],
        ),
     // ),
    );
  }
}

class BookImageView extends StatelessWidget {
   const BookImageView({
    super.key,
    required this.listsVo,
     required this.scaffoldKey,
  });

  final ListsVO listsVo;
   final GlobalKey<ScaffoldState> scaffoldKey;

   @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: kBookImageItemViewHeight300x,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.only(left: kSP10x),
              width: kBookImageItemViewWidth150x,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kImageHeight230x,
                    child: Stack(children: [

                      GestureDetector(
                        onTap: () {
                          context.navigateToNextScreen(
                              context,
                              DetailsPage(
                                booksVO: listsVo.books?[index],
                              ));

                          context.getHomePageBloc().showCarouselSlider(listsVo.books![index]);

                        },
                        onLongPress: (){


                          var sheetController=scaffoldKey.currentState?.showBottomSheet(
                                  (context) =>  ShowBottomSheetWidget(bookVO: listsVo.books![index],)
                          );
                          sheetController?.closed.then((value) => {});


                        },
                        child: CachedNetworkImage(
                          imageUrl: listsVo.books?[index].bookImage ??
                              kDefaultImageLink,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kImageBorderCircular8x),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator()),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              var temp = listsVo.books?[index];

                              context.getHomePageBloc().whenTappedFavIcon(
                                  temp?.title ?? '', listsVo.listName ?? '');
                            },

                            child: CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Icon(
                                Icons.favorite,
                                color: (listsVo.books?[index].isSelected ??
                                    false)
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
                    child: EasyTextWidget(
                        text: listsVo.books?[index].title ?? ''),
                  )
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: kSP5x,
            ),
            itemCount: listsVo.books?.length ?? 5),
      );
  }
}