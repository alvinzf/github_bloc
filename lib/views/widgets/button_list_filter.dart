import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita/bloc/app_bloc.dart';
import 'package:sejuta_cita/bloc/app_state.dart';
import 'package:sejuta_cita/themes/theme.dart';

class ListFilterSelector extends StatelessWidget {
  AppBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AppBloc>(context);

    return Padding(
        padding: EdgeInsets.only(
          left: defaultPadding,
          right: defaultPadding,
          bottom: context.responsive(defaultResponsive),
        ),
        child: BlocBuilder<AppBloc, AppState>(builder: (context, loadState) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _bloc.isInfiniteLoad ? cBlue : cDisable,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius)),
                  ),
                  onPressed: () {
                    context
                        .read<AppBloc>()
                        .add(EventGithubInitial(isLazy: true));
                  },
                  child: Text('Lazy Loading', style: tButton)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: !_bloc.isInfiniteLoad ? cBlue : cDisable,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius)),
                  ),
                  onPressed: () {
                    context
                        .read<AppBloc>()
                        .add(EventGithubInitial(isLazy: false));
                  },
                  child: Text('With Index', style: tButton)),
            ],
          );
        }));
  }
}
