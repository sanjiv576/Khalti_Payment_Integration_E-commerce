import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/purchase_entity.dart';
import '../service/shopping.dart';
import '../state/purchase_state.dart';
import 'widgets/snackbar_messenger.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<PurchaseEntity> purchaseList = PurchaseState.purchaseState;

  void _removeProduct(PurchaseEntity purchaseProduct) {
    Shopping.removeProductFromCart(purchaseProduct);

    setState(() {
      purchaseList = PurchaseState.purchaseState;
    });

    showSnackBarMsg(
      context: context,
      bgColor: Colors.green,
      message: 'Delete from cart successfully.',
    );
  }

  void _confirmPay() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Pay and Purchase",
      desc: "Do you want to purchase?",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: purchaseList.length,
                itemBuilder: (context, index) {
                  PurchaseEntity purchaseProduct = purchaseList[index];
                  return SingleChildScrollView(
                    child: ListTile(
                      selectedColor: Colors.blue.shade400,
                      title: Text(purchaseProduct.productName),
                      subtitle: Text("Rs ${purchaseProduct.price.toString()}"),
                      trailing: IconButton.outlined(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          _removeProduct(purchaseProduct);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total price: Rs ${Shopping.getTotalPrice}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue)),
              onPressed: purchaseList.isEmpty
                  ? null
                  : () {
                      _confirmPay();
                    },
              child: const Text(
                'Pay and Purchase',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
