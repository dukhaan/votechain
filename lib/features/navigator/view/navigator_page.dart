import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:votechain/bloc/contract_bloc.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/widgets/custom_alert_dialog.dart';

@RoutePage()
class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ContractBloc>(context);

    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        state.maybeMap(
            logoutSuccess: (s) {
              context.loaderOverlay.hide();
              AutoRouter.of(context).replace(const LoginRoute());
            },
            error: (s) {
              context.loaderOverlay.hide();
              context.showSnackBar(message: s.message, isSuccess: false);
            },

            orElse: () {});
      },
      child: AutoTabsRouter.pageView(
        routes: const [
          AdminDashboardRoute(),
          LocationRoute(),
          // TpsRoute(),
          // CandidateRoute(),
        ],
        builder: (context, child, _) {
          final tabsRouter = AutoTabsRouter.of(context);
          var title = 'Dashboard';
          switch (tabsRouter.activeIndex) {
            case 0:
              title = 'Dashboard';
              break;
            case 1:
              title = 'Lokasi';
              break;
            case 2:
              title = 'TPS';
              break;
            case 3:
              title = 'Kandidat';
              break;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              CustomAlertDialog(
                                title: 'Konfirmasi',
                                description:
                                'Apakah kamu yakin ingin logout dari aplikasi?',
                                proceedAction: () {
                                  bloc.add(const ContractEvent.logout());
                                },
                                cancelText: 'Tidak',
                                proceedText: 'Ya',
                              ));
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: ColorValues.danger50,
                    ))
              ],
            ),
            body: child,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Styles.bigPadding),
              child: NavigationBar(
                selectedIndex: tabsRouter.activeIndex,
                onDestinationSelected: tabsRouter.setActiveIndex,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(IconsaxPlusBold.home),
                    label: 'Dashboard',
                  ),
                  NavigationDestination(
                    icon: Icon(IconsaxPlusBold.location),
                    label: 'Lokasi',
                  ),
                  // NavigationDestination(
                  //   icon: Icon(IconsaxPlusBold.flag),
                  //   label: 'TPS',
                  // ),
                  // NavigationDestination(
                  //   icon: Icon(Icons.location_on),
                  //   label: 'Kandidat',
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
