import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'Base64EncodePage.dart';
import 'Error404Page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(html.document.domain);
    print(html.document.baseUri);

    return MaterialApp(
      title: 'Base64 Encoder | Navoki.com',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'OpenSans'),
      home: html.document.domain!.isNotEmpty
          ? Base64EncodePage()
          : HtmlElementView(viewType: Error404Page.create().tagName),
    );
  }
}
