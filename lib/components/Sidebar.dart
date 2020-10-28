import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final Function onSelectTile;
  final List<String> tiles;
  final int currentIndex;
  const Sidebar({this.onSelectTile, this.tiles, this.currentIndex})
      : assert(onSelectTile != null, "The onSelectTile method can't be null"),
        assert(tiles != null, "The tiles can't be null"),
        assert(tiles.length > 0, "The minimum tiles length required is 1"),
        assert(currentIndex >= 0, "The current index should be at least 0");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Text(
              "Catégorie",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
              separatorBuilder: (context, index) => Divider(
                color: Colors.white.withOpacity(.2),
              ),
              itemCount: tiles.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => onSelectTile(index),
                title: Text(
                  tiles[index],
                  style: currentIndex == index
                      ? Theme.of(context)
                          .textTheme
                          .headline6
                          .apply(color: Theme.of(context).hintColor)
                      : Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
