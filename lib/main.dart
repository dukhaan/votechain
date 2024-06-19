import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/bloc/contract_bloc.dart';
import 'package:votechain/core/app_text_styles.dart';
import 'package:votechain/core/app_theme_data.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.init();
  await SharedPreferencesService.init();
  await Injector.instance.allReady();

  runApp(const MyApp());
}

final appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return AppTheme(
          textTheme: AppTextStyles.style(context),
          child: GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayWidgetBuilder: (_) {
              return const SpinKitChasingDots(
                size: 50,
                color: ColorValues.primary50,
              );
            },
            child: BlocProvider(
              create: (context) => ContractBloc(
                repository: Injector.instance<ContractRepository>(),
              ),
              child: MaterialApp.router(
                theme: votechainThemeData(context),
                routerDelegate: appRouter.delegate(),
                routeInformationParser: appRouter.defaultRouteParser(),
                debugShowCheckedModeBanner: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
