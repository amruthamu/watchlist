import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/repository/api_mapper_class.dart';
import 'package:watchlist/ui/tab_details.dart';
import '../watchlist_bloc/watch_bloc.dart';
import '../watchlist_bloc/watch_state.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, Key? key1});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  List<List<WatchlistData>> allList = [];
  late TabController _tabController;


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoadedState) {
              allList = state.users;
              _tabController =
                  TabController(length: state.users.length, vsync: this);
            }
          },
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserErrorState) {
              return const Center(child: Text("Network not available"));
            }
            if (state is FilterState) {
              final tabs = state.filteredUsers;
              tabDetails( context, _tabController, allList,tabs);
            }

            return Container();
          },
        ),
      ),
    );
  }




}


