part of 'contract_bloc.dart';

@freezed
class ContractEvent with _$ContractEvent {
  const factory ContractEvent.started() = _Started;
  const factory ContractEvent.logout() = _Logout;
  const factory ContractEvent.login(String address, String privateKey) = _Login;
  const factory ContractEvent.initContract() = _InitContract;
  const factory ContractEvent.addUser(String ethAddress, bool isAdmin) = _AddUser;
  const factory ContractEvent.addCandidate(CandidateModel candidate) = _AddCandidate;
  const factory ContractEvent.getCandidates() = _GetCandidates;
  const factory ContractEvent.vote(int candidateId, String tpsId) = _Vote;
  const factory ContractEvent.checkIfHasVoted() = _CheckIfHasVoted;
  const factory ContractEvent.getWinner(CandidateModel candidateModel) = _GetWinner;
  const factory ContractEvent.getUserByAddress(String address) = _GetUserByAddress;
}
