import 'package:votechain/data/models/candidate/candidate_model.dart';
import 'package:votechain/data/models/user/user_model.dart';

abstract class ContractRepository {
  Future<void> initializeContract();

  Future<void> login(String address, String privateKey);

  Future<void> vote({
    required int candidateId,
    required String tpsId,
  });

  Future<void> addCandidate(CandidateModel candidate);

  Future<List<CandidateModel>> getCandidates();

  Future<void> addUser(String ethAddress, bool isAdmin);

  Future<bool> checkIfHasVoted();

  Future<CandidateModel> getWinner();

  Future<UserModel?> getUserByAddress(String address);
}
