import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wegrow_task_flutter/core/utils/boxes.dart';
import 'package:wegrow_task_flutter/presentaion/cart_screen/cart_screen.dart';
import 'package:wegrow_task_flutter/presentaion/cart_screen/cart_screen_bloc/cart_bloc.dart';
import 'package:wegrow_task_flutter/presentaion/details_screen/product_details.dart';
import 'package:wegrow_task_flutter/presentaion/home_screen/home_screen_bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeLoadedEvent());
    HiveBox().addToCart.get('addedData') != null
        ? BlocProvider.of<CartBloc>(context).add(CartItemsLoadedEvent())
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          // leading: const SizedBox.shrink(),
          actions: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartItemsLoadedState) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                          radius: 10,
                          child: Text(
                            state.product.length.toString(),
                            // HiveBox().addToCart.get('addedData') != null ? HiveBox().addToCart.get('addedData').values.toList().length.toString() : 0.toString(),
                            style: const TextStyle(fontSize: 10),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartScreen()));
                          },
                          icon: const Icon(Icons.shopping_cart_outlined)),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
        body: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedState) {
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProuductDetailsScreen(
                                          productModel: state.products[index],
                                          index: index,
                                        ))),
                            child: Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: Hero(
                                            tag: state.products[index].image,
                                            child: Image.network(
                                              state.products[index].image,
                                              fit: BoxFit.contain,
                                              width: double.maxFinite,
                                            ))),
                                    Expanded(
                                        child: Text(
                                      state.products[index].title,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                      ),
                                    )),
                                    Expanded(
                                        child: Center(
                                            child: Row(
                                      children: [
                                        const Text(
                                          " ৳ ",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 60, 0),
                                              fontSize: 20),
                                        ),
                                        Text(
                                            state.products[index].price
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 60, 0),
                                                fontSize: 20)),
                                      ],
                                    ))),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ));
  }
}
