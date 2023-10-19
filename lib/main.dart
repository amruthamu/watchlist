import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/repository/api_data.dart';
import 'package:watchlist/ui/contact_tab_screen.dart';
import 'package:watchlist/watchlist_bloc/watch_bloc.dart';
import 'watchlist_bloc/watch_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchApi = FetchApi(); // Create an instance of FetchApi
    return BlocProvider(
      create: (context) => UserBloc(fetchApi)..add(LoadUserEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        home: const TabsScreen(),
      ),
    );
  }
}
