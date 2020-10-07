import 'dart:math';

import 'package:feelings/components/RandomBtn.dart';
import 'package:feelings/global/localization.dart';
import 'package:flutter/material.dart';

const BTN_WIDTH = 140;
const BTN_HEIGHT = 30;

const H_DIFF = 0.33;
const V_DIFF = 0.12;

final Random r = Random();

class PositionInPercent {
  PositionInPercent({this.horizontal, this.vertical});
  double horizontal = 0;
  double vertical = 0;
}

const HOT_TAG_NUM = 10;

class PositionInNum {
  PositionInNum({this.bottom, this.left, this.right, this.top});
  double top = 0;
  double bottom = 0;
  double left = 0;
  double right = 0;
}

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin {
  PositionInNum getHorizontalByPercent(
      double percent, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final availiable = width - BTN_WIDTH;
    double left = availiable * percent;
    double right = availiable * (1 - percent);
    // return {"right": right, "left": left};
    return PositionInNum(left: left, right: right);
  }

  PositionInNum getVerticalByPercent(
      double percent, BuildContext context) {
    final height = MediaQuery.of(context).size.height - 170;
    final availiable = height - BTN_HEIGHT;
    double top = availiable * percent;
    double bottom = availiable * (1 - percent);
    return PositionInNum(top: top, bottom: bottom);
  }

  List<PositionInPercent> usedPosition = [
    PositionInPercent(horizontal: 0.2, vertical: 0.45),
    PositionInPercent(horizontal: 0.8, vertical: 0.55),
    PositionInPercent(horizontal: 0.2, vertical: 0.55),
    PositionInPercent(horizontal: 0.8, vertical: 0.45),
  ];

  List<PositionInNum> positions = [];

  PositionInNum genPosition(BuildContext context) {
    PositionInPercent ret = PositionInPercent();
    do {
      print("compute...");
      ret.horizontal = r.nextDouble();
      ret.vertical = r.nextDouble();
    } while (positionIsUsed(ret));
    usedPosition.add(ret);

    PositionInNum h =
        getHorizontalByPercent(ret.horizontal, context);
    PositionInNum v =
        getVerticalByPercent(ret.vertical, context);

    return PositionInNum(
      bottom: v.bottom,
      top: v.top,
      left: h.left,
      right: h.right,
    );
  }

  bool positionIsUsed(PositionInPercent p) {
    return usedPosition.any((e) {
      return (e.horizontal - p.horizontal).abs() < H_DIFF &&
          (e.vertical - p.vertical).abs() < V_DIFF;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    for (int i = positions.length; i < HOT_TAG_NUM; i++) {
      positions.add(genPosition(context));
    }

    var colorScheme = Theme.of(context).colorScheme;
    var style = InputDecoration(
      filled: true,
      fillColor: colorScheme.surface,
      focusColor: colorScheme.primary,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
    );

    return Stack(
      children: [
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280),
            child: TextField(
              cursorColor: colorScheme.secondary,
              decoration: style.copyWith(
                hintText: FeelingsLocalization.of(context)
                    .loginPassword,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search_outlined),
                  onPressed: () {},
                ),
              ),
              // controller: _pwController,
            ),
          ),
        ),
        for (int i = 0; i < HOT_TAG_NUM; i++)
          RandBtn(
            p: positions[i],
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
