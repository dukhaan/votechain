import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_drop_down_field.dart';
import 'package:votechain/widgets/custom_text_field.dart';

@RoutePage()
class AddTpsPage extends StatelessWidget {
  const AddTpsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tambah TPS'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProvinceField(),
              const SizedBox(height: Styles.defaultPadding),
              _buildCityField(),
              const SizedBox(height: Styles.defaultPadding),
              _buildDistrictField(),
              const SizedBox(height: Styles.defaultPadding),
              _buildSubDistrictField(),
              const SizedBox(height: Styles.defaultPadding),
              _buildNoTpsField(),
              const SizedBox(height: Styles.extraBigPadding),
              _buildButtonSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceField() {
    return CustomDropDownField(
      items: const [
        DropdownMenuItem(value: 'Option 1', child: Text('Jawa Timur')),
        DropdownMenuItem(value: 'Option 2', child: Text('Jawa Barat')),
      ],
      value: null,
      onChanged: (newValue) {},
      hintText: 'Provinsi',
      icon: Iconsax.arrow_down_14,
      iconColor: ColorValues.info50,
      borderColor: ColorValues.info50,
      borderWidth: 2,
      isRequired: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }

  Widget _buildCityField() {
    return CustomDropDownField(
      items: const [
        DropdownMenuItem(value: 'Option 1', child: Text('Surabaya')),
        DropdownMenuItem(value: 'Option 2', child: Text('Sidoarjo')),
      ],
      value: null,
      onChanged: (newValue) {},
      hintText: 'Kota',
      icon: Iconsax.arrow_down_14,
      iconColor: ColorValues.info50,
      borderColor: ColorValues.info50,
      borderWidth: 2,
      isRequired: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }

  Widget _buildDistrictField() {
    return CustomDropDownField(
      items: const [
        DropdownMenuItem(value: 'Option 1', child: Text('Gubeng')),
        DropdownMenuItem(value: 'Option 2', child: Text('Tambaksari')),
      ],
      value: null,
      onChanged: (newValue) {},
      hintText: 'Kecamatan',
      icon: Iconsax.arrow_down_14,
      iconColor: ColorValues.info50,
      borderColor: ColorValues.info50,
      borderWidth: 2,
      isRequired: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }

  Widget _buildSubDistrictField() {
    return CustomDropDownField(
      items: const [
        DropdownMenuItem(value: 'Option 1', child: Text('Ketintang')),
        DropdownMenuItem(value: 'Option 2', child: Text('Kupang')),
      ],
      value: null,
      onChanged: (newValue) {},
      hintText: 'Kelurahan',
      icon: Iconsax.arrow_down_14,
      iconColor: ColorValues.info50,
      borderColor: ColorValues.info50,
      borderWidth: 2,
      isRequired: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }

  Widget _buildNoTpsField() {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'Nomor TPS',
      borderColor: ColorValues.info50,
      borderWidth: 2,
      isRequired: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill in this field';
        }
        return null;
      },
    );
  }

  Widget _buildButtonSubmit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
      child: CustomButton(
          backgroundColor: ColorValues.info50,
          width: MediaQuery.of(context).size.width,
          text: 'Tambah',
          onPressed: () {
            AutoRouter.of(context).maybePop();
          }),
    );
  }
}
