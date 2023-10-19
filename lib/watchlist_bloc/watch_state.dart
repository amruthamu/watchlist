

import 'package:watchlist/repository/api_mapper_class.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<List<WatchlistData>> users;

  UserLoadedState(this.users);
}

class FilterState extends UserState {
  final List<List<WatchlistData>> filteredUsers;
  final int currentTabIndex;
  final String? selectedSort;
  FilterState(
      {required this.filteredUsers,
        required this.currentTabIndex,
        this.selectedSort});
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
}
