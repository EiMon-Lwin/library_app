import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_page_bloc.dart';

import 'package:library_app/data/vos/home_screen_api_vos/lists_vo/lists_vo.dart';
import 'package:library_app/persistent/favorite_dao/favorite_dao.dart';
import 'package:library_app/persistent/lists_dao/lists_dao_impl.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/easy_text_widget.dart';
import 'package:library_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../consts/strings.dart';
import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../persistent/favorite_dao/favorite_dao_impl.dart';
import '../persistent/lists_dao/lists_dao.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (_) => HomePageBloc(),

      child: TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 1),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (_, opacity, child) => Opacity(
      opacity: opacity,
      child: child,
      ),
      child: Selector<HomePageBloc, List<ListsVO>>(
        selector: (_, bloc) => bloc.getListsList,
        builder: (context, value, child) => Scaffold(
          //        body: ListView(
          //          children: [
          //          Column(
          //  children: ,
          //  ),

          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: kSP50x,
              ),
              Container(
                  margin: const EdgeInsets.only(left: kSP10x),
                  padding: const EdgeInsets.only(left: kSP3x),
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
                    tabs: [Text(kEbooksString), Text(kAudioBooks)],
                    isScrollable: true,
                    labelColor: kTabBarBlackColor,
                    indicatorColor: kIndicatorColor,
                  )),
              (value.isEmpty)
                  ? const Center(child: Text("\nYour Data is Empty!"))
                  : Expanded(
                    child: BooksSessionItemView(
                        listsList: value,
                      ),
                  ),
            ],
          ),
          //]
          // ),
        ),
      ),
    )
    );
  }
}

class BooksSessionItemView extends StatelessWidget {
  const BooksSessionItemView({super.key, required this.listsList});

  final List<ListsVO> listsList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBookShelfHeight570x,
      child: ListView.separated(
        itemCount: listsList.length,
        separatorBuilder: (BuildContext context, int index) => Container(
          height: kSP10x,
        ),
        itemBuilder: (BuildContext context, int index) => SizedBox(
          height: kOneShelfHeight360x,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: kSP10x),
                height: kTitleHeight50x,
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
                listsVo: listsList[index] ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookImageView extends StatefulWidget {
  const BookImageView(
      {super.key, required this.listsVo,});

  final ListsVO listsVo;


  @override
  State<BookImageView> createState() => _BookImageViewState();
}

class _BookImageViewState extends State<BookImageView> {


  @override
  Widget build(BuildContext context) {

    ListsVO list=widget.listsVo;
    var temp=list.books;
    temp?.forEach((element) {
      print(" EI MON LWIN --------------->${element.isSelected}");
    });

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
                            height: kImageHeight240x,
                            child: Stack(children: [
                              GestureDetector(
                                onTap: () {
                                  context.navigateToNextScreen(
                                      context,
                                      DetailsPage(
                                        booksVO: widget.listsVo.books?[index],
                                      ));
                                  // var temp=booksList[index];
                                  // _bannerBooks.insert(0, temp);
                                },
                                child: CachedNetworkImage(
                                  imageUrl: widget.listsVo.books?[index].bookImage ??
                                      kDefaultImageLink,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
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
                                      var temp = widget.listsVo.books?[index];
                                      temp?.isSelected = true;
                                       context.getHomePageBloc().whenTappedFavIcon(temp?.title?? '', widget.listsVo.listId ?? 0);
                                     // _favoriteDAO.save(temp, widget.listTitle);
                                      setState(() {});
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white70,
                                      child: Icon(
                                        Icons.favorite,
                                        color: (widget.listsVo.books?[index].isSelected ??
                                                false)
                                            ? Colors.red
                                            : Colors.amber,
                                      ),
                                    ),
                                  ))
                            ]),
                          ),
                          const SizedBox(
                            height: kSP5x,
                          ),
                          SizedBox(
                            height: kTitleHeight50x,
                            child: Text(widget.listsVo.books?[index].title ?? ''),
                          )
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: kSP5x,
                    ),
                itemCount: widget.listsVo.books?.length ?? 5),
          );
  }
}
