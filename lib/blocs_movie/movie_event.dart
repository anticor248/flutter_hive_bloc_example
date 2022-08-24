part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class LoadMovies extends MovieEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

abstract class DeleteAllMovies extends MovieEvent {}

class UpdateMovie extends MovieEvent {
  final Movie movie;

  const UpdateMovie({required this.movie});

  @override
  List<Object> get props => [movie];
}

class AddMovie extends MovieEvent {
  final Movie movie;

  const AddMovie({required this.movie});

  @override
  List<Object> get props => [movie];
}

class DeleteMovie extends MovieEvent {
  final Movie movie;

  const DeleteMovie({required this.movie});

  @override
  List<Object> get props => [movie];
}
