Search in Pub with# multiselectable_dropdown

A new Flutter MultiSelectableDropDown package project.

Reference From MultiSelect Package

![dropdown](https://user-images.githubusercontent.com/39454969/69930166-66f10700-14f0-11ea-932a-9e3255f034a1.gif)

## Example

```dart
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
