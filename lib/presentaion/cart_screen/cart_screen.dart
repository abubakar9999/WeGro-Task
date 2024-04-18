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
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartItemsLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartItemsLoadedState) {
              print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
              print(state.product.length);
              return Expanded(
                child: ListView.builder(
                    itemCount: state.product.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            horizontalTitleGap: 7,
                            dense: false,
                            minVerticalPadding: 0,
                            titleAlignment: ListTileTitleAlignment.titleHeight,
                            leading: Image.network(
                              state.product[index].image,
                              height: 100,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                            title: Text(state.product[index].title),
                            subtitle: Text("৳-${state.product[index].price}"),
                            trailing: IconButton(
                              onPressed: () {
                                BlocProvider.of<CartBloc>(context).add(
                                    CartItemsDeleteEvent(
                                        id: int.parse(state.product[index].id
                                            .toString())));
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return CircularProgressIndicator();
            }
          })
        ],
      ),
    );
  }
}
