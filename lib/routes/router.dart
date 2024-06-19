import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/data/models/candidate/candidate_model.dart';
import 'package:votechain/data/models/city/city_model.dart';
import 'package:votechain/data/models/district/district_model.dart';
import 'package:votechain/data/models/province/province_model.dart';
import 'package:votechain/data/models/subdistrict/sub_district_model.dart';

import '../features/pages.dart';

part 'router.gr.dart';

// generate with dart run build_runner build
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SplashRoute.page,
          path: '/splash',
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: DashboardRoute.page,
          path: '/dashboard',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: LoginRoute.page,
          path: '/login',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
            page: NavigatorRoute.page,
            path: '/navigator',
            transitionsBuilder: TransitionsBuilders.fadeIn,
            children: [
              CustomRoute(
                page: AdminDashboardRoute.page,
                path: 'admin-dashboard',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
              CustomRoute(
                page: LocationRoute.page,
                path: 'location',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
              CustomRoute(
                page: TpsRoute.page,
                path: 'tps',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
              CustomRoute(
                page: CandidateRoute.page,
                path: 'candidate',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
            ]),
        CustomRoute(
          page: AddCandidateRoute.page,
          path: '/add-candidate',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: AddLocationRoute.page,
          path: '/add-location',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: AddVoterRoute.page,
          path: '/add-voter',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: AddTpsRoute.page,
          path: '/add-tps',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: VoteRoute.page,
          path: '/vote',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: CandidateDetailRoute.page,
          path: '/candidate-detail',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: PickLocationRoute.page,
          path: '/pick-location',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ];
}
