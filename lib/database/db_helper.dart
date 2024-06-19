import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class DbHelper {
  static const rpcUrl = 'http://192.168.18.11:7545';
  static const wsUrl = 'ws://192.168.18.11:7545';

  static DeployedContract? contract;
  static Credentials? userCredential;
  static Map<String, dynamic>? abi;
  static EthereumAddress? contractAddress;
  static final httpClient = Client();
  static final ethClient = Web3Client(rpcUrl, httpClient);
}
