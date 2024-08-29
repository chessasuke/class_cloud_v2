import 'package:class_cloud/common/widgets/cairdio_search_bar.dart';
import 'package:class_cloud/common/widgets/custom_app_bar.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:class_cloud/core/go_router/go_router_keys.dart';
import 'package:class_cloud/features/school/screens/schools_screen/cubit/school_list_cubit.dart';
import 'package:class_cloud/features/school/screens/schools_screen/cubit/school_list_state.dart';
import 'package:class_cloud/features/school/screens/schools_screen/widgets/school_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SchoolsScreen extends StatelessWidget {
  const SchoolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Schools',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.goNamed(GoRouterNames.addSchool),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<SchoolListCubit>().fetchAllSchools(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppSearchBar(
                  labelText: 'Search Name',
                  onChanged: (value) =>
                      context.read<SchoolListCubit>().filterSchools(value),
                ),
                const Flexible(child: _Content()),
                const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolListCubit, SchoolListState>(
      builder: (context, state) {
        if (state is SchoolListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SchoolListError) {
          return Center(
            child: Text(state.message, style: TextStyles.body01),
          );
        } else if (state is SchoolListLoaded) {
          if (state.schools.isEmpty) {
            return Center(
              child: Text(
                'No Schools Found',
                style: TextStyles.body01,
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (state.filter.isNotEmpty)
                        for (final school in state.schools
                            .where(
                              (school) => (school.name
                                  .toLowerCase()
                                  .startsWith(state.filter.toLowerCase())),
                            )
                            .toList())
                          SchoolTile(school: school)
                      else
                        for (final school in state.schools)
                          SchoolTile(school: school),
                    ],
                  ),
                ),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
