import 'package:equatable/equatable.dart';
import 'package:sejuta_cita/models/models_user.dart';
import 'package:sejuta_cita/models/models_repo.dart';
import 'package:sejuta_cita/models/models_issues.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class GithubInitial extends AppState {
  @override
  List<Object> get props => [];
}

class OnUsersLoad extends AppState {
  final List<Users> githubUsers;
  final bool isLazy;
  OnUsersLoad({this.githubUsers, this.isLazy});
  @override
  List<Object> get props => [githubUsers];
}

class OnIssues extends AppState {
  final List<Issues> githubIssues;
  final bool isLazy;
  OnIssues({this.githubIssues, this.isLazy});
  @override
  List<Object> get props => [githubIssues];
}

class OnRepositories extends AppState {
  final List<Repositories> githubRepositories;
  final bool isLazy;
  OnRepositories({this.githubRepositories, this.isLazy});
  @override
  List<Object> get props => [githubRepositories];
}
