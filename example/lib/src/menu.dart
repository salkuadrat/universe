import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'shared.dart';

class AppMenu extends StatefulWidget {
  final Key value;
  final Map<Key, MenuItem> items;
  final Function(Key) onChanged;

  const AppMenu({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  AppMenuState createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> {
  final ItemScrollController itemScrollController = ItemScrollController();

  int get chosenIndex {
    for (int index = 0; index < widget.items.length; index++) {
      if (widget.items.keys.elementAt(index) == widget.value) {
        return index;
      }
    }
    return -1;
  }

  int get jumpIndex => chosenIndex > 4 ? (chosenIndex - 4) : 0;

  Future showMenuDialog() async {
    Scaffold.of(context).showBottomSheet(
      (context) => Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: Container(color: Colors.transparent),
              onTap: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                itemCount: menus.keys.length,
                itemBuilder: (_, index) {
                  final key = menus.keys.elementAt(index);
                  final chosen = key == widget.value;

                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 18,
                      ),
                      child: Text(
                        menus[key]!.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: chosen
                              ? Theme.of(context).primaryColor
                              : const Color(0xFF454545),
                        ),
                      ),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(
                        const Duration(milliseconds: 200),
                      );
                      widget.onChanged.call(menus.keys.elementAt(index));
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.transparent,
    );

    if (chosenIndex >= 0) {
      await Future.delayed(
        const Duration(milliseconds: 300),
      );
      itemScrollController.jumpTo(index: jumpIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 18,
      bottom: 28,
      width: 52,
      height: 52,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: showMenuDialog,
          backgroundColor: Colors.white,
          child:
              Icon(Icons.menu, size: 25, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
