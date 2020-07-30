import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meme_generator/models/meme.dart';
import 'package:meme_generator/networking.dart';

part 'meme_event.dart';
part 'meme_state.dart';

class MemeBloc extends Bloc<MemeEvent, MemeState> {
  MemeBloc() : super(GetMemeImagesInitial());

  @override
  Stream<MemeState> mapEventToState(
    MemeEvent event,
  ) async* {
    if (event is GetMemeImagesEvent) {
      yield GetMemeImagesLoading();
      try {
        var memeResponse = await getMemes();
        List<Meme> memes = [];
        memeResponse.forEach((response) {
          if (response['box_count'] == 2) {
            memes.add(Meme.fromResponse(response));
          }
        });
        yield GetMemeImagesLoaded(memes);
      } catch (e) {
        yield GetMemeImagesError(e.toString());
      }
    } else if (event is CreateMemeEvent) {
      yield CreateMemeLoading();
      try {
        String url = await generateMeme(
          id: event.id,
          username: event.username,
          password: event.password,
          text0: event.text0,
          text1: event.text1,
          maxFontSize: event.maxFontSize,
          font: event.font,
        );
        yield CreateMemeLoaded(url);
      } catch (e) {
        yield CreateMemeError(e.toString());
      }
    }
  }
}
