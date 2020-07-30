part of 'meme_bloc.dart';

abstract class MemeState extends Equatable {
  const MemeState();
}

class GetMemeImagesInitial extends MemeState {
  @override
  List<Object> get props => [];
}

class GetMemeImagesLoading extends MemeState {
  @override
  List<Object> get props => [];
}

class GetMemeImagesLoaded extends MemeState {
  final List<Meme> memes;
  GetMemeImagesLoaded(this.memes);
  @override
  List<Object> get props => [memes];
}

class GetMemeImagesError extends MemeState {
  final String message;
  GetMemeImagesError(this.message);
  @override
  List<Object> get props => [message];
}

class CreateMemeInitial extends MemeState {
  @override
  List<Object> get props => [];
}

class CreateMemeLoading extends MemeState {
  @override
  List<Object> get props => [];
}

class CreateMemeLoaded extends MemeState {
  final String url;
  CreateMemeLoaded(this.url);
  @override
  List<Object> get props => [url];
}

class CreateMemeError extends MemeState {
  final String message;
  CreateMemeError(this.message);
  @override
  List<Object> get props => [message];
}
