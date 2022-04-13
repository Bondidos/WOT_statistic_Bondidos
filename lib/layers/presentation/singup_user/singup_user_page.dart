import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/constants.dart';
import '../../../common/theme/text_styles.dart';

const String status = "status";

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);
  static const id = "OpenId login";

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {


  @override
  Widget build(BuildContext context) {
    String realm = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(SingUpPage.id, style: appBarTitle(context)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: EasyWebView(
        src:  (realm == EU) ? EU_LOGIN_URL : CIS_LOGIN_URL,
        // isMarkdown: false, // Use markdown syntax
        // convertToWidgets: false, // Try to convert to flutter widgets
        // width: 100,
        // height: 100,
      ),
    );
  }
}

/*
class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);
  static const id = "OpenId login";

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  late final WebViewController _controller;

  @override
  void initState() {

    if (defaultTargetPlatform == TargetPlatform.android) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String realm = ModalRoute.of(context)!.settings.arguments as String;
//todo find out why keyboard is lagging

    return Scaffold(
      appBar: AppBar(
        title: Text(SingUpPage.id, style: appBarTitle(context)),
        actions: [
          IconButton(
            onPressed: () {
              _controller.reload();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) {
          _controller = webViewController;
          _controller.clearCache();

          final cookieManager = CookieManager();
          cookieManager.clearCookies();
        },
        userAgent: 'random',
        initialUrl: (realm == EU) ? EU_LOGIN_URL : CIS_LOGIN_URL,
        onPageStarted: (url) {
          if (url.contains(REDIRECT_URL)) {
            Map<String, String> response = Uri.splitQueryString(url);
            String? status = response["status"];
            if (status == "ok") {
              User result = User(
                id: int.parse(response["account_id"]!),
                nickname: response["nickname"]!,
                accessToken: response["access_token"]!,
                expiresAt: int.parse(response["expires_at"]!),
              );
              Navigator.of(context).pop(result);
            } else {
              Navigator.of(context).pop();
            }
          }
        },
      ),
    );
  }
}
*/
