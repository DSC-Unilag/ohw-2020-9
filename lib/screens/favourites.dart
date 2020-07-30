import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meme_generator/models/favourites.dart';
import 'package:meme_generator/screens/create_meme.dart';
import 'package:meme_generator/widgets/app_bar.dart';
import 'package:meme_generator/widgets/custom_image.dart';
import 'package:meme_generator/widgets/no_content.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  Widget _buildListView() {
    return WatchBoxBuilder(
        box: Hive.box('favourites'),
        builder: (context, favouritesBox) {
          return favouritesBox.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.all(20.0),
                  itemCount: favouritesBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    final favourite = favouritesBox.getAt(index) as Favourites;
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateMeme(
                            id: favourite.id,
                            url: favourite.url,
                            name: favourite.name,
                            boxCount: favourite.boxCount,
                          ),
                        ),
                      ),
                      child: Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10.0),
                          leading: cachedNetworkImage(favourite.url),
                          title: Text(favourite.name),
                          trailing: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              favouritesBox.deleteAt(index);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              : buildNoContent(context, text: 'No Favourites Yet!');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: 'My Favourites'),
      body: _buildListView(),
    );
  }
}
