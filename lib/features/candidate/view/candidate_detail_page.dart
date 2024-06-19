import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/models/candidate/candidate_model.dart';
import 'package:votechain/utils/extensions.dart';

@RoutePage()
class CandidateDetailPage extends StatelessWidget {
  const CandidateDetailPage({super.key, required this.candidate});
  final CandidateModel candidate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Kandidat'),),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 100.w,
          child: Padding(
            padding: const EdgeInsets.all(Styles.defaultPadding),
            child: Column(
              children: [
                Text('Visi', style: context.textTheme.titleLarge, textAlign: TextAlign.center,),
                const SizedBox(height: Styles.defaultSpacing,),
                Text(candidate.vision),
                const SizedBox(height: Styles.bigSpacing,),
                Text('Misi', style: context.textTheme.titleLarge, textAlign: TextAlign.center,),
                const SizedBox(height: Styles.defaultSpacing,),
                Text(candidate.mission),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
