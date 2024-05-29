// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:e_commerce/config/router/app_route.dart';
import 'package:e_commerce/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/purchase_entity.dart';
import '../service/shopping.dart';
import '../state/purchase_state.dart';
import 'widgets/snackbar_messenger.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
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

  // Khalti payment integration // Step 5
  void _openKhaltiPaymentView() {
    final config = PaymentConfig(
      // amount must be in Paisa not Rs so multiply by 100 and amount must < Rs 200
      amount: (Shopping.getTotalPrice).toInt() * 100,
      productIdentity:
          'ML123', // add id or something that uniquely identifies the product
      productName: 'productName', // product name
      additionalData: {
        'vendor': 'vendor name', // used for reporting purpose but not mandatory
      },

      mobileReadOnly:
          false, // makes the mobile field not editable -- not mandatory to use
    );

    KhaltiScope.of(context).pay(
      config: config,

      // add a list of preferences which you want to give services to the users for payment such as khalti, mobile banking etc
      preferences: const [
        PaymentPreference.khalti,
        PaymentPreference.connectIPS,
        PaymentPreference.eBanking,
        PaymentPreference.mobileBanking,
        PaymentPreference.sct,
      ],
      onSuccess: (onSuccess) {
        showSnackBarMsg(
          context: context,
          message: 'Payment success.',
          bgColor: Colors.green,
        );

        Shopping.resetPurchase();
        ref.watch(purchaseSelectorProvider.notifier).state = 0;
        Navigator.pushNamed(context, AppRoute.homeRoute);
      },
      onFailure: (onFailure) {
        showSnackBarMsg(
          context: context,
          message: 'Failed to pay.',
          bgColor: Colors.red,
        );
      },
      onCancel: () {
        showSnackBarMsg(
          context: context,
          message: 'Canceled to payment proceed.',
          bgColor: Colors.pink,
        );
        Navigator.pushNamed(context, AppRoute.homeRoute);
      },
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
          // Khalti payment integration // Step 4 : call the function
          onPressed: _openKhaltiPaymentView,
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
