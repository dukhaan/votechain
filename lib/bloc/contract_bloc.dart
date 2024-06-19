import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:votechain/data/models/candidate/candidate_model.dart';
import 'package:votechain/data/models/user/user_model.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/utils/logger.dart';
import 'package:web3dart/credentials.dart';

part 'contract_event.dart';
part 'contract_state.dart';
part 'contract_bloc.freezed.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ContractBloc({
    required ContractRepository repository,
  }) : super(
    const ContractState.loading(),
  ) {
    _repository = repository;

    on<_InitContract>(
      _onInitContract,
    );
    on<_AddCandidate>(
      _onAddCandidate,
    );
    on<_GetCandidates>(
      _onGetCandidates,
    );
    on<_Vote>(
      _onVote,
    );
    on<_CheckIfHasVoted>(
      _onCheckIfHasVoted,
    );
    on<_GetWinner>(
      _onGetWinner,
    );
    on<_Login>(
      _onLogin,
    );
    on<_Logout>(
      _onLogout,
    );
    on<_AddUser>(
      _onAddUser,
    );
    on<_GetUserByAddress>(
      _onGetUserByAddress,
    );

  }

  late final ContractRepository _repository;
  List<CandidateModel> candidates = [];
  bool hasVoted = false;
  EthPrivateKey? privateKey;
  String? address;

  Future<void> _onGetUserByAddress(
      _GetUserByAddress event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      final user = await _repository.getUserByAddress(event.address);
      if (user == null) throw 'User tidak ditemukan';
      emit(ContractState.userLoaded(user));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }

  Future<void> _onLogout(
      _Logout event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      hasVoted = false;
      address = null;
      privateKey = null;
      candidates = [];
      await SharedPreferencesService.clearAllPrefs();
      emit(const ContractState.logoutSuccess());
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }

  Future<void> _onLogin(
      _Login event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      await _repository.login(event.address, event.privateKey);
      await _getCandidates();
      emit(const ContractState.loaded());
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }

  Future<void> _onAddUser(
      _AddUser event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      await _repository.addUser(event.ethAddress, event.isAdmin);
      emit(const ContractState.loaded());
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }

  Future<void> _onInitContract(
      _InitContract event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      await _repository.initializeContract();
      if (SharedPreferencesService.getAddress() != null) {
        final key = SharedPreferencesService.getPrivateKey();
        final addressValue = SharedPreferencesService.getAddress();
        privateKey = EthPrivateKey.fromHex(key!);
        address = addressValue;
        await _getCandidates();
      }
      emit(const ContractState.loaded());
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }

  Future<void> _getCandidates() async {
    candidates = await _repository.getCandidates();
  }

  Future<void> _onAddCandidate(
      _AddCandidate event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      await _repository.addCandidate(event.candidate);
      emit(const ContractState.loaded());
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }

  Future<void> _onGetCandidates(
      _GetCandidates event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      await _getCandidates();
      emit(const ContractState.loaded());
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }

  Future<void> _onVote(
      _Vote event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      await _repository.vote(candidateId: event.candidateId, tpsId: event.tpsId);
      hasVoted = true;
      emit(const ContractState.voteSuccess());
    } catch (e, s) {
      final message = e.toString();
      final error = message.substring(message.indexOf('revert')+6, message.length-2);
      emit(ContractState.error(error));
    }
  }

  Future<void> _onCheckIfHasVoted(
      _CheckIfHasVoted event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      hasVoted = await _repository.checkIfHasVoted();
      emit(const ContractState.loaded());
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }

  Future<void> _onGetWinner(
      _GetWinner event,
      Emitter<ContractState> emit,
      ) async {
    emit(const ContractState.loading());
    try {
      final candidate = await _repository.getWinner();
      emit(ContractState.winnerLoaded(candidate));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(ContractState.error(e.toString()));
    }
  }
}
