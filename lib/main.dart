
import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/categorymealsscreen.dart';
import 'package:meals_app/screens/categoryscreen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/screens/tabscreen.dart';

import 'models/meal.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };
  List<Meal> _availableMeals=DUMMY_MEALS;
  List<Meal> _favoritedMeals=[];

  void _setFilters(Map<String,bool> filterData){
    setState(() {
       _filters=filterData;
       _availableMeals=DUMMY_MEALS.where((meal){
         if(_filters['gluten']&&meal.isGlutenFree==false){
           return false;
         }
         if(_filters['lactose']&&meal.isLactoseFree==false){
           return false;
         }
         if(_filters['vegan']&&meal.isVegan==false){
           return false;
         }
         if(_filters['vegetarian']&&meal.isVegetarian==false){
           return false;
         }
         return true;
       }).toList();
    });
  }
  void _toggleFavorites(String mealId){
    final existingIndex=_favoritedMeals.indexWhere((meal){
      return meal.id==mealId;
    });
    if(existingIndex>=0){
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoritedMeals.add(DUMMY_MEALS.firstWhere((meal){
          return mealId==meal.id;
        }));
      });
    }
  }
  bool _isMealFavorite(String id){
    return _favoritedMeals.any((meal)=>meal.id==id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          title: TextStyle(fontSize: 24,fontFamily: 'RobotoCondensed'),
        )
      ),
      initialRoute: '/',
      routes: {
        '/':(ctx){return TabScreen(_favoritedMeals);},
        CategoryMealsScreen.routeName:(ctx){return CategoryMealsScreen(_availableMeals);},
        MealDetailsScreen.routeName:(ctx){return MealDetailsScreen(_toggleFavorites,_isMealFavorite);},
        FilterScreen.routeName:(ctx){return FilterScreen(_setFilters,_filters);}

      },
      onGenerateRoute: (settings){
        return MaterialPageRoute(builder:(ctx)
        {
          return CategoryScreen();
        });
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder:(ctx)
        {
          return CategoryScreen();
        });
      },
    );
  }
}


