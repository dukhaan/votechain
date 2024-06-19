import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_text_field.dart';

@RoutePage()
class AddCandidatePage extends StatelessWidget {
  const AddCandidatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tambah Kandidat'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNameField(),
              const SizedBox(height: Styles.defaultPadding),
              _buildViceNameField(),
              const SizedBox(height: Styles.defaultPadding),
              _buildVisionField(context),
              const SizedBox(height: Styles.defaultPadding),
              _buildMissionField(context),
              const SizedBox(height: Styles.extraBigPadding),
              _buildButtonSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'Nama Kandidat',
      borderColor: ColorValues.info50,
      isRequired: true,
    );
  }

  Widget _buildViceNameField() {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'Nama Wakil Kandidat',
      borderColor: ColorValues.info50,
      isRequired: true,
    );
  }

  Widget _buildVisionField(BuildContext context) {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'Visi',
      borderColor: ColorValues.info50,
      isRequired: true,
      maxLines: 3,
    );
  }

  Widget _buildMissionField(BuildContext context) {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'Misi',
      borderColor: ColorValues.info50,
      isRequired: true,
      maxLines: 3,
    );
  }

  Widget _buildButtonSubmit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
      child: CustomButton(
        text: 'Submit',
        onPressed: () {},
        backgroundColor: ColorValues.info50,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
