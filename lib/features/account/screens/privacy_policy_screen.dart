import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(
        title: "Privacy Policy",
        showSearchButton: false,
        showBackButton: true,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..loadRequest(Uri.parse("https://github.com/moh-afifi/privacy-policy/blob/main/pivacy-policy.md")),
      ),
    );
  }
}
