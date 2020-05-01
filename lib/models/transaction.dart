enum TransactionStatus {
  SUCCESSFUL,
  FAILED, // Technical Error
  WAITING,
  DECLINED, // Rejected by Other Party
  CANCELLED // Changed Mind
}

enum TransactionType { SELL, BUY }

class Transaction {
  String otherPartyIconUrl;
  String otherPartyName;
  String otherPartyNick;

  String timestamp;

  TransactionType type;
  TransactionStatus status;

  String prodIconURL;

  String rate;
  String qty;
  String amt;
}
