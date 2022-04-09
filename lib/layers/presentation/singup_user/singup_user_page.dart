import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';

import '../../../common/constants/constants.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);
  static const id = "OpenId login";

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String realm = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text(SingUpPage.id),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: WebView(
        initialCookies: [],
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
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
