import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_page_bloc.dart';

import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../consts/strings.dart';
import '../consts/dimes.dart';
import '../view_items/home_page_view_item.dart';

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
                    const SizedBox(
                      height: kSP30x,
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}


