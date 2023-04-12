
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_page_bloc.dart';
import 'package:library_app/blocs/search_page_bloc.dart';
import 'package:library_app/blocs/shelf_page_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/library_page_bloc.dart';

extension ContextExtension on BuildContext{
  HomePageBloc getHomePageBloc()=> read<HomePageBloc>();
  LibraryPageBloc getLibraryPageBloc() => read<LibraryPageBloc>();
  SearchPageBloc getSearchPageBlocInstance() => read<SearchPageBloc>();
  ShelfPageBloc getShelfPageBlocInstance() => read<ShelfPageBloc>();

  Future navigateToNextScreen(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextScreen));

  void navigateBack(BuildContext context) => Navigator.of(context).pop();



}

extension StringExtensions on String {
  String addS() {
    if (length <= 1) {
      return this;
    }
    return '${this}s';
  }
}