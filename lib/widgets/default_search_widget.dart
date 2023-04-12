import 'package:flutter/material.dart';
import 'package:library_app/widgets/easy_text_widget.dart';

import '../consts/dimes.dart';

class DefaultSearchItemView extends StatelessWidget {
  const DefaultSearchItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  const [
        SearchDefaultView(
          icon: Icons.add,
          label: 'Top Selling',
        ),
        SearchDefaultView(
          icon: Icons.notification_add,
          label: 'New Release',
        ),
        SearchDefaultView(
          icon: Icons.add_business,
          label: 'BookShop',
        ),
      ],
    );
  }
}

class SearchDefaultView extends StatelessWidget {
  const SearchDefaultView({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(kSP10x),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: kSP30x,
          ),
          EasyTextWidget(text: label)
        ],
      ),
    );
  }
}