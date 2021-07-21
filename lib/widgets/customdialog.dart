import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../utils/utils.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class CustomDialogBox extends HookWidget {
  final Widget img, endText;
  final List<Widget> Function(int index) items;
  final List<String> versions;
  final void Function(int version)? onVersionChange;

  const CustomDialogBox({
    Key? key,
    required this.items,
    required this.endText,
    required this.img,
    required this.versions,
    this.onVersionChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    List<Widget> currentItem = items(selectedIndex.value);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(maxWidth: 700),
            padding: const EdgeInsets.only(
                left: Constants.padding,
                top: Constants.avatarRadius + Constants.padding,
                right: Constants.padding,
                bottom: Constants.padding),
            margin: const EdgeInsets.only(top: Constants.avatarRadius),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: context.isDark ? Colors.grey[800] : Colors.grey[300],
                borderRadius: BorderRadius.circular(Constants.padding),
                boxShadow: [
                  BoxShadow(
                      color: context.isDark
                          ? Colors.grey.shade900
                          : Colors.grey.shade500,
                      offset: const Offset(0, 10),
                      spreadRadius: 2,
                      blurRadius: 20),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButton<int>(
                  isExpanded: true,
                  value: selectedIndex.value,
                  underline: Container(),
                  onChanged: (val) {
                    selectedIndex.value = val!;
                    if (onVersionChange != null) onVersionChange!(val);
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return versions.map<Widget>((String item) {
                      return Center(
                          child: Text(item,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600)));
                    }).toList();
                  },
                  items: versions.asMap().entries.map((entry) {
                    return DropdownMenuItem<int>(
                      child: Text(
                        entry.value,
                      ),
                      value: entry.key,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),
                if (currentItem.isNotEmpty)
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: currentItem,
                    ),
                  )
                else
                  const Text("No AppImage Found in this Release"),
                const SizedBox(height: 22),
                Align(
                  alignment: Alignment.bottomRight,
                  child: endText,
                ),
              ],
            ),
          ),
          Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(Constants.avatarRadius),
                  child: img),
            ),
          ),
        ],
      ),
    );
  }
}
