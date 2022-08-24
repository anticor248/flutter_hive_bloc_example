import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_bloc/blocs_movie/movie_bloc.dart';

import 'models/movie_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Flutter Hive&Bloc'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                Movie movie = state.movies[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      movie.name,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<MovieBloc>().add(
                                UpdateMovie(
                                  movie: movie.copyWith(
                                      addedToWatchList:
                                          !movie.addedToWatchList),
                                ),
                              );

                          //moviesBox.put(
                          //movie.id,
                          //movie.copyWith(
                          // addedToWatchList: !movie.addedToWatchList),
                          //);
                        },
                        icon: Icon(
                          Icons.watch_later,
                          color: movie.addedToWatchList
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showModalBottomSheet(
                            context: context,
                            movie: movie,
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<MovieBloc>().add(
                                DeleteMovie(movie: state.movies[index]),
                              );
                          //box.delete(movie.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Text('Something Wrong');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showModalBottomSheet(
          context: context,
        ),
      ),
    );
  }

  void _showModalBottomSheet({
    required BuildContext context,
    Movie? movie,
  }) {
    Random random = Random();
    TextEditingController nameController = TextEditingController();
    TextEditingController imageUrlController = TextEditingController();

    if (movie != null) {
      nameController.text = movie.name;
      imageUrlController.text = movie.imageUrl;
    }

    showModalBottomSheet(
      elevation: 5,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Movie'),
              ),
              TextField(
                controller: imageUrlController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (movie != null) {
                    context.read<MovieBloc>().add(
                          UpdateMovie(
                            movie: movie.copyWith(
                                name: nameController.text,
                                imageUrl: imageUrlController.text),
                          ),
                        );

                    // moviesBox.put(
                    //   movie.id,
                    //   movie.copyWith(
                    //       name: nameController.text,
                    //       imageUrl: imageUrlController.text),
                    // );

                  } else {
                    Movie movie = Movie(
                        id: '${random.nextInt(10000)}',
                        name: nameController.text,
                        addedToWatchList: false,
                        imageUrl: imageUrlController.text);
                    context.read<MovieBloc>().add(
                          AddMovie(movie: movie),
                        );

                    //moviesBox.put(movie.id, movie);

                  }

                  //moviesBox.add(movie.id, movie);

                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
