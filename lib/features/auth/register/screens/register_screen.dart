import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';
import 'package:wssal/features/auth/register/screens/second_view.dart';
import 'package:wssal/features/auth/register/screens/third_view.dart';
import 'package:wssal/features/auth/register/widgets/register_footer.dart';
import 'package:wssal/features/auth/register/widgets/register_header.dart';

import '../../../root/screens/root_screen.dart';
import '../widgets/register_dots_indicator.dart';
import 'first_view.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    return  GlobalScaffold(
      resizeToAvoidBottomInset: false,
      body: Selector<RegisterProvider, bool>(
        shouldRebuild: (previous, next) => previous != next,
        selector: (context, provider) => provider.loading,
        builder: (_, loading, __) {
          return ModalProgressHUD(
            inAsyncCall: loading,
            progressIndicator: const AppLoader(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  const RegisterHeader(),
                  //--------------------------------------------------
                  Selector<RegisterProvider, int>(
                    shouldRebuild: (previous, next) => previous != next,
                    selector: (context, provider) => provider.index,
                    builder: (_, index, __) {
                      return Expanded(
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          reverse: false,
                          pageSnapping: false,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: registerProvider.pageController,
                          onPageChanged: (val) => registerProvider.changeIndex(val),
                          children: <Widget>[
                            RegisterOne(
                              onPressed: () {
                                registerProvider.pageController.nextPage(
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                            RegisterTwo(
                              onPressed: () {
                                registerProvider.pageController.nextPage(
                                  duration:
                                      const Duration(milliseconds: 100),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                            RegisterThree(
                              onPressed: () {
                                registerProvider.register(context).then(
                                  (value) {
                                    if (value != null) {
                                      AppUtils.showSnackBar(context: context, message: value);
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          settings: const RouteSettings(name: "/Root"),
                                          builder: (context) {
                                            return const RootScreen();
                                          },
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Selector<RegisterProvider, int>(
                    shouldRebuild: (previous, next) => previous != next,
                    selector: (context, provider) => provider.index,
                    builder: (context, index, _) {
                      if (index == 0) {
                        return const RegisterDotIndicator(position: 0);
                      } else if (index == 1) {
                        return const RegisterDotIndicator(position: 1);
                      } else if (index == 2) {
                        return const RegisterDotIndicator(position: 2);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const RegisterFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
