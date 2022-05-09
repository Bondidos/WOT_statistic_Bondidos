import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';

const String status = "status";
const eu = "EU";
const cisLoginUrl =
    "https://api.worldoftanks.ru/wot/auth/login/?status=error&message=AUTH_CANCEL&code=401&application_id=5d489c586717c2b76ade8bea16607167&redirect_uri=https://developers.wargaming.net/reference/all/wot/auth/login/";
const euLoginUrl =
    'https://api.worldoftanks.eu/wot/auth/login/?status=error&message=AUTH_CANCEL&code=401&application_id=5d489c586717c2b76ade8bea16607167&redirect_uri=https://developers.wargaming.net/reference/all/wot/auth/login/';
const redirectUri =
    'https://developers.wargaming.net/reference/all/wot/auth/login/';
const baseUrlEu = 'https://api.worldoftanks.eu';
const baseUrlCis = 'https://api.worldoftanks.ru';
const httpStatusOk = 'ok';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const id = "OpenId login";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      WebView.platform = AndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String realm = ModalRoute.of(context)?.settings.arguments as String;
    //todo find out why keyboard is lagging

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).OpenIdSignUp, style: appBarTitle(context)),
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
        gestureNavigationEnabled: true,
        key: const ValueKey('webView'),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) {
          _controller = webViewController;
          _controller.clearCache();

          final cookieManager = CookieManager();
          cookieManager.clearCookies();
        },
        userAgent: 'random',
        initialUrl: (realm == eu) ? euLoginUrl : cisLoginUrl,
        onPageStarted: (url) {
          if (url.contains("access_token")) {
            Navigator.of(context).pop(User.fromUrl(url));
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
