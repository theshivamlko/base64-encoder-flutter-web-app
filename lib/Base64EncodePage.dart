import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:convert' as convert;

import 'package:base64_encode_decode/AppConstant.dart';
import 'package:base64_encode_decode/Base64Encoder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Base64EncodePage extends StatefulWidget {
  const Base64EncodePage({Key? key}) : super(key: key);

  @override
  _Base64EncodePageState createState() => _Base64EncodePageState();
}

class _Base64EncodePageState extends State<Base64EncodePage> {
  html.TextAreaElement plainTextAreaElement = html.TextAreaElement();
  html.TextAreaElement encodedTextAreaElement = html.TextAreaElement();
  html.FileUploadInputElement fileUploadInputElement = html.FileUploadInputElement();


    @override
    void initState() {
      super.initState();
      init();
    }

    @override
    Widget build(BuildContext context) {

      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Base64 Encode', style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold)),
                Divider(),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Enter the text to Base64 Encode',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              plainTextAreaElement.value = null;
                              encodedTextAreaElement.value = null;
                            },
                            icon: Icon(Icons.refresh)),
                        IconButton(
                            onPressed: () {
                              plainTextAreaElement.select();
                              html.document.execCommand("copy");
                            },
                            icon: Icon(Icons.copy))
                      ],
                    ),
                  ],
                ),
                Container(
                    height: 300,
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: HtmlElementView(viewType: plainTextAreaElement.name)),
                Padding(padding: EdgeInsets.all(20)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          height: 50,
                          color: buttonColor,
                          onPressed: () async {
                            if (plainTextAreaElement.value != null && plainTextAreaElement.value!.trim().isNotEmpty)
                              encodedTextAreaElement.text =
                              await Base64Encoder.encodeTextToBase64(plainTextAreaElement.value!.trim())
                                  .catchError((error) {});
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.cached,
                                color: Colors.white,
                              ),
                              Text(
                                "Base64 Encode",
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(20)),
                        Container(
                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: accentTextColor)),
                          child: MaterialButton(
                            height: 50,
                            color: Colors.white,
                            onPressed: () async {
                              html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
                              uploadInput.click();

                              uploadInput.onChange.listen((event) {
                                html.File file = uploadInput.files!.first;
                                html.FileReader reader = html.FileReader();
                                reader.readAsText(file);

                                reader.onLoadEnd.listen((event) {}).onData((data) async {
                                  plainTextAreaElement.value = reader.result.toString();
                                  encodedTextAreaElement.text =
                                  await Base64Encoder.encodeTextToBase64(plainTextAreaElement.value!)
                                      .catchError((error) {});
                                });
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.upload,
                                  color: accentTextColor,
                                ),
                                Padding(padding: EdgeInsets.all(5)),
                                Text(
                                  "File Upload",
                                  style: TextStyle(color: accentTextColor, fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    StreamBuilder<String>(
                        stream: Base64Encoder.resultStream.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text(
                              snapshot.error.toString(),
                              style: TextStyle(color: errorTextColor),
                            );
                          return Container(
                            height: 1,
                            width: 1,
                          );
                        }),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Output Text', style: TextStyle(color: textColor, fontSize: 18),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              encodedTextAreaElement.select();
                              html.document.execCommand("copy");
                            },
                            icon: Icon(Icons.copy))
                      ],
                    ),
                  ],
                ),
                Container(
                    height: 300,
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: HtmlElementView(viewType: encodedTextAreaElement.name)),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: accentTextColor)),
                    child: MaterialButton(
                      height: 50,
                      color: Colors.white,
                      onPressed: () async {
                        if(encodedTextAreaElement.value!=null)
                          html.AnchorElement()
                            ..href = '${Uri.dataFromString(encodedTextAreaElement.value!, mimeType: 'text/plain', encoding: convert.utf8)}'
                            ..download = 'base64-encode-navoki.com.txt'
                            ..style.display = 'none'
                            ..click();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cloud_download_sharp,
                            color: accentTextColor,
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            "Download",
                            style: TextStyle(color: accentTextColor, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void init() {
      plainTextAreaElement = html.TextAreaElement()
        ..required = true
        ..style.border = 'none';
      plainTextAreaElement.placeholder = 'Enter text to Encode';
      plainTextAreaElement.name = 'encoded-text-area';
      plainTextAreaElement.style.fontFamily = 'Open sans';
      plainTextAreaElement.style.fontSize = '16px';

      encodedTextAreaElement = html.TextAreaElement()
        ..required = true
        ..style.border = 'none';
      encodedTextAreaElement.placeholder = 'Encoded data';
      encodedTextAreaElement.name = 'text-area';
      encodedTextAreaElement.style.fontFamily = 'Open sans';
      encodedTextAreaElement.style.fontSize = '16px';

      fileUploadInputElement.name = 'file-upload';

      ui.platformViewRegistry.registerViewFactory(plainTextAreaElement.name, (int id) => plainTextAreaElement);
      ui.platformViewRegistry.registerViewFactory(encodedTextAreaElement.name, (int id) => encodedTextAreaElement);
      ui.platformViewRegistry.registerViewFactory(fileUploadInputElement.name!, (int id) => fileUploadInputElement);
    }
  }
