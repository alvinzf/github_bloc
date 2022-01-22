import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita/bloc/app_bloc.dart';
import 'package:sejuta_cita/bloc/app_state.dart';
import 'package:sejuta_cita/themes/theme.dart';

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  ScrollController _scrollController = ScrollController();
  AppBloc _bloc;
  List<int> items = [
    1,
    2,
    3,
    4,
    5,
  ];

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AppBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset &&
          _bloc.isInfiniteLoad) {
        _bloc.add(EventOnUsersMore());
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AppBloc>(context);
    return Container(
      padding: EdgeInsets.all(sPadding),
      child: ListView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) {
              if (appState is OnUsersLoad && appState.githubUsers != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: appState.githubUsers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Card(
                        child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(appState.githubUsers[index].avatarUrl),
                      ),
                      title: Text(appState.githubUsers[index].login),
                    ));
                  },
                );
              } else if (appState is OnIssues &&
                  appState.githubIssues != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: appState.githubIssues.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Card(
                        child: ListTile(
                      title: Text(appState.githubIssues[index].title),
                      subtitle: Text(
                        appState.githubIssues[index].createdAt.toString(),
                        style: tSecondary,
                      ),
                      trailing: Text(
                        appState.githubIssues[index].state,
                        style: tTrailingIssue,
                      ),
                    ));
                  },
                );
              } else if (appState is OnRepositories &&
                  appState.githubRepositories != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: appState.githubRepositories.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Card(
                        child: ListTile(
                      title: Text(appState.githubRepositories[index].fullName),
                      subtitle: Text(
                          appState.githubRepositories[index].createdAt
                              .toString(),
                          style: tSecondary),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Watchers: " +
                                appState.githubRepositories[index].watchers
                                    .toString(),
                            style: tTrailingRepo,
                          ),
                          Text(
                            "Stars: " +
                                appState
                                    .githubRepositories[index].stargazersCount
                                    .toString(),
                            style: tTrailingRepo,
                          ),
                          Text(
                            "Forks: " +
                                appState.githubRepositories[index].forks
                                    .toString(),
                            style: tTrailingRepo,
                          ),
                        ],
                      ),
                    ));
                  },
                );
              } else {
                return SizedBox();
              }
            },
          ),
          BlocBuilder<AppBloc, AppState>(
            builder: (context, loadState) {
              return Container(
                  child: _bloc.isInfiniteLoad &&
                          (_bloc.githubList.length >= 10 ||
                              _bloc.githubIssuesList.length >= 10 ||
                              _bloc.githubRepositoriesList.length >= 10)
                      ? Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Center(
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator()),
                          ),
                        )
                      : (_bloc.githubList.length >= 10 ||
                              _bloc.githubIssuesList.length >= 10 ||
                              _bloc.githubRepositoriesList.length >= 10)
                          ?
                          // page pagintate
                          Container(
                              height: 20.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<AppBloc>().add(
                                            EventGithubInitial(
                                                page: items[index],
                                                isLazy: false));
                                        _scrollController.animateTo(
                                          0.0,
                                          curve: Curves.easeOut,
                                          duration:
                                              const Duration(milliseconds: 300),
                                        );
                                      },
                                      child: Text(
                                        '${items[index]}',
                                        style: TextStyle(
                                            color: (_bloc.page == items[index])
                                                ? Colors.black
                                                : Colors.blue,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Divider(),
                            ));
            },
          ),
        ],
      ),
    );
  }
}
