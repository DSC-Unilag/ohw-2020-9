import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meme_generator/models/favourites.dart';
import 'package:meme_generator/screens/create_meme.dart';
import 'package:meme_generator/widgets/custom_image.dart';

class Meme extends StatefulWidget {
  final String id;
  final String url;
  final String name;
  final int boxCount;

  Meme({this.id, this.url, this.name, this.boxCount});

  factory Meme.fromResponse(response) {
    return Meme(
      id: response['id'],
      name: response['name'],
      url: response['url'],
      boxCount: response['box_count'],
    );
  }

  @override
  _MemeState createState() => _MemeState();
}

class _MemeState extends State<Meme> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    final favouritesBox = Hive.box('favourites');
    if (favouritesBox.containsKey(widget.id)) {
      setState(() {
        isFavourite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateMeme(
            id: widget.id,
            url: widget.url,
            name: widget.name,
            boxCount: widget.boxCount,
          ),
        ),
      ),
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: <Widget>[
                  Hero(tag: widget.name, child: cachedNetworkImage(widget.url)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                child: Center(
                  child: IconButton(
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                        final favouritesBox = Hive.box('favourites');
                        final favourite = Favourites(
                          id: widget.id,
                          url: widget.url,
                          name: widget.name,
                          boxCount: widget.boxCount,
                        );
                        if (!favouritesBox.containsKey(favourite.id)) {
                          favouritesBox.put(favourite.id, favourite);
                        } else {
                          favouritesBox.delete(favourite.id);
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
