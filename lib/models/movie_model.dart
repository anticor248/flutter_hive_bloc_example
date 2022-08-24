import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class Movie extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final bool addedToWatchList;

  const Movie({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.addedToWatchList,
  });

  Movie copyWith({
    String? id,
    String? name,
    String? imageUrl,
    bool? addedToWatchList,
  }) {
    return Movie(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        addedToWatchList: addedToWatchList ?? this.addedToWatchList);
  }

  @override
  List<Object> get props => [id, name, imageUrl, addedToWatchList];
}
