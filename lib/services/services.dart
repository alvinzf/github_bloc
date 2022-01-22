import 'package:sejuta_cita/services/api_base_helper.dart';

import 'package:sejuta_cita/models/models_user.dart';
import 'package:sejuta_cita/models/models_repo.dart';
import 'package:sejuta_cita/models/models_issues.dart';

class Services {
  static const String baseUrl = "https://api.github.com/search";
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<dynamic>> fetchGithubUsersList(
      String query, String category, int page) async {
    final response =
        await _helper.get('$baseUrl/$category?q=$query&page=$page&per_page=10');

    if (category == 'users') {
      return UserListResponse.fromJson(response).results;
    } else if (category == 'issues') {
      return IssuesListResponse.fromJson(response).results;
    } else if (category == 'repositories') {
      return RepositoriesListResponse.fromJson(response).results;
    }
  }
}

class UserListResponse {
  List<Users> results;

  UserListResponse.fromJson(Map<String, dynamic> obj) {
    if (obj['items'] != null) {
      results = <Users>[];
      obj['items'].forEach((v) {
        results.add(new Users.fromJson(v));
      });
    }
  }
}

class IssuesListResponse {
  List<Issues> results;

  IssuesListResponse.fromJson(Map<String, dynamic> obj) {
    if (obj['items'] != null) {
      results = <Issues>[];
      obj['items'].forEach((v) {
        results.add(new Issues.fromJson(v));
      });
    }
  }
}

class RepositoriesListResponse {
  List<Repositories> results;

  RepositoriesListResponse.fromJson(Map<String, dynamic> obj) {
    if (obj['items'] != null) {
      results = <Repositories>[];
      obj['items'].forEach((v) {
        results.add(new Repositories.fromJson(v));
      });
    }
  }
}
