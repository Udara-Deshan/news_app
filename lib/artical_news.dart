import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticles extends StatefulWidget {
  const NewsArticles({super.key, required this.newsUrl});
  final String newsUrl;
  @override
  _NewsArticlesState createState() => _NewsArticlesState();
}

class _NewsArticlesState extends State<NewsArticles> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  late bool _isLoadingPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Today News')),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.newsUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _completer.complete(controller);
            },
            onPageFinished: (String finish) =>
                setState(() => _isLoadingPage = false),
          ),
          if (_isLoadingPage)
            Container(
              alignment: FractionalOffset.center,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }
}
