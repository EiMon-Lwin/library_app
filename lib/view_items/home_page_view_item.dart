import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/network_image_widget.dart';
import 'package:provider/provider.dart';

import '../blocs/home_page_bloc.dart';
import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import '../pages/details_page.dart';
import '../widgets/easy_Text_widget.dart';
import '../widgets/show_bottom_sheet_widget.dart';
import '../widgets/text_field_widget.dart';

class CarouselSliderAndBookSessionItemView extends StatelessWidget {
  const CarouselSliderAndBookSessionItemView({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          CarouselSliderItemView(
            scaffoldKey: scaffoldKey,
            carouselImageWidth: kCarouselSliderWidth300x,
            carouselImageHeight: kCarouselSliderHeight250x,
          ),
          const SizedBox(
            height: kSP5x,
          ),
          (context.getHomePageBloc().getListsList.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: context
                      .getHomePageBloc()
                      .getListsList
                      .map((listVo) => Container(
                            margin: const EdgeInsets.only(
                                left: kSP5x, right: kSP5x),
                            child: BooksSessionItemView(
                              listsVO: listVo,
                              scaffoldKey: scaffoldKey,
                              bookImageHeight: kImageHeight250x,
                              bookImageWidth: kBookImageItemViewWidth150x,
                            ),
                          ))
                      .toList(),
                )
        ],
      ),
    );
  }
}

class CarouselSliderItemView extends StatelessWidget {
  const CarouselSliderItemView({
    super.key,
    required this.scaffoldKey,
    required this.carouselImageWidth,
    required this.carouselImageHeight,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final double carouselImageWidth;
  final double carouselImageHeight;

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<BooksVO>>(
      selector: (_, bloc) => bloc.getCarouselSliderList,
      builder: (context, books, child) => (books.isEmpty)
          ? Container()
          : SizedBox(
              width: kCarouselSliderWidth350x,
              height:
              kCarouselSliderHeight230x,
              child: CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 0.6,
                    initialPage: books.length - 1,
                    aspectRatio: 1,
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index, realIndex) => Container(
                        padding: const EdgeInsets.all(kSP5x),


                        child: BooksImageView(
                          listsName: books[index].bookListName ?? '',
                          bookVo: books[index],
                          scaffoldKey: scaffoldKey,
                          bookImageWidth: carouselImageWidth,
                          bookImageHeight: carouselImageHeight,
                          favoriteLeftPlace: kSP150x,
                          favoriteTopPlace: kSP5x,
                        ),
                      ))),
    );
  }
}

class SearchFieldItemView extends StatelessWidget {
  const SearchFieldItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: kSP5x, right: kSP10x),
        padding: const EdgeInsets.only(left: kSP3x),
        width: kTextFieldSizedWidth380x,
        height: kTextFieldSizedHeight55x,
        child: TextFieldWidget(
          icon: const Icon(Icons.saved_search),
          text: kHomePageHintText,
        ));
  }
}


class BooksSessionItemView extends StatelessWidget {
  const BooksSessionItemView(
      {Key? key,
      required this.listsVO,
      this.scaffoldKey,
      required this.bookImageHeight,
      required this.bookImageWidth})
      : super(key: key);

  final ListsVO listsVO;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final double bookImageHeight;
  final double bookImageWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookListNameView(listName: listsVO.listName ?? ''),
        BooksShowView(
          listsVo: listsVO,
          scaffoldKey: scaffoldKey,
          bookImageHeight: bookImageHeight,
          bookImageWidth: bookImageWidth,
        ),
      ],
    );
  }
}

class BookListNameView extends StatelessWidget {
  const BookListNameView({
    super.key,
    required this.listName,
  });

  final String listName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: kSP10x),
      height: kTitleHeight60x,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EasyTextWidget(
            text: listName ?? '',
            fontWeight: kFontWeightBold,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: kIconSize15x,
          )
        ],
      ),
    );
  }
}

class BooksShowView extends StatelessWidget {
  const BooksShowView({
    super.key,
    required this.listsVo,
    this.scaffoldKey,
    required this.bookImageHeight,
    required this.bookImageWidth,
  });

  final ListsVO listsVo;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final double bookImageHeight;
  final double bookImageWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBookImageItemViewHeight350x,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.only(left: kSP10x),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BooksImageView(
                      listsName: listsVo.listName ?? '',
                      scaffoldKey: scaffoldKey,
                      bookVo: listsVo.books![index],
                      bookImageWidth: bookImageWidth,
                      bookImageHeight: bookImageHeight, favoriteLeftPlace: kSP105x, favoriteTopPlace: kSP5x,
                    ),
                    const SizedBox(
                      height: kSP5x,
                    ),
                    SizedBox(
                      height: kTitleHeight60x,
                      width: kBookImageItemViewWidth150x,
                      child: EasyTextWidget(
                          text: listsVo.books?[index].title ?? ''),
                    )
                  ],
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: kSP1x,
              ),
          itemCount: listsVo.books?.length ?? 5),
    );
  }
}

class BooksImageView extends StatelessWidget {
  const BooksImageView(
      {super.key,
      required this.listsName,
      required this.bookVo,
       this.scaffoldKey,
      required this.bookImageWidth,
      required this.bookImageHeight, required this.favoriteLeftPlace, required this.favoriteTopPlace});

  final String listsName;
  final BooksVO bookVo;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final double bookImageWidth;
  final double bookImageHeight;
  final double favoriteLeftPlace;
  final double favoriteTopPlace;

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

            context
                .getHomePageBloc()
                .showCarouselSlider(bookVo, listsName ?? '');
          },
          onLongPress: () {
            var sheetController = scaffoldKey?.currentState
                ?.showBottomSheet((context) => ShowBottomSheetWidget(
                      bookVO: bookVo,
                    ));
            sheetController?.closed.then((value) => {});
          },
          child: Container(
            padding: const EdgeInsets.only(
              right: kSP10x,
            ),
            child: NetworkImageWidget(
              imgUrl: bookVo.bookImage ?? kDefaultImageLink,
              borderRadius: kImageBorderCircular8x,
              imageWidth: bookImageWidth,
              imageHeight: bookImageHeight,
            ),
          )),
      Padding(
          padding:  EdgeInsets.only(left: favoriteLeftPlace, top: favoriteTopPlace),
          child: GestureDetector(
            onTap: () {
              var temp = bookVo;

              context
                  .getHomePageBloc()
                  .whenTappedFavIcon(temp.title ?? '', listsName ?? '');
            },
            child: CircleAvatar(
              backgroundColor: kWhite70Color,
              child: Icon(
                Icons.favorite,
                color: (bookVo.isSelected ?? false)
                    ? kFavoriteColorRed
                    : kUnFavoriteColorAmber,
              ),
            ),
          ))
    ]);
  }
}
