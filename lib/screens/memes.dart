import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_generator/bloc/meme_bloc/meme_bloc.dart';
import 'package:meme_generator/widgets/app_bar.dart';
import 'package:meme_generator/widgets/progress.dart';

class Memes extends StatefulWidget {
  @override
  _MemesState createState() => _MemesState();
}

class _MemesState extends State<Memes> with AutomaticKeepAliveClientMixin {
  MemeBloc _bloc = MemeBloc();

  @override
  void initState() {
    _bloc.add(GetMemeImagesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: header(
        context,
        title: 'Select Meme Image',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _bloc.add(GetMemeImagesEvent());
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is GetMemeImagesLoading) {
              return circularProgress();
            } else if (state is GetMemeImagesLoaded) {
              return ListView(
                children: state.memes,
              );
            } else if (state is GetMemeImagesError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 50.0),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Could not load images.\nPlease check your internet connection and try again.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RaisedButton(
                          onPressed: () => _bloc.add(GetMemeImagesEvent()),
                          child: Text('Retry')),
                    ],
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
