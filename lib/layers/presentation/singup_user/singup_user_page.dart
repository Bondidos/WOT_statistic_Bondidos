import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/constants/constants.dart';
import '../../../common/theme/text_styles.dart';
import '../../domain/entities/user.dart';

const String status = "status";
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

/*

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
    bool _editing = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(SingUpPage.id, style: appBarTitle(context)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {

              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _editing
      ? Container()
      : const EasyWebView(
        key: ValueKey("sds"),
        src:  'https://vk.com/',
        isMarkdown: true, // Use markdown syntax
        convertToWidgets: false,
        convertToMarkdown: false,
        // convertToWidgets: false, // Try to convert to flutter widgets
        // width: 100,
        // height: 100,
      ),
    );
  }
}
*/
