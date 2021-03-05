library multiple_select;

import 'package:flutter/material.dart';

class MultipleSelect {
  static Future showMultipleSelector(
    BuildContext context, {
    @required List<MultipleSelectItem> elements,
    @required values,
    @required String title,
  }) {
    return Navigator.push(
      context,
      MultipleSelectRoute<List>(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        elements: elements,
        values: values,
        title: title,
      ),
    );
  }
}

class MultipleSelectRoute<T> extends PopupRoute<T> {
  final String barrierLabel;
  final List<MultipleSelectItem> elements;
  final List values;
  final String title;

  MultipleSelectRoute({
    this.barrierLabel,
    @required this.elements,
    @required this.values,
    @required this.title,
  });

  @override
  Duration get transitionDuration => Duration(milliseconds: 2000);

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: SelectorList(
        elements: this.elements,
        values: this.values,
        title: this.title,
      ),
    );
    ThemeData theme = Theme.of(context);
    if (theme != null) {
      bottomSheet = new Theme(data: theme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class SelectorList<T> extends StatefulWidget {
  final List<MultipleSelectItem> elements;
  final double height;
  final List values;
  final String title;

  SelectorList({
    @required this.elements,
    this.height = 200,
    @required this.values,
    @required this.title,
  });

  @override
  State<StatefulWidget> createState() => SelectorListState();
}

class SelectorListState extends State<SelectorList> {
  List<MultipleSelectItem> _elements;

  @override
  initState() {
    super.initState();
    this._elements = widget.elements;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 30,
                  child: Text(
                    this.widget.title,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontFamily: 'pyitaungsu'),
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 1.0, color: Colors.black54),
                  itemCount: this._elements.length,
                  itemBuilder: (context, index) {
                    MultipleSelectItem item = this._elements[index];
                    return GestureDetector(
                      onTap: () {
                        this.widget.values.contains(item.value)
                            ? this.widget.values.remove(item.value)
                            : this.widget.values.add(item.value);
                        this.setState(() {});
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Text(
                                item.content.toString(),
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'pyitaungsu'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: this.widget.values.contains(item.value)
                                  ? Icon(
                                      Icons.check_box,
                                      color: Colors.green,
                                      size: 30,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Colors.black54, blurRadius: 5.0),
              ]),
          padding: EdgeInsets.only(top: 20, bottom: 5, left: 6, right: 6),
          margin: EdgeInsets.only(top: this.widget.height, bottom: 40),
        ),
        this.getToolbar(context, this.widget.values),
      ],
    );
  }

  var getToolbar = (context, values) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        height: 40,
        child: GestureDetector(
          onTap: () => Navigator.pop(context, values),
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(width: 2, color: Colors.grey[350])),
              color: Colors.grey[200],
            ),
            child: Container(
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
                color: Colors.black54,
              ),
            ),
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      );
}

class MultipleSelectItem<V, D, C> {
  V value;
  D display;

  /// drop down content.
  C content;

  MultipleSelectItem.build({
    @required this.value,
    @required this.display,
    @required this.content,
  });

  MultipleSelectItem.fromJson(
    Map<String, dynamic> json, {
    displayKey = 'display',
    valueKey = 'value',
    contentKey = 'content',
  })  : value = json[valueKey] ?? '',
        display = json[displayKey] ?? '',
        content = json[contentKey] ?? '';

  static List<MultipleSelectItem> allFromJson(
    List jsonList, {
    displayKey = 'display',
    valueKey = 'value',
    contentKey = 'content',
  }) {
    return jsonList
        .map((json) => MultipleSelectItem.fromJson(
              json,
              displayKey: displayKey,
              valueKey: valueKey,
              contentKey: contentKey,
            ))
        .toList();
  }
}
