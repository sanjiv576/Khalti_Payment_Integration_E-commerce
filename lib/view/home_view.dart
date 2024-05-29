import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_entity.dart';
import '../service/network.dart';
import '../service/shopping.dart';
import '../service/user_shared_prefs.dart';
import 'widgets/appbaraction_widget.dart';
import 'widgets/image_widget.dart';
import 'widgets/snackbar_messenger.dart';
import 'widgets/tutorial.dart';

final purchaseSelectorProvider = StateProvider<int>((ref) => 0);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _verticalGap = const SizedBox(height: 12);

  final GlobalKey _cartButtonKey = GlobalKey();

  // late List<ProductEntity> products;
  late Future<List<dynamic>> futureProducts;
  Network network = Network();
  String message =
      'Click this button when you select the items. It moves you to the Cart page.';

  @override
  void initState() {
    super.initState();

    _isShowTutorial();

    futureProducts = network.fetchProducts();
  }

  void _isShowTutorial() async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();

    final result = await userSharedPrefs.isLaunch();

    if (result == null) {
      // show tutorial
      showTutorials(
          keyName: _cartButtonKey, message: message, context: context);
      // save in the shared prefs now
      userSharedPrefs.setFirstLaunch(true);
    }
  }

  void _addToCart(ProductEntity product) {
    ref.watch(purchaseSelectorProvider.notifier).state += 1;
    Shopping.addedToCart(product);

    showSnackBarMsg(
      context: context,
      bgColor: Colors.green,
      message: 'Added to cart successfully.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        centerTitle: true,
        actions: [AppBarActionWidget(cartButtonKey: _cartButtonKey, ref: ref)],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Center(
        child: FutureBuilder(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var product = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          // height: 500,
                          width: 300,
                          // color: Colors.grey.shade700,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageWidget(product: product),
                                _verticalGap,
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      _verticalGap,
                                      Text('Price: Rs ${product.price}'),
                                      _verticalGap,
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton.outlined(
                                            highlightColor: Colors.pink,
                                            onPressed: () {
                                              _addToCart(product);
                                            },
                                            icon: const Icon(Icons.add)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Text('Erorr');
              }
              return const CircularProgressIndicator();
            }),
      )),
    );
  }
}
