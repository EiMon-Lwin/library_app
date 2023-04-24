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
            builder: (context, bloc, child) => Scaffold(
             key: scaffoldKey,

              body: Column(
               children:   [
                 const SizedBox(
                        height: kSP50x,
                      ),


                    Container(
                        margin:
                            const EdgeInsets.only(left: kSP5x, right: kSP10x),
                        padding: const EdgeInsets.only(left: kSP3x),
                        width: kTextFieldSizedWidth380x,
                        height: kTextFieldSizedHeight55x,
                        child: TextFieldWidget(
                          icon: const Icon(Icons.saved_search),
                          text: kHomePageHintText,
                        )),

                  const SizedBox(height: kSP10x,),
                       Expanded(
                         child: ListView(
                           children: [
                             Selector<HomePageBloc,List<BooksVO>>(
                               selector: (_, bloc) => bloc.getCarouselSliderList ,
                               builder: (context, books, child) =>
                               (books.isEmpty)? Container():
                               SizedBox(
                                 width: kCarouselSliderWidth350x,
                                 height: kCarouselSliderHeight230x,
                                 child: CarouselSlider.builder(
                                     options: CarouselOptions(
                                       viewportFraction: 0.6,
                                       initialPage: books.length-1,
                                       aspectRatio: 1,
                                       autoPlay: true,
                                       enableInfiniteScroll: false,
                                       enlargeCenterPage: true,
                                       scrollDirection: Axis.horizontal,
                                     ),
                                     itemCount: books.length,
                                     itemBuilder: (context, index, realIndex) =>
                                         Container(
                                           padding: const EdgeInsets.all(kSP5x),
                                           width: kCarouselSliderWidth230x,
                                           height: kCarouselSliderHeight200x,
                                           child: BooksView(
                                             listsName: books[index].bookListName ?? '',
                                             bookVo: books[index],
                                             scaffoldKey: scaffoldKey ,
                                           ),
                                         )
                                 ),
                               ),
                             ),
                             const SizedBox(
                               height: 5,
                             ),


                               (context.getHomePageBloc().getListsList.isEmpty)
                                   ? const Center(child: CircularProgressIndicator())
                                   : Column(
                                 children: context.getHomePageBloc().getListsList.map((listVo) =>
                                 BooksSessionItemView(listVO: listVo, scaffoldKey: scaffoldKey)
                                 ).toList(),
                               )



                           ],
                         ),
                       )






              ]
              ),
              ),
            ),
          ),
        );
  }
}


