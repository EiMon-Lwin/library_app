import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/details_page_bloc.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/easy_Text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.booksVO}) : super(key: key);

  final BooksVO? booksVO;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailsPageBloc>(
      create: (context) => DetailsPageBloc(booksVO!),
      child: Consumer<DetailsPageBloc>(
        builder: (context, bloc, child) => Scaffold(
            backgroundColor: kDetailsBackgroundColor,
            appBar: AppBar(
              backgroundColor: kDetailsWhiteColor,
              centerTitle: true,
              title: EasyTextWidget(
                text: bloc.getBookName,
                textColor: kTabBarBlackColor,
                fontWeight: FontWeight.w400,
              ),
              leading: IconButton(
                onPressed: () {
                  context.navigateBack(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: kTabBarBlackColor,
                ),
              ),
              actions: const [
                Icon(
                  Icons.more_horiz,
                  color: kTabBarBlackColor,
                ),
                SizedBox(
                  width: kSP10x,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: kSP30x,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: kDetailsImageHeight300x,
                        width: kDetailsImageWidth200x,
                        child: CachedNetworkImage(
                          imageUrl: bloc.getImageLink,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      const SizedBox(
                        height: kSP30x,
                      ),
                      SizedBox(
                        width: kDetailsImageWidth200x,
                        height: kDetailsAuthorNameBoxHeight50x,
                        child: EasyTextWidget(
                          text: "Author : ${bloc.getAuthor}",
                          fontWeight: kFontWeightBold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: kSP55x),
                        child: const EasyTextWidget(
                          text: kDate,
                          fontWeight: kFontWeightBold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kSP30x,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: kSP10x),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.star,
                                color: kIndicatorColor,
                              ),
                              SizedBox(
                                width: kSP3x,
                              ),
                              EasyTextWidget(
                                text: kRate,
                              ),
                            ],
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const EasyTextWidget(
                          text: kRead,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const EasyTextWidget(
                          text: kPages,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kSP30x,
                  ),
                  Container(
                    padding: const EdgeInsets.all(kSP15x),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        EasyTextWidget(text: kOverViewText,fontWeight: kFontWeightBold,),
                        SizedBox(height: kSP20x,),
                        EasyTextWidget(
                            text: kOverView
                        )
                      ],
                    ),
                  ),
                  Row(


                    children: [
                      const SizedBox(width: kSP8ox,),
                      OutlinedButton(onPressed: (){}, child:  const Icon(Icons.bookmarks_sharp,color: kTabBarBlackColor,)),
                      const SizedBox(width: kSP50x,),
                      OutlinedButton(onPressed: (){}, child: const Icon(Icons.download,color: kTabBarBlackColor,))

                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
