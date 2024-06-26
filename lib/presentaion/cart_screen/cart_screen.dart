import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wegrow_task_flutter/presentaion/cart_screen/cart_screen_bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartItemsLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartItemsLoadedState) {
              // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
              // print(state.product.length);
              return state.product.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: state.product.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 7,
                                  dense: false,
                                  minVerticalPadding: 0,
                                  titleAlignment:
                                      ListTileTitleAlignment.titleHeight,
                                  leading: Image.network(
                                    state.product[index].image,
                                    height: 100,
                                    width: 70,
                                    fit: BoxFit.contain,
                                  ),
                                  title: Text(state.product[index].title),
                                  subtitle:
                                      Text("৳-${state.product[index].price}"),
                                  trailing: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context).add(
                                          CartItemsDeleteEvent(
                                              id: state.product[index].id));
                                      BlocProvider.of<CartBloc>(context)
                                          .add(CartItemsLoadedEvent());
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : const Center(
                      child: Text("No Data"),
                    );
            } else {
              return const CircularProgressIndicator();
            }
          })
        ],
      ),
    );
  }
}
