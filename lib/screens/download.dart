import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:meme_generator/models/downloads.dart';
import 'package:meme_generator/screens/home.dart';
import 'package:meme_generator/widgets/app_bar.dart';
import 'package:meme_generator/widgets/custom_image.dart';
import 'package:meme_generator/widgets/progress.dart';

class DownloadMeme extends StatefulWidget {
  final String url;

  DownloadMeme(this.url);

  @override
  _DownloadMemeState createState() => _DownloadMemeState();
}

class _DownloadMemeState extends State<DownloadMeme> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isDownloading = false;

  downloadMeme() async {
    setState(() {
      isDownloading = true;
    });
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(widget.url);

      if (imageId == null) {
        return;
      }

      var fileName = await ImageDownloader.findName(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var path = await ImageDownloader.findPath(imageId);

      final downloadsBox = Hive.box('downloads');
      final download = Downloads(
        id: imageId,
        name: fileName,
        size: size,
        path: path,
      );
      downloadsBox.add(download);

      ImageDownloader.callback(onProgressUpdate: (String var1, int progress) {
        setState(() {
          if (progress == 100) {
            var snackbar = SnackBar(
                content: Text(
                    '$fileName downloaded successfully! (${size / 1000} kb)'));
            _scaffoldKey.currentState.showSnackBar(snackbar);
          }
        });
      });
    } on PlatformException catch (error) {
      print(error);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error Downloading Meme'),
                content: Text(
                    'Please check your internet connection and try again.'),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close')),
                ],
              ));
    }
    setState(() {
      isDownloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, title: 'Download Meme', hasLeading: true),
      body: Column(
        children: <Widget>[
          isDownloading ? linearProgress() : SizedBox.shrink(),
          Expanded(
            child: ListView(
              children: <Widget>[
                cachedNetworkImage(widget.url),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: isDownloading ? null : downloadMeme,
                  child:
                      Text('Download', style: TextStyle(color: Colors.white)),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home())),
                  child: Text('Home', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
