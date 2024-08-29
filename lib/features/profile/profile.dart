
import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/core/app/cubits/user_cubit/user_cubit.dart';
import 'package:class_cloud/core/app/cubits/user_cubit/user_state.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/services/url_launcher_service/url_launcher_service.dart';
import 'package:class_cloud/features/profile/widgets/app_version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const _BuildLogo(),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ),
          const _PersonalInfo(),
          const SizedBox(height: 24),
          // const _AboutUs(),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppVersion(),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _AboutUs extends ConsumerWidget {
  const _AboutUs();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      dense: true,
      title: Text('About Us', style: TextStyles.heading03),
      onTap: () {
        ref.read(urlLauncherService).launchInBrowser(
              Uri.parse('https://www.healthseers.com/cairdio-pcg-ai'),
            );
      },
    );
  }
}

class _PersonalInfo extends StatelessWidget {
  const _PersonalInfo();

  String buildName({required String? firstName, required String? lastName}) {
    if (firstName == null && lastName == null) {
      return '';
    }
    return '$firstName $lastName';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserAuthenticated) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  buildName(
                    firstName: state.user.firstName,
                    lastName: state.user.lastName,
                  ),
                  style: TextStyles.heading02,
                ),
              ),
              ListTile(
                title: Text(
                  state.user.email ?? '',
                  style: TextStyles.body01,
                ),
              ),
              ListTile(
                title: Text(
                  state.user.role?.name ?? '',
                  style: TextStyles.body01,
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _BuildLogo extends StatelessWidget {
  const _BuildLogo();

  @override
  Widget build(BuildContext context) {
    return const Opacity(
      opacity: 0.2,
      child: Text('LOGO'),
    );
  }
}
