import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/models/city/city_model.dart';
import 'package:votechain/data/models/district/district_model.dart';
import 'package:votechain/data/models/province/province_model.dart';
import 'package:votechain/data/models/subdistrict/sub_district_model.dart';
import 'package:votechain/features/pick_location/bloc/location_bloc.dart';
import 'package:votechain/features/pick_location/data/repository/location_repository.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/widgets/custom_button.dart';

@RoutePage()
class PickLocationPage extends StatefulWidget {
  const PickLocationPage(
      {super.key,
      this.provinceModel,
      this.cityModel,
      this.districtModel,
      this.subDistrictModel});

  final ProvinceModel? provinceModel;
  final CityModel? cityModel;
  final DistrictModel? districtModel;
  final SubDistrictModel? subDistrictModel;

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  final _bloc =
      LocationBloc(repository: Injector.instance<LocationRepository>());
  final ValueNotifier<int?> _selectedIndex = ValueNotifier(null);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(const LocationEvent.getProvinces());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      bloc: _bloc,
      listener: (context, state) {
        state.maybeMap(loading: (s) {
          context.loaderOverlay.show();
        }, orElse: () {
          context.loaderOverlay.hide();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pilih Lokasi'),
        ),
        bottomNavigationBar: Container(
          width: 100.w,
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: CustomButton(
            text: 'Pilih',
            onPressed: () {},
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: BlocBuilder<LocationBloc, LocationState>(
        bloc: _bloc,
        builder: (context, state) {
          return state.maybeMap(provinceLoaded: (s) {
            return _buildProvinceBody(s.provinceModel);
          }, orElse: () {
            return Container();
          });
        },
      ),
    );
  }

  Widget _buildProvinceBody(List<ProvinceModel> list) {
    return ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (_, __, ___) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) => _buildProvinceItem(list[i], i),
              itemCount: list.length);
        });
  }

  Widget _buildProvinceItem(ProvinceModel data, int i) {
    bool isSelected = _selectedIndex.value == i;
    return Container(
      padding: const EdgeInsets.all(Styles.defaultPadding),
      child: GestureDetector(
        onTap: () {
          _selectedIndex.value = i;
        },
        child: Row(
          children: [
            Expanded(child: Text(data.name)),
            if (isSelected)
              const SizedBox(
                width: Styles.defaultSpacing,
              ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: ColorValues.success50,
              ),
          ],
        ),
      ),
    );
  }
}
