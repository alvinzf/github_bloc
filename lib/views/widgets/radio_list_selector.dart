import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita/bloc/app_bloc.dart';
import 'package:sejuta_cita/bloc/app_state.dart';
import 'package:sejuta_cita/themes/theme.dart';

class RadioSelector extends StatelessWidget {
  const RadioSelector({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AppBloc, AppState>(builder: (_, listState) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Radio(
            value: "OnUsersLoad",
            groupValue: listState.toString(),
            onChanged: (_) => context
                .read<AppBloc>()
                .add(EventGithubInitial(type: "users", page: 1)),
          ),
          Text(
            'Users',
            style: tPrimary,
          ),
          Radio(
            value: "OnIssues",
            groupValue: listState.toString(),
            onChanged: (String value) {
              context
                  .read<AppBloc>()
                  .add(EventGithubInitial(type: "issues", page: 1));
            },
          ),
          Text('Issues', style: tPrimary),
          Radio(
            value: "OnRepositories",
            groupValue: listState.toString(),
            onChanged: (String value) {
              context
                  .read<AppBloc>()
                  .add(EventGithubInitial(type: "repositories", page: 1));
            },
          ),
          Text(
            'Repositories',
            style: tPrimary,
          ),
        ]);
      }),
    );
  }
}
