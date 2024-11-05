import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/view/avatar_card.dart';
import 'package:flutter_application_1/domains/setting.dart';
import 'package:flutter_application_1/domains/freezed/user_model.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import '../../view/setting_tile.dart';


class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AvatarCard(name: ref.read(userProvider).value!.username ?? "aaa"),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(
                      settings.length,
                      (index) => Column(
                            children: [
                              SettingTile(
                                setting: settings[index],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider()
                            ],
                          )),
                )),
          ),
        ],
      ),
    );
  }
}
