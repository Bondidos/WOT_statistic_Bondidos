import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wot_statistic/common/constants.dart';
import 'package:wot_statistic/common/text_styles.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';

const cisLoginUrl =
    "https://api.worldoftanks.ru/wot/auth/login/?status=error&message=AUTH_CANCEL&code=401&application_id=5d489c586717c2b76ade8bea16607167&redirect_uri=https://developers.wargaming.net/reference/all/wot/auth/login/";
const euLoginUrl =
    'https://api.worldoftanks.eu/wot/auth/login/?status=error&message=AUTH_CANCEL&code=401&application_id=5d489c586717c2b76ade8bea16607167&redirect_uri=https://developers.wargaming.net/reference/all/wot/auth/login/';
const accessToken = "access_token";

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const id = "OpenId login";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String realm = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).OpenIdSignUp, style: appBarTitle(context)),
        actions: [
          IconButton(
            onPressed: () {
              _controller.goBack();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: () {
              _controller.reload();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        children: [
          buildWebView(realm, context),
          Center(
            child: isLoading ? const CircularProgressIndicator() : Stack(),
          ),
        ],
      ),
    );
  }

  WebView buildWebView(String realm, BuildContext context) {
    return WebView(
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
      onProgress: (progress) {
        setState(() {
          if (progress == 100) isLoading = false;
        });
      },
      onPageStarted: (url) {
        if (url.contains(accessToken)) {
          Navigator.of(context).pop(User.fromUrl(url));
        }
      },
    );
  }
}
