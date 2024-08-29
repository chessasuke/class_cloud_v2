import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/common/constants/display_properties.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/data/feature_flags/cubit/feature.dart';
import 'package:class_cloud/core/data/feature_flags/cubit/feature_flag_cubit.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeatureSwitcherScreen extends StatelessWidget {
  const FeatureSwitcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Developer Options',
          actions: [_ResetButton()],
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverPadding(padding: DisplayProperties.defaultPadding),
            // SliverToBoxAdapter(
            //   child: _FcmToken(),
            // ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 1,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Logs(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 1,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Features(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Features extends StatelessWidget {
  const _Features();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureFlagCubit, Features>(
      builder: (context, features) {
        return Column(
          children: [
            for (var entryKey in features.featureMap.keys)
              SizedBox(
                width: double.infinity,
                child: ListTile(
                  title: Text(
                    entryKey,
                    overflow: TextOverflow.clip,
                  ),
                  trailing: _ValueInput(
                    mapEntry: MapEntry(
                      entryKey,
                      features.featureMap[entryKey],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// class _FcmToken extends StatelessWidget {
//   const _FcmToken();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MessagingCubit, MessagingState>(
//       builder: (context, state) {
//         if (state is MessagingStateData) {
//           return GestureDetector(
//             onTap: () async {
//               final messenger = ScaffoldMessenger.of(context);
//               await Clipboard.setData(
//                 ClipboardData(text: state.appFcmToken),
//               );
//               messenger.showSnackBar(
//                 const SnackBar(content: Text('Fcm Token Copied!')),
//               );
//             },
//             child: SizedBox(
//               width: double.infinity,
//               child: ListTile(
//                 title: const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('FCM Token:'),
//                     Icon(Icons.copy),
//                   ],
//                 ),
//                 subtitle: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SelectableText(state.appFcmToken),
//                 ),
//               ),
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }

class _ValueInput extends StatelessWidget {
  const _ValueInput({required this.mapEntry});

  final MapEntry<String, Object?> mapEntry;

  @override
  Widget build(BuildContext context) {
    if (mapEntry.value is bool) {
      final mapValue = (mapEntry.value as bool);
      return Switch(
        value: mapValue,
        activeColor: AppColors.primaryColor,
        onChanged: (value) {
          final modifyEntry = MapEntry(mapEntry.key, value);
          context.read<FeatureFlagCubit>().udpateFeature(features: modifyEntry);
        },
      );
    } else if (mapEntry.value is String) {
      final controller = TextEditingController(text: mapEntry.value as String);
      return SizedBox(
        width: 125,
        height: 100,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                final modifyEntry = MapEntry(mapEntry.key, controller.text);
                context
                    .read<FeatureFlagCubit>()
                    .udpateFeature(features: modifyEntry);
              },
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<FeatureFlagCubit>().resetFeatures(),
      child: Chip(
        backgroundColor: AppColors.primaryColor,
        label: Text(
          'Reset',
          style: TextStyles.body01.copyWith(color: AppColors.white100),
        ),
      ),
    );
  }
}

class _Logs extends StatelessWidget {
  const _Logs();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text('Logs', style: TextStyles.heading03),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        context.pushNamed(GoRouterNames.logs);
      },
    );
  }
}
