import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categoryscreen.dart';
import 'package:meals_app/screens/favourites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabScreen(this.favoriteMeals);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  int selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {'page': CategoryScreen(), 'title': "Categories"},
      {
        'page': FavouritesScreen(widget.favoriteMeals),
        'title': "Your Favorite"
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[selectedPageIndex]['title'])),
      drawer: MainDrawer(),
      body: _pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text('Categories'),
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favorites'),
                backgroundColor: Theme.of(context).primaryColor),
          ]),
    );
  }
}
