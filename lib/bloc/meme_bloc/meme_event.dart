part of 'meme_bloc.dart';

abstract class MemeEvent extends Equatable {
  const MemeEvent();
}

class GetMemeImagesEvent extends MemeEvent {
  @override
  List<Object> get props => [];
}

class CreateMemeEvent extends MemeEvent {
  final String id;
  final String username;
  final String password;
  final String text0;
  final String text1;
  final String maxFontSize;
  final String font;
  CreateMemeEvent(
      {this.id,
      this.username,
      this.password,
      this.text0,
      this.text1,
      this.maxFontSize,
      this.font});
  @override
  List<Object> get props =>
      [id, username, password, text0, text1, maxFontSize, font];
}
