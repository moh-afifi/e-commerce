import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      appBar: const GlobalAppBar(title: "المحفظة"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Center(
                    child: Text(
                      "300 جنيه",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "رصيد المحفظة",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondColor,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "رصيد النقاط:" " 160 نقطة ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.thirdColor,
                  fontSize: 20,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
