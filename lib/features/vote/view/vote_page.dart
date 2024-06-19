import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/bloc/contract_bloc.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/models/candidate/candidate_model.dart';
import 'package:votechain/data/models/tps/tps_model.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/widgets/custom_alert_dialog.dart';
import 'package:votechain/widgets/custom_button.dart';

@RoutePage()
class VotePage extends StatefulWidget {
  const VotePage({super.key});

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  late final ContractBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<ContractBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractBloc, ContractState>(
  listener: (context, state) {
    state.maybeMap(
        voteSuccess: (s) {
          context.loaderOverlay.hide();
          AutoRouter.of(context).maybePop();
        },
        orElse: () {});
  },
  child: Scaffold(
      appBar: AppBar(
        title: const Text('Voting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopIntroWidget(),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
              _buildCandidateSectionWidget(),
            ],
          ),
        ),
      ),
    ),
);
  }

  Widget _buildCandidateSectionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calon Presiden 2024',
          style: context.textTheme.titleMedium,
        ),
        Text('${_bloc.candidates.length} calon kandidat'),
        const SizedBox(
          height: Styles.biggerSpacing,
        ),
        _buildCandidateListWidget(),
      ],
    );
  }

  Widget _buildCandidateListWidget() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, i) =>
            _buildCandidateItemWidget(_bloc.candidates[i], i),
        separatorBuilder: (_, __) => const SizedBox(
              height: Styles.biggerSpacing,
            ),
        itemCount: _bloc.candidates.length);
  }

  Widget _buildCandidateItemWidget(CandidateModel candidate, int i) {
    return Container(
      decoration: BoxDecoration(
        color: ColorValues.info10,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      padding: const EdgeInsets.all(Styles.defaultPadding),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Styles.defaultBorder),
            child: CachedNetworkImage(
              imageUrl: candidate.imageUrl,
              height: 27.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
          Text(
            'Pasangan calon ${i + 1}\n${candidate.leadName} - ${candidate.viceName}',
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium
                .copyWith(color: ColorValues.info60),
          ),
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  isOutlined: true,
                  text: 'Detail',
                  textColor: ColorValues.primary60,
                  onPressed: () {
                    AutoRouter.of(context).push(CandidateDetailRoute(candidate: candidate));
                  },
                ),
              ),
              const SizedBox(
                width: Styles.bigSpacing,
              ),
              Expanded(
                  child: CustomButton(
                text: 'Vote',
                backgroundColor: ColorValues.primary60,
                prefixIcon: Iconsax.medal_star,
                onPressed: () {
                  showDialog(context: context, builder: (_) => CustomAlertDialog(
                    title: 'Konfirmasi',
                    description: 'Apakah Anda yakin ingin memilih ${candidate.leadName} - ${candidate.viceName}?',
                    proceedText: 'Ya',
                    cancelText: 'Tidak',
                    proceedAction: () {
                      TPSModel dummyModel = const TPSModel(
                        name: 'TPS 01',
                        id: '350101200101',
                        provinceId: '35',
                        cityId: '3501',
                        districtId: '350101',
                        subDistrictId: '3501012001',
                      );
                      _bloc.add(ContractEvent.vote(candidate.id, dummyModel.id!));
                    },
                  ));
                },
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTopIntroWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat Datang!',
          style: context.textTheme.titleLarge,
        ),
        const Text('Gunakan hak suaramu dengan bijak.'),
      ],
    );
  }
}
