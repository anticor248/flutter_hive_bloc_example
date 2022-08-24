import 'package:flutter_hive_bloc/models/movie_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  String boxName = 'favorite_movies';

  Future<Box> openBox() async {
    Box box = await Hive.openBox<Movie>(boxName);
    return box;
  }

  List<Movie> getMovies(Box box) {
    return box.values.toList().cast<Movie>();
  }

  Future<void> addMovie(Box box, Movie movie) async {
    await box.put(movie.id, movie);
  }

  Future<void> updateMovie(Box box, Movie movie) async {
    await box.put(movie.id, movie);
  }

  Future<void> deleteMovie(Box box, Movie movie) async {
    await box.delete(movie.id);
  }

  Future<void> deleteAllMovie(Box box, Movie movie) async {
    await box.clear();
  }
}
