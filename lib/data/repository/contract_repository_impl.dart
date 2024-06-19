import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:votechain/data/models/candidate/candidate_model.dart';
import 'package:votechain/data/models/user/user_model.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/database/db_helper.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

class ContractRepositoryImpl extends ContractRepository {
  @override
  Future<void> initializeContract() async {
    await getAbi();
    logger.d('abi ${DbHelper.abi}');
    DbHelper.contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(DbHelper.abi!['abi']), 'Election'),
        DbHelper.contractAddress!);
    logger.d('contract ${DbHelper.contract}');
  }

  Future<void> getAbi() async {
    final abiStringFile =
        await rootBundle.loadString('src/artifacts/Election.json');
    DbHelper.abi = jsonDecode(abiStringFile);
    logger.d('db helper abi true');
    DbHelper.contractAddress =
        EthereumAddress.fromHex(DbHelper.abi!['networks']['5777']['address']);
    logger.d('contract address ${DbHelper.contractAddress}');
  }

  Future<void> getDeployedContract() async {
    DbHelper.contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(DbHelper.abi), 'Election'),
        DbHelper.contractAddress!);
    logger.d('contract ${DbHelper.contract}');
  }

  @override
  Future<void> vote({
    required int candidateId,
    required String tpsId,
  }) async {
    final privateKey =
    EthPrivateKey.fromHex(SharedPreferencesService.getPrivateKey()!);
    final function = DbHelper.contract!.function('vote');

    final transaction = Transaction.callContract(
        contract: DbHelper.contract!,
        function: function,
        parameters: [
          BigInt.from(candidateId),
          tpsId,
        ]);
    logger.d('private key ${privateKey.toString()}');
    final res = await DbHelper.ethClient.sendTransaction(
      privateKey,
      transaction,
      chainId: 1337,
    );
    logger.d('res $res');
  }

  @override
  Future<void> addCandidate(CandidateModel candidate) async {
    final privateKey =
        EthPrivateKey.fromHex(SharedPreferencesService.getPrivateKey()!);
    final function = DbHelper.contract!.function('addCandidate');

    final transaction = Transaction.callContract(
        contract: DbHelper.contract!,
        function: function,
        parameters: [
          candidate.leadName,
          candidate.viceName,
          candidate.imageUrl,
          candidate.vision,
          candidate.mission,
        ]);
    logger.d('private key ${privateKey.toString()}');
    final res = await DbHelper.ethClient.sendTransaction(
      privateKey,
      transaction,
      chainId: 1337,
    );
    logger.d('res $res');
  }

  @override
  Future<List<CandidateModel>> getCandidates() async {
    final list = <CandidateModel>[];

    final function = DbHelper.contract!.function('getCandidates');

    final res = await DbHelper.ethClient.call(
      contract: DbHelper.contract!,
      function: function,
      params: [],
    );
    for (final data in res[0]) {
      BigInt id = data[0];
      final candidate = CandidateModel(
          id: id.toInt(),
          leadName: data[1],
          viceName: data[2],
          imageUrl: data[3],
          vision: data[4],
          mission: data[5]);
      list.add(candidate);
    }
    logger.d('candidates $list');
    return list;
  }

  @override
  Future<bool> checkIfHasVoted() async {
    final function = DbHelper.contract!.function('hasVoted');

    final res = await DbHelper.ethClient.call(
      contract: DbHelper.contract!,
      function: function,
      params: [],
    );
    logger.d('res $res');
    return res[0] ?? false;
  }

  @override
  Future<CandidateModel> getWinner() async {
    final function = DbHelper.contract!.function('getWinner');

    final res = await DbHelper.ethClient.call(
      contract: DbHelper.contract!,
      function: function,
      params: [],
    );
    final data = res[0];
    final BigInt id = data[0];
    final candidate = CandidateModel(
        id: id.toInt(),
        leadName: data[1],
        viceName: data[2],
        imageUrl: data[3],
        vision: data[4],
        mission: data[5]);

    return candidate;
  }

  @override
  Future<void> login(String address, String privateKey) async {
    final user = await getUserByAddress(address);
    if (user == null) throw 'User tidak ditemukan';
    await SharedPreferencesService.setUser(value: user);
    await SharedPreferencesService.setAddress(value: address);
    await SharedPreferencesService.setPrivateKey(value: privateKey);
  }

  @override
  Future<void> addUser(String ethAddress, bool isAdmin) async {
    final privateKey =
        EthPrivateKey.fromHex(SharedPreferencesService.getPrivateKey()!);
    final function = DbHelper.contract!.function('addUser');

    final transaction = Transaction.callContract(
        contract: DbHelper.contract!,
        function: function,
        parameters: [
          EthereumAddress.fromHex(ethAddress),
          isAdmin,
        ]);
    final res = await DbHelper.ethClient.sendTransaction(
      privateKey,
      transaction,
      chainId: 1337,
    );
    logger.d('res $res');
  }

  @override
  Future<UserModel?> getUserByAddress(String address) async {
    final function = DbHelper.contract!.function('getUserByAddress');

    final res = await DbHelper.ethClient.call(
      contract: DbHelper.contract!,
      function: function,
      params: [EthereumAddress.fromHex(address)],
    );
    logger.d('res $res');
    final data = res[0] as List<dynamic>;

    if (data.isEmpty) return null;

    final BigInt id = data[0];
    if (id.toInt() == 0) return null;
    final ethAddress = data[1] as EthereumAddress;
    final candidate = UserModel(
        id: id.toInt(),
        ethAddress: ethAddress.hex,
        isAdmin: data[2],
    );

    return candidate;
  }
}
