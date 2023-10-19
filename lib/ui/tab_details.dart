import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/repository/api_mapper_class.dart';
import '../watchlist_bloc/watch_bloc.dart';
import '../watchlist_bloc/watch_event.dart';
import '../watchlist_bloc/watch_state.dart';

String? isSelected;
Widget tabDetails(BuildContext context,TabController _tabController,List<List<WatchlistData>> allList,List<List<WatchlistData>> tabs ){
  return Column(
    children: [
      Container(
        decoration: const BoxDecoration(color: Colors.blue),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'WatchList',
                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TabBar(
              onTap: (tabIndex) {
                isSelected = '';

                context.read<UserBloc>().add(OnSortEvent(
                    filteredUsers: allList,
                    currentTabIndex: tabIndex,
                    selectedSort: 'asc'));
              },
              controller: _tabController,
              isScrollable: true,
              tabs: _buildTabBarTabs(tabs,),
            ),
          ],
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: _buildTabBarViews(tabs, context,_tabController,allList),
        ),
      ),
    ],
  );
}




List<Widget> _buildTabBarTabs(List<List<WatchlistData>> tabs) {
  return tabs.map((tabItems) {
    return Tab(
      child: Text(
        'Contact ${tabs.indexOf(tabItems) + 1}',
        style: const TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }).toList();
}

List<Widget> _buildTabBarViews(List<List<WatchlistData>> tabs, context,TabController _tabController,List<List<WatchlistData>> allList) {
  double height = MediaQuery.of(context).size.height;
  return tabs.map((tabItems) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.blueAccent),
          child: ListView.builder(
            // physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: tabItems.length,
            itemBuilder: (context, index) {
              final item = tabItems[index];
              return Container(
                margin: EdgeInsets.only(bottom: height * 0.01),
                padding: const EdgeInsets.only(right: 8, left: 8),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  title: Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(item.contacts),
                  // trailing: const Icon(Icons.person),
                  trailing: Text(item.id),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.rectangle,
            ),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocConsumer<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is FilterState) {
                          isSelected = state.selectedSort!;
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 16.0, 16.0, 0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Sort By',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          'OK',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    const Text('User ID'),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<UserBloc>()
                                            .add(OnSortEvent(
                                          filteredUsers: allList,
                                          currentTabIndex:
                                          _tabController.index,
                                          selectedSort: 'asc',
                                        ));
                                      },
                                      child: Text(
                                        '0 \u{2193} 9',
                                        style: TextStyle(
                                            color: isSelected == null
                                                ? Colors.black
                                                : isSelected! == 'asc'
                                                ? Colors.blue
                                                : Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<UserBloc>()
                                            .add(OnSortEvent(
                                          filteredUsers: allList,
                                          currentTabIndex:
                                          _tabController.index,
                                          selectedSort: 'dsc',
                                        ));
                                      },
                                      child: Text(
                                        '9 \u{2191} 0',
                                        style: TextStyle(
                                            color: isSelected == null
                                                ? Colors.black
                                                : isSelected! == 'dsc'
                                                ? Colors.blue
                                                : Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // Handle User ID sorting action
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              icon: const Icon(Icons.sort),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }).toList();
}
