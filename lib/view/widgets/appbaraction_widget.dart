import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/router/app_route.dart';
import '../../state/purchase_state.dart';
import '../home_view.dart';
import 'snackbar_messenger.dart';

class AppBarActionWidget extends StatelessWidget {
  const AppBarActionWidget({
    super.key,
    required GlobalKey<State<StatefulWidget>> cartButtonKey,
    required this.ref,
  }) : _cartButtonKey = cartButtonKey;

  final GlobalKey<State<StatefulWidget>> _cartButtonKey;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            child: IconButton(
              key: _cartButtonKey,
              onPressed: () {
                if (PurchaseState.purchaseState.isEmpty) {
                  showSnackBarMsg(
                    context: context,
                    bgColor: Colors.red,
                    message: 'Please, select items first.',
                  );
                } else {
                  Navigator.pushNamed(context, AppRoute.cartRoute);
                }
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 40,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              minRadius: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ref.watch(purchaseSelectorProvider).toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
