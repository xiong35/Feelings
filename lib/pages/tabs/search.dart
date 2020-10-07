import 'dart:math';

import 'package:feelings/components/RandomBtn.dart';
import 'package:feelings/global/localization.dart';
import 'package:feelings/global/requests.dart';
import 'package:flutter/material.dart';

const BTN_WIDTH = 140;
const BTN_HEIGHT = 30;

const H_DIFF = 0.30;
const V_DIFF = 0.10;

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
    PositionInPercent(horizontal: 0.2, vertical: 0.48),
    PositionInPercent(horizontal: 0.8, vertical: 0.52),
    PositionInPercent(horizontal: 0.2, vertical: 0.52),
    PositionInPercent(horizontal: 0.8, vertical: 0.48),
  ];

  List<PositionInNum> positions = [];

  PositionInNum genPosition(BuildContext context) {
    PositionInPercent ret = PositionInPercent();
    do {
      print("compute...");
      ret.horizontal = r.nextDouble() * 0.92 + 0.04;
      ret.vertical = r.nextDouble() * 0.92 + 0.04;
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

  List<String> tags = [];

  TextEditingController _searchController =
      TextEditingController();

  @override
  void initState() {
    if (tags.length == 0)
      Requests.getHotTags().then((value) => setState(() {
            tags = value;
          }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    List<Color> colors = [
      colorScheme.primary,
      colorScheme.secondaryVariant,
      colorScheme.primaryVariant,
      colorScheme.secondary,
    ];

    for (int i = positions.length; i < HOT_TAG_NUM; i++) {
      positions.add(genPosition(context));
    }

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
                hintText:
                    FeelingsLocalization.of(context).search,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search_outlined),
                  onPressed: () {
                    if ((_searchController?.text?.length ?? 0) >
                        0)
                      Navigator.pushNamed(
                        context,
                        "searchRes",
                        arguments: {
                          "kw": _searchController.text
                        },
                      );
                  },
                ),
              ),
              controller: _searchController,
            ),
          ),
        ),
        for (int i = 0; i < tags.length; i++)
          RandBtn(
            p: positions[i],
            text: tags[i],
            onPressed: () => _searchController.text = tags[i],
            color: colors[i % 4],
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
