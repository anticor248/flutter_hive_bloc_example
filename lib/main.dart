import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_bloc/blocs_movie/movie_bloc.dart';
import 'package:flutter_hive_bloc/hive_database.dart';
import 'package:flutter_hive_bloc/models/movie_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  //await Hive.openBox<Movie>('favorite_movies');

  final hiveDatabase = HiveDatabase();
  await hiveDatabase.openBox();

  runApp(MyApp(
    hiveDatabase: hiveDatabase,
  ));
}

class MyApp extends StatelessWidget {
  final HiveDatabase _hiveDatabase;

  const MyApp({Key? key, required HiveDatabase hiveDatabase})
      : _hiveDatabase = hiveDatabase,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _hiveDatabase,
      child: BlocProvider(
        create: (context) =>
            MovieBloc(hiveDatabase: _hiveDatabase)..add(LoadMovies()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hive and Bloc',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: MyHomePage(),
        ),
      ),
    );
  }
}
