import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Base64EncoderDecoder.dart';

class Base64EncodeDecodePage extends StatefulWidget {
  const Base64EncodeDecodePage({Key? key}) : super(key: key);

  @override
  _Base64EncodeDecodePageState createState() => _Base64EncodeDecodePageState();
}

class _Base64EncodeDecodePageState extends State<Base64EncodeDecodePage> {
  html.TextAreaElement encodedTextAreaElement = html.TextAreaElement();
  html.TextAreaElement textAreaElement = html.TextAreaElement();
  int p = 1;

  @override
  void initState() {
    super.initState();
    encodedTextAreaElement = html.TextAreaElement()
      ..required = true
      ..style.border = 'none';
    encodedTextAreaElement.placeholder = 'Enter base64 Encoded data';
    encodedTextAreaElement.name = 'encoded-text-area';

    textAreaElement = html.TextAreaElement()
      ..required = true
      ..style.border = 'none';
    textAreaElement.placeholder = 'Decoded data';
    textAreaElement.name = 'text-area';

    ui.platformViewRegistry.registerViewFactory(encodedTextAreaElement.name, (int id) => encodedTextAreaElement);
    ui.platformViewRegistry.registerViewFactory(textAreaElement.name, (int id) => textAreaElement);
    print("11111");
  }

  @override
  Widget build(BuildContext context) {
    print("22222");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Base642 Encode', style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold)),
            Padding(padding: EdgeInsets.all(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Enter the text to Base64 Encode'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [IconButton(onPressed: () {}, icon: Icon(Icons.copy))],
                ),
              ],
            ),
            Container(
                height: 300,
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: HtmlElementView(viewType: encodedTextAreaElement.name)),
            Padding(padding: EdgeInsets.all(20)),
            Row(
              children: [
                MaterialButton(
                  height: 50,
                  color: Colors.lightGreen,
                  onPressed: ()async {
                    print('MaterialButton ${encodedTextAreaElement.value}');
                    if(encodedTextAreaElement.value!=null && encodedTextAreaElement.value!.trim().isNotEmpty)
                      textAreaElement.text=(await Base64EncodeDecode.decodeBase64ToText(encodedTextAreaElement.value!));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cached,
                        color: Colors.white,
                      ),
                      Text(
                        "Base64 Decode",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Output Text'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [IconButton(onPressed: () {}, icon: Icon(Icons.copy))],
                ),
              ],
            ),
            Container(
                height: 300,
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: HtmlElementView(viewType: textAreaElement.name)),
          ],
        ),
      ),
    );
  }
}
