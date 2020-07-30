import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:meme_generator/models/downloads.dart';
import 'package:meme_generator/widgets/app_bar.dart';
import 'package:meme_generator/widgets/no_content.dart';

class DownloadsPage extends StatefulWidget {
  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  bool deleteFileFromStorage = false;

  handleImageDelete(BuildContext context, {String path, int index}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return CheckboxListTile(
                value: deleteFileFromStorage,
                onChanged: (bool newValue) {
                  print(newValue);
                  setState(() {
                    deleteFileFromStorage = newValue;
                  });
                },
                title: Text('Delete image from storage?'),
              );
            }),
            actions: [
              FlatButton(
                onPressed: () {
                  if (deleteFileFromStorage) {
                    print('got hererere');
                    final dir = Directory(path);
                    dir.deleteSync(recursive: true);
                  }
                  final downloadsBox = Hive.box('downloads');
                  downloadsBox.deleteAt(index);
                  Navigator.pop(context);
                },
                child: Text('Confirm'),
              ),
            ],
          );
        });
  }

  Widget _buildListView() {
    return WatchBoxBuilder(
        box: Hive.box('downloads'),
        builder: (context, downloadsBox) {
          return downloadsBox.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.all(20.0),
                  itemCount: downloadsBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    final download = downloadsBox.getAt(index) as Downloads;
                    return GestureDetector(
                      onTap: () async {
                        await ImageDownloader.open(download.path);
                      },
                      child: Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10.0),
                          leading: Image.file(File(download.path)),
                          title: Text(download.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () async {
                                    await FlutterShare.shareFile(
                                      title: download.name,
                                      filePath: download.path,
                                    );
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => handleImageDelete(
                                  context,
                                  path: download.path,
                                  index: index,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : buildNoContent(context, text: 'No Downloads Yet!');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: 'My Downloads'),
      body: _buildListView(),
    );
  }
}
