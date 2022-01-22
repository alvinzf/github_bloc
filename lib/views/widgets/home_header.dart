import 'package:flutter/material.dart';
import 'package:sejuta_cita/themes/theme.dart';
import 'package:sejuta_cita/views/widgets/radio_list_selector.dart';
import 'package:sejuta_cita/views/widgets/button_list_filter.dart';
import 'package:sejuta_cita/views/widgets/search_bar.dart';

class HeaderAppBar extends StatelessWidget {
  const HeaderAppBar({
    @required this.height,
    @required this.showTitle,
  });

  final double height;
  final bool showTitle;

  Widget _buildTitle(visible) {
    if (!visible) {
      return null;
    }

    return Container(
      padding: EdgeInsets.only(
        top: defaultPadding,
      ),
      child: Column(
        children: [
          RadioSelector(),
          ListFilterSelector(),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(defaultRadius),
        ),
      ),
      child: HeaderBackground(
        buildChildren: (_) => [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SearchBar(),
              RadioSelector(),
              ListFilterSelector(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: height,
      floating: true,
      pinned: true,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(defaultRadius),
        ),
      ),
      collapsedHeight: height / 1.25,
      backgroundColor: cWhite,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        title: _buildTitle(showTitle),
        background: _buildCard(context),
      ),
    );
  }
}

class VSpacer extends SizedBox {
  const VSpacer(double size) : super(height: size);
}

class HeaderContainerProperties {
  const HeaderContainerProperties._({this.size, this.top, this.right});

  final double size;
  final double top;
  final double right;

  factory HeaderContainerProperties(BuildContext context) {
    final screenSize = context.screenSize;
    final iconSize = context.iconSize;

    final size = screenSize.width * headerSize;
    final top = -(size / 3 -
        iconSize / 3 -
        context.responsive(mPadding) -
        context.padding.top);
    final right = -(size / 3 - iconSize / 3 - mPadding);

    return HeaderContainerProperties._(size: size, top: top, right: right);
  }
}

class HeaderBackground extends StatelessWidget {
  final List<Widget> Function(HeaderContainerProperties) buildChildren;

  const HeaderBackground({Key key, @required this.buildChildren})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final properties = HeaderContainerProperties(context);

    return Stack(
      children: <Widget>[
        ...buildChildren(properties),
      ],
    );
  }
}
