import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';

import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../consts/strings.dart';
import '../consts/dimes.dart';
import '../view_items/home_page_view_item.dart';
import '../widgets/show_bottom_sheet_widget.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
          child: Consumer<HomePageBloc>(
            builder: (context, bloc, child) => DefaultTabController(
              length: 2,
              child: Scaffold(
               key: scaffoldKey,

                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                      const SizedBox(
                        height: kSP50x,
                      ),


                    Container(
                        margin:
                            const EdgeInsets.only(left: kSP5x, right: kSP10x),
                        padding: const EdgeInsets.only(left: kSP3x),
                        width: kTextFieldSizedWidth380x,
                        height: kTextFieldSizedHeight70x,
                        child: TextFieldWidget(
                          icon: const Icon(Icons.saved_search),
                          text: kHomePageHintText,
                        )),

                    // const SizedBox(
                    //   height: kSP10x,
                    // ),

                   Expanded(
                     child: ListView(
                       children: [
                        SizedBox(
                          height: 800,
                          child: Column(
                            children: [
                              Selector<HomePageBloc,List<BooksVO>>(
                                selector: (_, bloc) => bloc.getCarouselSliderList ,
                                builder: (context, books, child) =>
                                (books.isEmpty)? Container():
                                    Container(
                                  padding: EdgeInsets.all(5),
                                 // color: Colors.purpleAccent,
                                 // width: double.infinity,
                                  height: 280,
                                  child: CarouselSlider.builder(
                                    options: CarouselOptions(
                                     // initialPage: books,
                                      aspectRatio: 1,
                                      autoPlay: true,
                                      enableInfiniteScroll: false,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    itemCount: books.length,
                                    itemBuilder: (context, index, realIndex) =>
                                        SizedBox(
                                          width: 200,
                                          height: 150,
                                          child: Stack(children: [

                                            GestureDetector(

                                              onLongPress: (){


                                                var sheetController=scaffoldKey.currentState?.showBottomSheet(
                                                        (context) =>  ShowBottomSheetWidget(bookVO: books[index],)
                                                );
                                                sheetController?.closed.then((value) => {});


                                              },
                                              child: CachedNetworkImage(
                                                imageUrl: books[index].bookImage ??
                                                    kDefaultImageLink,
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
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


                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.white70,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: (books[index].isSelected ??
                                                          false)
                                                          ? kFavoriteColorRed
                                                          : kUnFavoriteColorAmber,
                                                    ),
                                                  ),
                                                ))
                                          ]),
                                        )
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: kSP50x,
                                child: TabBar(
                                  indicatorPadding: EdgeInsets.symmetric(vertical: 0.3),
                                  tabs: [Text(kEbooksString), Text(kAudioBooks)],
                                  unselectedLabelColor: kGreyColor,
                                  labelColor: kAmberColor,
                                ),
                              ),
                              Expanded(
                                child: TabBarView(children: [
                                  (context.getHomePageBloc().getListsList.isEmpty)
                                      ? const Center(child: CircularProgressIndicator())
                                      : BooksSessionItemView(
                                    listsList:
                                    context.getHomePageBloc().getListsList,
                                    scaffoldKey: scaffoldKey,
                                  ),
                                  Container()
                                ]),
                              ),
                            ],
                          ),
                        )
                       ],
                     ),
                   ),

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}


