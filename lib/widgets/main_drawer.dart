import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget listTileBuilder(String text, IconData icon, Function onClick) {
      return ListTile(
        leading: Icon(icon),
        title: Text(text,
            style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        onTap: onClick,
      );
    }

    return Drawer(
      child: Column(children: [
        Container(
          height: 100,
          width: double.infinity,
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text("Cooking Up!",
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor)),
        ),
        SizedBox(
          height: 20,
        ),
        listTileBuilder('Meals', Icons.restaurant, () {
           Navigator.of(context)
              .pushReplacementNamed('/');
        }),
        listTileBuilder('Filters', Icons.settings,(){
          Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
        })
      ]),
    );
  }
}
