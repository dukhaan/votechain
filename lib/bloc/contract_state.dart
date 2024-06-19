part of 'contract_bloc.dart';

@freezed
class ContractState with _$ContractState {
  const factory ContractState.initial() = _Initial;
  const factory ContractState.loading() = _Loading;
  const factory ContractState.loaded() = _Loaded;
  const factory ContractState.logoutSuccess() = _LogoutSuccess;
  const factory ContractState.loginSuccess() = _LoginSuccess;
  const factory ContractState.voteSuccess() = _VoteSuccess;
  const factory ContractState.error(String message) = _Error;
  const factory ContractState.winnerLoaded(CandidateModel candidate) = _WinnerLoaded;
  const factory ContractState.userLoaded(UserModel user) = _UserLoaded;
}
