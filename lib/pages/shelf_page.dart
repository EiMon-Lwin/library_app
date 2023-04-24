import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/shelf_page_bloc.dart';
import 'package:library_app/consts/dimes.dart';
import 'package:library_app/data/apply/library_app_apply.dart';
import 'package:library_app/data/apply/library_app_apply_impl.dart';
import 'package:library_app/data/vos/home_screen_api_vos/books_vo/books_vo.dart';
import 'package:library_app/data/vos/shelf_vos/shelf_vo.dart';
import 'package:library_app/persistent/shelf_dao/shelf_dao_impl.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/easy_Text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../consts/strings.dart';
import '../utils/images_assets.dart';

class ShelfPage extends StatelessWidget {
  const ShelfPage({Key? key, required this.booksVO}) : super(key: key);
  final BooksVO booksVO;

  @override
  Widget build(BuildContext context) {
    final ShelfDAOImpl shelfDaoImpl = ShelfDAOImpl();
    var keyList = shelfDaoImpl.getShelfVOBox().keys.toList();
    keyList.forEach((element) {});

    return ChangeNotifierProvider(
      create: (context) => ShelfPageBloc(),
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: kFloatingActionButtonWidth150x,
          child: FloatingActionButton(
            backgroundColor: kButtonLightBlueAccentColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    kFloatingActionButtonRadiusCircular25x)),
            onPressed: () {
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => ShelfPageBloc(),
                  child: Consumer<ShelfPageBloc>(
                    builder: (context, bloc, child) => Form(
                      key: bloc.getGlobalKey,
                      child: AlertDialog(
                        title: const EasyTextWidget(
                          text: kNewShelfText,
                        ),
                        content: SizedBox(
                          height: kShowDialogBoxHeight150x,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: context
                                    .getShelfPageBlocInstance()
                                    .getTextEditingController,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return kValidateText;
                                  }

                                  return null;
                                },
                                decoration:
                                    const InputDecoration(hintText: kHintText),
                              ),
                              const SizedBox(
                                height: kSP20x,
                              ),
                              const MaterialButtonWidget()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.edit,
                  color: kDetailsWhiteColor,
                ),
                SizedBox(
                  width: kSP5x,
                ),
                EasyTextWidget(
                  text: kAddToNewText,
                  textColor: kDetailsWhiteColor,
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: kDetailsWhiteColor,
          title: const EasyTextWidget(
            text: kAddToShelfText,
            fontWeight: kFontWeightBold,
          ),
          leading: GestureDetector(
              onTap: () {
                context.navigateBack(context);
              },
              child: const Icon(Icons.arrow_back_ios_rounded,
                  color: kTabBarBlackColor)),
        ),
        body: Selector<ShelfPageBloc, List<ShelfVO>>(
          selector: (_, bloc) => bloc.getShelfList,
          builder: (context, value, child) => (value.isEmpty)
              ? Center(child: Image.asset(kNoDataImageAssets))
              : ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          context
                              .getShelfPageBlocInstance()
                              .addBookToShelf(value[index], booksVO);
                          context.navigateBack(context);
                          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                              backgroundColor: kDetailsBackgroundColor,
                              content: EasyTextWidget(
                                  text: '${booksVO.title} $kSnackBarText'))));
                        },
                        child: ShelfItemView(
                          shelfVO: value[index],
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: kSP1x,
                      ),
                  itemCount: value.length),
        ),
      ),
    );
  }
}

class ShelfItemView extends StatelessWidget {
  const ShelfItemView({
    super.key,
    required this.shelfVO,
  });

  final ShelfVO shelfVO;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kDetailsBackgroundColor,
      child: Row(children: [
        CachedNetworkImage(
          imageUrl: (shelfVO.shelfBooks?.isEmpty ?? false)
              ? kDefaultImageLink
              : shelfVO.shelfBooks?.first.bookImage ?? '',
          imageBuilder: (context, imageProvider) => Container(
            margin: const EdgeInsets.all(kSP20x),
            width: kShelfImageWidth90x,
            height: kShelfImageHeight60x,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kImageBorderCircular8x),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(top: kSP20x),
                width: 80,
                height: kBookTitleHeight65x,
                child: EasyTextWidget(
                  text: shelfVO.shelfName ?? " ",
                  fontWeight: kFontWeightBold,
                )),
            EasyTextWidget(
              text: (shelfVO.shelfBooks?.isEmpty ?? false)
                  ? kEmptyText
                  : "${shelfVO.shelfBooks?.length} book"
                      .addS(shelfVO.shelfBooks?.length ?? 0),
              textColor: kTabBarBlackColor,
            ),
          ],
        )
      ]),
    );
  }
}

class MaterialButtonWidget extends StatelessWidget {
  const MaterialButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (context
                .getShelfPageBlocInstance()
                .getGlobalKey
                .currentState
                ?.validate() ??
            false) {
          context.getShelfPageBlocInstance().saveNewShelfVOList();
          context.navigateBack(context);
        }
      },
      color: kButtonLightBlueAccentColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.done,
            color: kDetailsWhiteColor,
          ),
          SizedBox(
            width: kSP5x,
          ),
          EasyTextWidget(
            text: kSaveText,
            textColor: kDetailsWhiteColor,
          )
        ],
      ),
    );
  }
}
