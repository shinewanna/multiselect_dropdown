import 'package:flutter/material.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MultipleSelectItem> elements = List.generate(
    15,
    (index) => MultipleSelectItem.build(
      value: index,
      display: '$index display',
      content: '$index content',
    ),
  );

  List _selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MultiSelect DropDown"),
      ),
      body: MultipleDropDown(
        placeholder: 'Hint Text',
        disabled: false,
        values: _selectedValues,
        elements: elements,
      ),
    );
  }
}
