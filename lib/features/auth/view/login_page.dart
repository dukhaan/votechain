import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/bloc/contract_bloc.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_text_field.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _addressController = TextEditingController();
  final _privateKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ContractBloc>(context);
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        state.maybeMap(
            loading: (s) {
              context.loaderOverlay.show();
            },
            loaded: (s) {
              context.loaderOverlay.hide();
              final user = SharedPreferencesService.getUser();
              if (user!.isAdmin) {
                AutoRouter.of(context).replace(const NavigatorRoute());
              } else {
                AutoRouter.of(context).replace(const DashboardRoute());
              }
            },
            error: (s) {
              context.loaderOverlay.hide();
              context.showSnackBar(message: s.message, isSuccess: false);
            },
            orElse: () {});
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login'), backgroundColor: ColorValues.white,),
        body: Container(
          height: 100.h,
          width: 100.w,
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: _addressController,
                  hintText: 'ETH Address',
                  label: 'ETH Address',
                  isRequired: true,
                ),
                const SizedBox(
                  height: Styles.defaultSpacing,
                ),
                CustomTextField(
                  controller: _privateKeyController,
                  hintText: 'Private Key',
                  label: 'Private Key',
                  isRequired: true,
                ),
                const SizedBox(
                  height: Styles.bigSpacing,
                ),
                CustomButton(
                  text: 'Login',
                  onPressed: () async {
                    if (!(_formKey.currentState?.validate() ?? true)) return;
                    final address =
                        _addressController.text.trimLeft().trimRight();
                    final hex =
                        _privateKeyController.text.trimLeft().trimRight();
                    bloc.add(ContractEvent.login(address, hex));
                  },
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
