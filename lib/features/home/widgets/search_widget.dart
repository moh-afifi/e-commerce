import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/search/screens/search_screen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const SearchScreen();
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ابحث عن منتجات..',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.barcode,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
