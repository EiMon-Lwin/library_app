import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/utils/extension.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import '../pages/details_page.dart';
import '../widgets/easy_Text_widget.dart';
import '../widgets/show_bottom_sheet_widget.dart';

class BooksSessionItemView extends StatelessWidget {
  const BooksSessionItemView({super.key, required this.listVO,required this.scaffoldKey});

  final ListsVO listVO;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return BookItemView(
      listsVO: listVO,
      scaffoldKey: scaffoldKey,
    );




  }
}

class BookItemView extends StatelessWidget {
  const BookItemView({Key? key,required this.listsVO,required this.scaffoldKey}) : super(key: key);

  final ListsVO listsVO;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                text: listsVO.listName ?? '',
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
          listsVo: listsVO,
          scaffoldKey: scaffoldKey,
        ),
      ],
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
                    child: BooksView(listsName: listsVo.listName?? '', scaffoldKey: scaffoldKey, bookVo: listsVo.books![index] ,),
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

class BooksView extends StatelessWidget {
  const BooksView({
    super.key,
    required this.listsName,
    required this.bookVo,
    required this.scaffoldKey,
  });

  final String listsName;
  final BooksVO bookVo;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [

      GestureDetector(
        onTap: () {


          context.navigateToNextScreen(
              context,
              DetailsPage(
                booksVO: bookVo,
              ));

          context.getHomePageBloc().showCarouselSlider(bookVo,listsName ?? '');

        },
        onLongPress: (){


          var sheetController=scaffoldKey.currentState?.showBottomSheet(
                  (context) =>  ShowBottomSheetWidget(bookVO: bookVo,)
          );
          sheetController?.closed.then((value) => {});


        },
        child: CachedNetworkImage(
          imageUrl: bookVo.bookImage ??
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

              var temp = bookVo;

              context.getHomePageBloc().whenTappedFavIcon(
                  temp.title ?? '', listsName ?? '');


            },

            child: CircleAvatar(
              backgroundColor: kWhite70Color,
              child: Icon(
                Icons.favorite,
                color: (bookVo.isSelected ??
                    false)
                    ? kFavoriteColorRed
                    : kUnFavoriteColorAmber,
              ),
            ),
          ))
    ]);
  }
}