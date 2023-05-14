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
        child: Consumer<HomePageBloc>(
          builder: (context, bloc, child) => Scaffold(
            key: bloc.getScaffoldKey,
            body: Column(children:  [
              const SizedBox(
                height: kSP50x,
              ),
              const SearchFieldItemView(),
              const SizedBox(
                height: kSP10x,
              ),
              CarouselSliderAndBookSessionItemView(scaffoldKey: bloc.getScaffoldKey,)
            ]),
          ),
        ),
      ),
    );
  }
}

