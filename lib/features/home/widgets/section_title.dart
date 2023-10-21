import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';


class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key,required this.title,required this.routeWidget}) : super(key: key);
  final String title;
  final Widget routeWidget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return routeWidget;
                  },
                ),
              ),
            child: const Text(
              "عرض الكل",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    ) ;
  }
}
