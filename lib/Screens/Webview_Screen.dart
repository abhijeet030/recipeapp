import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppWebView extends StatefulWidget {
  final String url;
  final String name;

  MyInAppWebView({required this.url, required this.name});

  @override
  _MyInAppWebViewState createState() => _MyInAppWebViewState();
}

class _MyInAppWebViewState extends State<MyInAppWebView> {
  late final InAppWebViewController _controller;
  bool _isLoadingPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
              ),
            ),
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                _isLoadingPage = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoadingPage = false;
              });
            },
          ),
          if (_isLoadingPage)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
