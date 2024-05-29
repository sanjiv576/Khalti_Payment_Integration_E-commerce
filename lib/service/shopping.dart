import 'dart:developer';

import '../models/product_entity.dart';
import '../models/purchase_entity.dart';
import '../state/purchase_state.dart';

class Shopping {
  static double _totalPrice = 0;

  static double get getTotalPrice => _totalPrice;

  static void resetPurchase() {
    // clear state and amount
    PurchaseState.purchaseState.clear();
    _totalPrice = 0;
  }

  set setTotalPrice(double price) => _totalPrice = price;

  static void addedToCart(ProductEntity product) {
    PurchaseEntity newPurchase = PurchaseEntity(
      productName: product.title,
      quantity: 1,
      price: product.price,
      productId: product.id,
    );

    _totalPrice += product.price;

    PurchaseState.purchaseState.add(newPurchase);
  }

  static void removeProductFromCart(PurchaseEntity purchaseProduct) {
    try {
      List<PurchaseEntity> newList = PurchaseState.purchaseState
          .where(
              (singleItem) => singleItem.productId != purchaseProduct.productId)
          .toList();

      _totalPrice -= purchaseProduct.price;

      PurchaseState.purchaseState = newList;
    } catch (err) {
      log('Error: $err');
    }
  }
}
