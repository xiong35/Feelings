import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:feelings/global/localization.dart';
import 'package:feelings/global/global.dart';
import 'package:feelings/components/thePlayPanel.dart';
import 'package:feelings/components/utils.dart';
import 'package:feelings/components/musicItem.dart';

class MusicPlayView extends StatelessWidget {
  const MusicPlayView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      bottomNavigationBar: _PlayPanel(),
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.background,
        title: Text(
          "Song Name",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            child: ClipRRect(
              child: Image.network(
                "http://static.xiong35.cn/image/icons/open-doodles/5.png",
                fit: BoxFit.cover,
                height: 240.0,
                width: 240.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.fromLTRB(0, 50, 0, 15),
          ),
          Text(
            "Song name",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 6),
          Text("Artist"),
          SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
                Text("test"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayPanel extends StatelessWidget {
  const _PlayPanel({
    Key key,
    this.value = 0.5,
  }) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      child: SizedBox(
          height: 125,
          child: Column(
            children: [
              Slider(
                value: value,
                onChanged: (_) {},
                activeColor:
                    Theme.of(context).colorScheme.secondary,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.shuffle,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.skip_previous_outlined,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.play_arrow_outlined,
                        size: 50,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.skip_next_outlined,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.mode_comment_outlined,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          )),
      data: IconThemeData(
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
