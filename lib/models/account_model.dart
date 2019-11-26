
class AccountModel{

  AccountModel({
    this.identifier,
    this.identifierType,
    this.username,
    this.accountType,
    this.address,
    this.wallet
  });

  final String identifier;
  final String identifierType;
  final String username;
  final String accountType;
  final AccountAddress address;
  final List<AccountWallet> wallet;


  final AccountAddress _accountAddress = AccountAddress();
  final AccountWallet _accountWallet = AccountWallet();

  Map<String, dynamic> asMap(){
    return {
      "identifier": identifier,
      "identifierType": identifierType,
      "username": username,
      "accountType": accountType,
      "address": address.asMap(),
      "wallet": wallet.asMap()
    };
  }

  AccountModel fromMap(dynamic data){
    List<AccountWallet> _wallets = [];
    data['wallets'].forEach((item){
      _wallets.add(_accountWallet.fromMap(item));
    });
    return AccountModel(
      identifier: data['identifier'].toString(),
      identifierType: data['identifierType'].toString(),
      username: data['username'].toString(),
      accountType: data['accountType'].toString(),
      address: _accountAddress.fromMap(data['address']),
      wallet: _wallets,
    );
  }
}

class AccountAddress {

  AccountAddress({this.email, this.phoneNo});

  final String phoneNo;
  final String email;

  Map<String, dynamic> asMap(){
    return {
      'email': email,
      'phoneNo': phoneNo
    };
  }

  AccountAddress fromMap(dynamic data){
    return AccountAddress(
      email: data['email'].toString(),
      phoneNo: data['phoneNo'].toString(),
    );
  }
}

class AccountWallet{

  AccountWallet({this.balance, this.walletAccountNo});

  final double balance;
  final String walletAccountNo;

  Map<String, dynamic> asMap(){
    return {
      'balance': balance,
      'walletAccountNo': walletAccountNo
    };
  }
  AccountWallet fromMap(dynamic data){
    return AccountWallet(
      balance: double.parse(data['balance'].toString()),
      walletAccountNo: data['walletAccountNo'].toString(),
    );
  }
}

