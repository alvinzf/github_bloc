import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sejuta_cita/models/models_user.dart';
import 'package:sejuta_cita/models/models_repo.dart';
import 'package:sejuta_cita/models/models_issues.dart';
import 'package:sejuta_cita/services/services.dart';
import 'package:sejuta_cita/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(OnUsersLoad(isLazy: true));
  Services _serv = Services();
  List<Users> githubList = [];
  List<Issues> githubIssuesList = [];
  List<Repositories> githubRepositoriesList = [];
  String query;
  String type;
  int page;

  bool isInfiniteLoad = true;

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is EventGithubInitial) {
      page = event.page ?? page;
      query = event.query?.trim() ?? query;
      type = event.type ?? type;
      githubIssuesList = [];
      githubList = [];
      githubRepositoriesList = [];
      isInfiniteLoad = event.isLazy ?? true;
      if (type == "users") {
        List<Users> _fetchData =
            await _serv.fetchGithubUsersList(query, type, page);
        githubList.addAll(_fetchData);
        yield OnUsersLoad(githubUsers: githubList, isLazy: isInfiniteLoad);
      } else if (type == "issues") {
        List<Issues> _fetchData =
            await _serv.fetchGithubUsersList(query, type, page);
        githubIssuesList.addAll(_fetchData);
        yield OnIssues(githubIssues: githubIssuesList, isLazy: isInfiniteLoad);
      } else if (type == "repositories") {
        List<Repositories> _fetchData =
            await _serv.fetchGithubUsersList(query, type, page);
        githubRepositoriesList.addAll(_fetchData);
        yield OnRepositories(
            githubRepositories: githubRepositoriesList, isLazy: isInfiniteLoad);
      }
    } else if (event is EventOnUsersMore) {
      if (type == "users") {
        List<Users> _fetchData =
            await _serv.fetchGithubUsersList(query, type, page += 1);
        githubList.addAll(_fetchData);
        yield null;
        yield OnUsersLoad(githubUsers: githubList, isLazy: isInfiniteLoad);
      } else if (type == "issues") {
        List<Issues> _fetchData =
            await _serv.fetchGithubUsersList(query, type, page += 1);
        githubIssuesList.addAll(_fetchData);
        yield null;
        yield OnIssues(githubIssues: githubIssuesList, isLazy: isInfiniteLoad);
      } else if (type == "repositories") {
        List<Repositories> _fetchData =
            await _serv.fetchGithubUsersList(query, type, page += 1);
        githubRepositoriesList.addAll(_fetchData);
        yield null;
        yield OnRepositories(
            githubRepositories: githubRepositoriesList, isLazy: isInfiniteLoad);
      }
    }
  }
}

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class EventGithubInitial extends AppEvent {
  final String query;
  final int page;
  final String type;
  final bool isLazy;

  EventGithubInitial({this.query, this.page, this.type, this.isLazy});

  @override
  List<Object> get props => [];
}

class EventOnUsersMore extends AppEvent {
  @override
  List<Object> get props => [];
}
