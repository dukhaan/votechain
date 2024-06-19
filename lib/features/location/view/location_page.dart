import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';

@RoutePage()
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 42),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Styles.defaultPadding,
                          vertical: Styles.defaultPadding,
                        ),
                        child: _buildProvinsiCard(context),
                      ),
                      _buildKabupatenCard(context),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Styles.defaultPadding,
                        ),
                        child: _buildKecamatanCard(context),
                      ),
                      _buildKelurahanCard(context),
                    ],
                  ),
                  const SizedBox(
                      height: 20), 
                  _buildDropdownProvinsi(),
                  const SizedBox(
                      height: 24),
                  _buildDropdownKabupaten(),
                  const SizedBox(
                      height: 24),
                  _buildDropdownKecamatan(),
                  const SizedBox(
                      height: 24),
                  _buildDropdownKelurahan(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvinsiCard(BuildContext context) {
    return Container(
      height: 96,
      width: 156,
      decoration: BoxDecoration(
        color: ColorValues.info10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 20), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '34',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), 
            Text(
              'Provinsi',
              style: TextStyle(
                color: ColorValues.info50,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKabupatenCard(BuildContext context) {
    return Container(
      height: 96,
      width: 156,
      decoration: BoxDecoration(
        color: ColorValues.info10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 20), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '128',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), 
            Text(
              'Kabupaten/Kota',
              style: TextStyle(
                color: ColorValues.info50,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKecamatanCard(BuildContext context) {
    return Container(
      height: 96,
      width: 156,
      decoration: BoxDecoration(
        color: ColorValues.info10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '500',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Kecamatan',
              style: TextStyle(
                color: ColorValues.info50,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKelurahanCard(BuildContext context) {
    return Container(
      height: 96,
      width: 156,
      decoration: BoxDecoration(
        color: ColorValues.info10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1256',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), 
            Text(
              'Kelurahan',
              style: TextStyle(
                color: ColorValues.info50,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildDropdownProvinsi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorValues.info50), 
          ),
        ),
        items: <String>['Jawa Timur', 'Jawa Tengah', 'Jawa Barat']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {},
        hint: const Text('Provinsi'), 
      ),
    );
  }


  Widget _buildDropdownKabupaten() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorValues.info50),
          ),
        ),
        items: <String>['Sidoarjo', 'Surabaya', 'Gresik']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {},
        hint: const Text('Kabupaten/Kota'),
      ),
    );
  }

  Widget _buildDropdownKecamatan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorValues.info50),
          ),
        ),
        items: <String>['Tulangan', 'Tanggulangin', 'Jemursari', 'SUkolilo']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {},
        hint: const Text('Kecamatan'), 
      ),
    );
  }

  Widget _buildDropdownKelurahan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorValues.info50), 
          ),
        ),
        items: <String>['Wates', 'Randegan', 'Pangkemiri', 'Ketegan']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {},
        hint: const Text('Kelurahan'),
      ),
    );
  }
}
