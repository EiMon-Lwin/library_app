import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/consts/colors.dart';
import 'package:library_app/consts/dimes.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/pages/shelf_page.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/easy_Text_widget.dart';

import '../consts/strings.dart';

class ShowBottomSheetWidget extends StatelessWidget {
  const ShowBottomSheetWidget({Key? key,required this.bookVO}) : super(key: key);

  final BooksVO bookVO;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDetailsBackgroundColor,
      height: kShowBottomSheetWidgetHeight230x,
      child: Column(
        children: [
          Card(
            color: kDetailsBackgroundColor,
            child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: bookVO.bookImage ??
                    kDefaultImageLink,
                imageBuilder: (context, imageProvider) => Container(
                  margin: const EdgeInsets.all(kSP20x),
                  width: kBottomSheetImageWidth50x,
                  height: kBottomSheetImageHeight80x,
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.only(top: kSP20x),
                       width: kBookTitleWidth250x,
                      height: kBookTitleHeight65x,
                      child: EasyTextWidget(text: bookVO.title?? '',fontWeight: kFontWeightBold,)),
                  const EasyTextWidget(text: kEbookText,textColor: kTabBarBlackColor,),
                ],
              )
              ]
            ),
          ),
          const SizedBox(height: kSP30x,),
          Padding(
            padding:  const EdgeInsets.only(
              left: kSP30x,
            ),
            child: Row(
              children:  [
                const Icon(Icons.add),
                const SizedBox(
                  width: kSP30x,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                    context.navigateToNextScreen(context, ShelfPage(booksVO: bookVO,));
                  },
                    child: const EasyTextWidget(text: kAddToShelfText,fontWeight: kFontWeightBold,))
              ],
            ),
          )
        ],
      ),
    );
  }
}
