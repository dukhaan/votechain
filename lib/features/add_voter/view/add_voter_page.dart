import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:votechain/bloc/contract_bloc.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/models/city/city_model.dart';
import 'package:votechain/data/models/district/district_model.dart';
import 'package:votechain/data/models/province/province_model.dart';
import 'package:votechain/data/models/subdistrict/sub_district_model.dart';
import 'package:votechain/data/models/tps/tps_model.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_text_field.dart';

@RoutePage()
class AddVoterPage extends StatefulWidget {
  const AddVoterPage({super.key});

  @override
  State<AddVoterPage> createState() => _AddVoterPageState();
}

class _AddVoterPageState extends State<AddVoterPage> {
  final _addressController = TextEditingController();
  final _provinceController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _subDistrictController = TextEditingController();
  final _tpsController = TextEditingController();
  final _controller = TextEditingController();

  ProvinceModel? _selectedProvince;
  CityModel? _selectedCity;
  DistrictModel? _selectedDistrict;
  SubDistrictModel? _selectedSubDistrict;
  TPSModel? _selectedTps;

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
              AutoRouter.of(context).maybePop();
            },
            error: (s) {
              context.loaderOverlay.hide();
              context.showSnackBar(message: s.message, isSuccess: false);
            },
            orElse: () {});
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Voter'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Styles.defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEthAddressField(),
                const SizedBox(height: Styles.defaultPadding),
                // _buildProvinceField(),
                // const SizedBox(height: Styles.defaultPadding),
                // _buildCityField(),
                // const SizedBox(height: Styles.defaultPadding),
                // _buildDistrictField(),
                // const SizedBox(height: Styles.defaultPadding),
                // _buildSubDistrictField(),
                // const SizedBox(height: Styles.defaultPadding),
                // _buildTPSField(),
                // const SizedBox(height: Styles.extraBigPadding),
                _buildButtonSubmit(context),
                const SizedBox(height: Styles.defaultPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEthAddressField() {
    return CustomTextField(
      controller: _addressController,
      label: 'Alamat Ethereum',
      hintText: 'Alamat Ethereum',
      borderColor: ColorValues.info50,
      isRequired: true,
    );
  }

  Widget _buildProvinceField() {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(PickLocationRoute());
      },
      child: CustomTextField(
        controller: _provinceController,
        label: 'Provinsi',
        hintText: 'Provinsi',
        borderColor: ColorValues.info50,
        isRequired: true,
        enabled: false,
      ),
    );
  }

  Widget _buildCityField() {
    return CustomTextField(
      controller: _cityController,
      label: 'Kabupaten/Kota',
      hintText: 'Kabupaten/Kota',
      borderColor: ColorValues.info50,
      isRequired: true,
      enabled: false,
    );
  }

  Widget _buildDistrictField() {
    return CustomTextField(
      controller: _districtController,
      label: 'Kecamatan',
      hintText: 'Kecamatan',
      borderColor: ColorValues.info50,
      isRequired: true,
      enabled: false,
    );
  }

  Widget _buildSubDistrictField() {
    return CustomTextField(
      controller: _subDistrictController,
      label: 'Kelurahan',
      hintText: 'Kelurahan',
      borderColor: ColorValues.info50,
      isRequired: true,
      enabled: false,
    );
  }

  Widget _buildTPSField() {
    return CustomTextField(
      controller: _tpsController,
      hintText: 'TPS',
      label: 'TPS',
      borderColor: ColorValues.info50,
      isRequired: true,
      enabled: false,
    );
  }

  Widget _buildButtonSubmit(BuildContext context) {
    return CustomButton(
      text: 'Tambah',
      onPressed: () {
        try {
          final address = _addressController.text.trimLeft().trimRight();
          if (address.isEmpty) {
            throw 'Alamat Ethereum tidak boleh kosong';
          }
          BlocProvider.of<ContractBloc>(context).add(ContractEvent.addUser(address, false));
        } catch (e) {
          context.showSnackBar(message: e.toString(), isSuccess: false);
        }
      },
      backgroundColor: ColorValues.info50,
      width: MediaQuery
          .of(context)
          .size
          .width,
    );
  }
}
