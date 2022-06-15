import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  final IconData leadingIcon;
  final String titleText;
  final String subtitleText;
  final Color? textColor;
  final Color? iconColor;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const ListTileCustom({
    required this.leadingIcon,
    required this.titleText,
    required this.subtitleText,
    this.iconColor,
    this.textColor,
    this.onTap,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right:
                          BorderSide(width: 1.0, color: iconColor ?? Colors.blue))),
              child: Icon(leadingIcon, color: iconColor ?? Colors.blue),
            ),
          ],
        ),
        title: Text(
          titleText,
          style: TextStyle(
              color: textColor ?? Colors.blue, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Text(subtitleText, style: TextStyle(color: textColor, fontSize: 10))
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: iconColor, size: 30.0),
      ),
    );
  }
}

/*class ListTileCustomUser extends StatelessWidget {
  final IconData leadingIcon;
  final String titleText;
  final String subtitleText;
  final Color? iconColors;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const ListTileCustomUser({
    required this.leadingIcon,
    required this.titleText,
    required this.subtitleText,
    this.iconColors,
    this.onTap,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
                        width: 1.0, color: AppColors.secondary.shade400))),
            child: Icon(leadingIcon, color: iconColors ?? AppColors.secondary),
          ),
        ],
      ),
      title: Text(
        titleText,
        style:
            TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Text(subtitleText,
              style: TextStyle(color: AppColors.secondary, fontSize: 10))
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_right,
          color: AppColors.secondary, size: 30.0),
      shape: Border.all(width: .1, color: AppColors.secondary),
    );
  }
}*/