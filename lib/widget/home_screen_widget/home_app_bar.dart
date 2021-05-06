import 'package:fast_food/screen/search.dart';
import 'package:flutter/material.dart';

AppBar homeAppBar({context}) {

  return AppBar(
    elevation: 0.0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(Icons.sort, color: Theme.of(context).iconTheme.color),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.search,
          color: Theme.of(context).iconTheme.color,
          size: 30,
        ),
        onPressed: () {
          showSearch(
            context: context,
            delegate: Search(),
          );
        },
      ),

    
    ],
  );
}
