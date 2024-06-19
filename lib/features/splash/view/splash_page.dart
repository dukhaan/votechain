import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:votechain/bloc/contract_bloc.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    BlocProvider.of<ContractBloc>(context).add(const ContractEvent.initContract());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        state.maybeMap(
            loaded: (s) {
              final user = SharedPreferencesService.getUser();
              if (user != null) {
                if (user.isAdmin) {
                  AutoRouter.of(context).replace(const NavigatorRoute());
                } else {
                  AutoRouter.of(context).replace(const DashboardRoute());
                }
              } else {
                AutoRouter.of(context).replace(const LoginRoute());
              }
            }, orElse: () {});
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VoteChain',
                style: context.textTheme.titleExtraLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
