import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/setting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingTile extends StatelessWidget {
  final Setting setting;
  const SettingTile({
    super.key,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Check if the setting has an action, if it does, call the action
        if (setting.action != null) {
          await setting.action!(context); // Call the action with context
        } else {
          // If no action is provided, navigate to the specified route
          Navigator.pushNamed(context, setting.route);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(setting.icon, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Text(
            setting.title,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Icon(FontAwesomeIcons.chevronRight, color: Colors.grey.shade600),
        ],
      ),
    );
  }
}
