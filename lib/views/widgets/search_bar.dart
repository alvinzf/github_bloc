import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita/bloc/app_bloc.dart';
import 'package:sejuta_cita/themes/theme.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: context.responsive(defaultResponsive)),
      margin:
          EdgeInsets.symmetric(horizontal: xlMargin, vertical: defaultMargin),
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search, size: context.responsive(xlresponsive)),
          HSpacer(defaultSpacer),
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (String val) {
                context.read<AppBloc>().add(
                    EventGithubInitial(query: val, page: 1, type: 'users'));
              },
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search',
                contentPadding: EdgeInsets.zero,
                hintStyle: tSecondary,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HSpacer extends SizedBox {
  const HSpacer(double size) : super(width: size);
}
