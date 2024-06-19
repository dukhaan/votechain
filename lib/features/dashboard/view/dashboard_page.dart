import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/bloc/contract_bloc.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/models/candidate/candidate_model.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/utils/logger.dart';
import 'package:votechain/widgets/custom_alert_dialog.dart';
import 'package:votechain/widgets/custom_button.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _repository = Injector.instance<ContractRepository>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ContractBloc>(context);
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        state.maybeMap(
            loading: (s) {
              context.loaderOverlay.show();
            },
            logoutSuccess: (s) {
              context.loaderOverlay.hide();
              AutoRouter.of(context).replace(const LoginRoute());
            },
            error: (s) {
              context.loaderOverlay.hide();
              context.showSnackBar(message: s.message, isSuccess: false);
            },
            loaded: (s) {
              context.loaderOverlay.hide();
            },
            orElse: () {});
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => CustomAlertDialog(
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
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.all(Styles.defaultPadding),
                  child: Center(
                    child: BlocBuilder<ContractBloc, ContractState>(
                      builder: (context, state) {
                        return state.maybeMap(voteSuccess: (s) {
                          return const Text('Kamu telah memilih!');
                        }, orElse: () {
                          return _buildBody(context, bloc);
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _buildBody(BuildContext context, ContractBloc bloc) {
    return Column(
      children: [
        Image.asset(
          'assets/images/amico.png',
          width: 100.w,
          height: 40.h,
        ),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        Text(
          'Ayo tentukan pilihanmu dengan tidak golput!',
          style: context.textTheme.titleLarge.copyWith(
            color: ColorValues.primary50,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        const Text(
          'Bersama-sama mari wujudkan pemilu yang berkualitas, untuk menjadikan Indonesia lebih baik',
          style: TextStyle(color: ColorValues.grey50),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        CustomButton(
          text: 'Mulai Voting',
          onPressed: () {
            AutoRouter.of(context).push(const VoteRoute());
          },
        ),
        const SizedBox(height: Styles.bigSpacing),
        // CustomButton(
        //     text: 'Add User',
        //     onPressed: () async {
        //       try {
        //         context.loaderOverlay.show();

        //         await _repository.addUser(
        //             '0x77DceeD1a166Cf5A0e873f69f54584778FFcb715', true);
        //         await _repository.addUser(
        //             '0x0E2d74f8e5D9E7a5FA0C0CC34abbdbde8b05497f', false);
        //         await _repository.addUser(
        //             '0x6CB39A500e9CE6F45B208858d3683D7D38B7EC0C', false);
        //       } catch (e, s) {
        //         logger.e(e.toString(), stackTrace: s);
        //       }
        //       context.loaderOverlay.hide();
        //     }),

        // CustomButton(
        //   text: 'Add Candidate',
        //   onPressed: () async {
        //     try {
        //       context.loaderOverlay.show();
        //       await SharedPreferencesService.setAddress(value: '0x77DceeD1a166Cf5A0e873f69f54584778FFcb715');
        //       await SharedPreferencesService.setPrivateKey(value: '0x725e8aef64c68b2c73355308e97c2835c4890a7ab3083fd9877929c530c8d5ee');
        //       const candidate1 = CandidateModel(
        //         id: 0,
        //         leadName: 'Joni Ketsuhat',
        //         viceName: 'Jian Denoral',
        //         imageUrl:
        //             'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/candidate1.png?alt=media&token=6e76a4c4-6a6b-45b2-ba1d-b6a20e121eae',
        //         mission: 'JoJi lorem ipsum dolor sit amet mission.',
        //         vision: 'JoJi lorem ipsum dolor sit amet vision.',
        //       );
        //       const candidate2 = CandidateModel(
        //         id: 0,
        //         leadName: 'Daiki Tempest',
        //         viceName: 'MeiMei Jinshi',
        //         imageUrl:
        //             'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/candidate2.png?alt=media&token=59eeff43-2a7f-4b62-ba09-7fd8c72c3e70',
        //         mission: 'DaMe lorem ipsum dolor sit amet mission.',
        //         vision: 'DaMe lorem ipsum dolor sit amet vision.',
        //       );
        //       const candidate3 = CandidateModel(
        //         id: 0,
        //         leadName: 'Dorothy Nava',
        //         viceName: 'Nothan Shirone',
        //         imageUrl:
        //             'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/candidate3.png?alt=media&token=ca425579-0f9c-4cac-8e99-ff39cc1ca106',
        //         mission: 'DoNot lorem ipsum dolor sit amet mission.',
        //         vision: 'DoNot l ipsum dolor sit amet vision.',
        //       );

        //       await _repository.addCandidate(candidate1);
        //       await _repository.addCandidate(candidate2);
        //       await _repository.addCandidate(candidate3);
        //     } catch (e, s) {
        //       logger.e(e.toString(), stackTrace: s);
        //     }
        //     context.loaderOverlay.hide();
        //   },
        // ),
        // const SizedBox(
        //   height: Styles.defaultSpacing,
        // ),
      ],
    );
  }
}
