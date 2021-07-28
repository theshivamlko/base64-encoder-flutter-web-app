import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'Base64EncodePage.dart';
import 'Error404Page.dart';
import 'AppConstant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Base64 Encoder | Navoki.com',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'OpenSans'),
      home: html.document.domain==domain
          ? Base64EncodePage()
          : HtmlElementView(viewType: Error404Page.create().tagName),
    );
  }
}
