import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FilterScreen(this.saveFilters, this.currentFilters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isVegan = false;
  var _isVegetarian = false;
  var _isGlutenFree = false;
  var _isLactoseFree = false;

  @override
  initState() {
    _isVegan = widget.currentFilters['vegan'];
    _isVegetarian = widget.currentFilters['vegetarian'];
    _isLactoseFree = widget.currentFilters['lactose'];
    _isGlutenFree = widget.currentFilters['gluten'];
    super.initState();
  }

  Widget switchFilterBuilder(
      String title, String subtitle, bool currentValue, Function onSwitched) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: currentValue,
        onChanged: onSwitched);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _isGlutenFree,
                    'lactose': _isLactoseFree,
                    'vegan': _isVegan,
                    'vegetarian': _isVegetarian,
                  };
                  widget.saveFilters(selectedFilters);
                })
          ],
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Chosose Your Filters",
                style: Theme.of(context).textTheme.title),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              switchFilterBuilder('Gluten-free',
                  'Only include Gluten-free meals.', _isGlutenFree, (val) {
                setState(() {
                  _isGlutenFree = val;
                });
              }),
              switchFilterBuilder('Lactose-free',
                  'Only include Lactose-free meals.', _isLactoseFree, (val) {
                setState(() {
                  _isLactoseFree = val;
                });
              }),
              switchFilterBuilder(
                  'Vegan', 'Only include Vegan meals.', _isVegan, (val) {
                setState(() {
                  _isVegan = val;
                });
              }),
              switchFilterBuilder(
                  'Vegetarian', 'Only include Vegetarian meals.', _isVegetarian,
                  (val) {
                setState(() {
                  _isVegetarian = val;
                });
              }),
            ],
          )),
        ]));
  }
}
