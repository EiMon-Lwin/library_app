import 'package:flutter/material.dart';
import 'package:library_app/blocs/search_page_bloc.dart';
import 'package:library_app/utils/extension.dart';
import 'package:library_app/widgets/easy_image_widget.dart';
import 'package:library_app/widgets/easy_text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../data/vos/search_api_vos/items_vo/items_vo.dart';
import '../data/vos/search_api_vos/volume_info_vo/volume_info_vo.dart';
import '../widgets/default_search_widget.dart';
import '../widgets/search_books_widget.dart';

class SearchItemView extends StatelessWidget {
  const SearchItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
           GestureDetector(
             onTap: (){
               context.navigateBack(context);
             },
               child: const Icon(Icons.arrow_back_ios_sharp)),
          const SizedBox(
            width: kSP30x,
          ),
          SizedBox(width: kSearchTextFieldWidth290x,
            child: Selector<SearchPageBloc,String>(
              selector: (_,select)=> select.getHistory,
              builder: (_,history,child)=>
               SearchMovieWidget(
                isAutoFocus: true,
                isEnable: true,
                onChange: (text)=>context.getSearchPageBlocInstance().search(text),
                controller: context.getSearchPageBlocInstance().getSearchEditingController,

              ),
            )
          ),
        ],
      ),
    );
  }
}

class SearchListView extends StatelessWidget {
  const SearchListView({Key? key, required this.items}) : super(key: key);

  final List<ItemsVO> items;
  @override
  Widget build(BuildContext context) {
    return (items.isEmpty)
        ? Selector<SearchPageBloc, List<String>?>(
        selector: (_, selector) => selector.getSearchHistory,
        builder: (_, searchHistory, __) {
          if (searchHistory == null) {
            return const DefaultSearchItemView();
          }
          if (searchHistory.isEmpty) {
            return const DefaultSearchItemView();
          }
          return ListView(
            children: [
              Column(
                children: searchHistory
                    .map((e) => GestureDetector(
                    onTap: () => context
                        .getSearchPageBlocInstance()
                        .searchByHistory(e),
                    child:
                    SearchDefaultView(icon: Icons.history, label: e)))
                    .toList()
                    .reversed
                    .toList(),
              ),
              const DefaultSearchItemView(),
            ],
          );
        })
        : Selector<SearchPageBloc, bool>(
      selector: (_, selector) => selector.getIsSearching,
      builder: (_, isSearching, __) => isSearching
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
          itemCount: items.length,
          itemBuilder: ((context, index) {
            return SearchListViewItem(
              volumeInfoVO: items[index].volumeInfo!,
            );
          })),
    );
  }
}

class SearchListViewItem extends StatelessWidget {
  const SearchListViewItem({
    Key? key,
    required this.volumeInfoVO,
  }) : super(key: key);

  final VolumeInfoVO volumeInfoVO;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(kSP10x),
        child: ListTileFake(
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(kSP15x)),
            child: EasyImageWidget(
              imgUrl: volumeInfoVO.imageLinks?.thumbnail ?? '',
            ),
          ),
          title: volumeInfoVO.title ?? '',
          subTitle: volumeInfoVO.printType ?? '',
        ));
  }
}

class ListTileFake extends StatelessWidget {
  const ListTileFake(
      {Key? key,
        required this.leading,
        required this.title,
        required this.subTitle})
      : super(key: key);

  final Widget leading;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leading,
        const SizedBox(
          width: kSP3x,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EasyTextWidget(text: title),
              const SizedBox(
                height: kSP10x,
              ),
              EasyTextWidget(
                text: subTitle,
                textColor: kTabBarBlackColor,
              )
            ],
          ),
        )
      ],
    );
  }
}