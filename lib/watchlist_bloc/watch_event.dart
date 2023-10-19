
import 'package:watchlist/repository/api_mapper_class.dart';



abstract class UserEvent {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
}

class OnSortEvent extends UserEvent {
  final List<List<WatchlistData>> filteredUsers;

  final int currentTabIndex;

  final String? selectedSort;
  const OnSortEvent(
      {required this.filteredUsers,
        required this.currentTabIndex,
        this.selectedSort});
}
