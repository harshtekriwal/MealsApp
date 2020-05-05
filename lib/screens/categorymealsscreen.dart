import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen  extends StatefulWidget {
    static final routeName='/categories-meals';
    final List<Meal> _availabeMeals;
    CategoryMealsScreen(this._availabeMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title;
  List<Meal> categoryMeals;
  bool _loadedInitData=false;
  void deleteMeal(String id){
    setState(() {
      categoryMeals.removeWhere((meal){
      return meal.id==id;
    });
    });
    
  }
  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
    final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
    title=routeArgs['title'];
    final id=routeArgs['id'];
    categoryMeals=widget._availabeMeals.where((meal){
      return meal.categories.contains(id);
    }).toList();
    _loadedInitData=true;
    super.didChangeDependencies();
    }
  }


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title:Text(title)),
        body: ListView.builder(itemBuilder: (ctx,index){
          return MealItem(
            id:categoryMeals[index].id,
            title: categoryMeals[index].title,
            duration: categoryMeals[index].duration,
            imageUrl: categoryMeals[index].imageUrl,
            affordability: categoryMeals[index].affordability,
            complexity: categoryMeals[index].complexity,);
        },itemCount:categoryMeals.length ,)
      );
  
  }
}