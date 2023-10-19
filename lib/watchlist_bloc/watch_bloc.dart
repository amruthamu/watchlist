import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/repository/api_mapper_class.dart';
import 'package:watchlist/watchlist_bloc/watch_event.dart';
import 'package:watchlist/watchlist_bloc/watch_state.dart';
import 'package:watchlist/repository/api_data.dart';



class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchApi _userRepository;

  UserBloc(this._userRepository) : super(
      UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getDataList();
        final tabs = _splitContacts(users);
        emit(UserLoadedState(tabs));
        emit(FilterState(filteredUsers: tabs, currentTabIndex: 0));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<OnSortEvent>((event, emit) {
      emit(UserLoadingState());
      if (event.selectedSort == 'asc') {
        emit(FilterState(
            filteredUsers: event.filteredUsers.map((e) {
              if (event.currentTabIndex == event.filteredUsers.indexOf(e)) {
                return e
                  ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
              }
              return e;
            }).toList(),
            currentTabIndex: event.currentTabIndex,
            selectedSort: event.selectedSort));
      } else if (event.selectedSort == 'dsc') {
        emit(FilterState(
            filteredUsers: event.filteredUsers.map((e) {
              if (event.currentTabIndex == event.filteredUsers.indexOf(e)) {
                return e
                  ..sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
              }
              return e;
            }).toList(),
            currentTabIndex: event.currentTabIndex,
            selectedSort: event.selectedSort));
      }
    });
  }

  List<List<WatchlistData>> _splitContacts(List<WatchlistData> items) {
    final tabs = <List<WatchlistData>>[];
    for (int i = 0; i < items.length; i += 25) {
      final endIndex = i + 25;
      final sublist =
      items.sublist(i, endIndex > items.length ? items.length : endIndex);
      tabs.add(sublist);
    }
    return tabs;
  }
}
