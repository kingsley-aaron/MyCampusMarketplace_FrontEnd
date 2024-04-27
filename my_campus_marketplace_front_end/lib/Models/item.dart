class Item {
  int itemId;
  String itemName;
  String itemDesc;
  String itemCondition;
  double itemPrice;
  int itemQuantity;
  bool itemWanted;
  String itemImage;
  int userId;
  DateTime itemAdded;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemDesc,
    required this.itemCondition,
    required this.itemPrice,
    required this.itemQuantity,
    required this.itemWanted,
    required this.itemImage,
    required this.userId,
    required this.itemAdded,
  });
}
