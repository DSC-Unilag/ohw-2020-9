import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_generator/bloc/meme_bloc/meme_bloc.dart';
import 'package:meme_generator/screens/download.dart';
import 'package:meme_generator/widgets/custom_image.dart';
import 'package:meme_generator/widgets/progress.dart';

class CreateMeme extends StatefulWidget {
  final String id;
  final String url;
  final String name;
  final int boxCount;
  CreateMeme({this.id, this.url, this.name, this.boxCount});

  @override
  _CreateMemeState createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> {
  String font = 'impact';
  double maxFontSize = 50.0;
  final String username = 'jabguru';
  final String password = '#Jagabany007';
  bool _isGenerating = false;
  TextEditingController topTextController = TextEditingController();
  TextEditingController bottomTextController = TextEditingController();
  MemeBloc _bloc = MemeBloc();

  handleGenerate() {
    if (!(topTextController.text.trim().isEmpty &&
        bottomTextController.text.trim().isEmpty)) {
      setState(() {
        _isGenerating = true;
      });
      _bloc.add(CreateMemeEvent(
        id: widget.id,
        username: username,
        password: password,
        text0: topTextController.text,
        text1: bottomTextController.text,
        maxFontSize: maxFontSize.toString(),
        font: font,
      ));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error Generationg Meme'),
              content:
                  Text('You must input at least one text (Text1 or Text2).'),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close')),
              ],
            );
          });
    }
  }

  buildCreateScreen() {
    return Column(
      children: <Widget>[
        _isGenerating ? linearProgress() : SizedBox.shrink(),
        Expanded(
          child: ListView(
            children: <Widget>[
              Hero(
                tag: widget.name,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.48,
                  child: ListView(
                    children: <Widget>[
                      cachedNetworkImage(widget.url),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: ListTile(
                  leading: Icon(Icons.text_fields),
                  title: Container(
                    width: 250.0,
                    child: TextField(
                      controller: topTextController,
                      decoration: InputDecoration(
                        hintText: 'Text 1',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.text_fields),
                title: Container(
                  width: 250.0,
                  child: TextField(
                    controller: bottomTextController,
                    decoration: InputDecoration(
                      hintText: 'Text 2',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.font_download),
                subtitle: Text('Font Family'),
                title: DropdownButton(
                    value: font,
                    items: [
                      DropdownMenuItem(
                        child: Text('Impact'),
                        value: 'impact',
                      ),
                      DropdownMenuItem(
                        child: Text('Arial'),
                        value: 'arial',
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        font = value;
                      });
                    }),
              ),
              Divider(),
              Stack(
                children: [
                  ListTile(
                    leading: Icon(Icons.format_list_numbered),
                    title: Text(''),
                    subtitle: Text(
                      'Font Size',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Slider(
                              value: maxFontSize,
                              min: 10.0,
                              max: 100.0,
                              onChanged: (value) {
                                setState(() {
                                  maxFontSize = value;
                                });
                              }),
                        ),
                        Text(
                          maxFontSize.toInt().toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: <Widget>[
          Transform.rotate(
            angle: -0.6,
            child: IconButton(
              onPressed: _isGenerating ? null : handleGenerate,
              icon: Icon(Icons.send),
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is CreateMemeLoaded) {
            setState(() {
              _isGenerating = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DownloadMeme(state.url),
              ),
            );
          } else if (state is CreateMemeError) {
            setState(() {
              _isGenerating = false;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error Generationg Meme'),
                    content: Text(
                        'Please check your internet connection and try again.'),
                    actions: [
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close')),
                    ],
                  );
                });
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            return buildCreateScreen();
          },
        ),
      ),
    );
  }
}
