import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wegrow_task_flutter/core/utils/color_constant.dart';
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
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeLoadedEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedState) {
                  
                return Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>ProuductDetailsScreen(productModel: state.products[index],index: index,))) ,
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                             Expanded(flex: 5, child: Hero(tag:state.products[index].image,child: Image.network(state.products[index].image,fit: BoxFit.contain,width: double.maxFinite,))) , 
                              Expanded(child: Text(state.products[index].title,style:const TextStyle(overflow: TextOverflow.ellipsis,fontSize: 16,),)),
                                Expanded(child: Center(child: Row(
                                  children: [
                                    Text(" ৳ ",style: TextStyle(color: Color.fromARGB(255, 255, 60, 0),fontSize: 20),),
                                    Text(state.products[index].price.toString(),style:  TextStyle(color: Color.fromARGB(255, 255, 60, 0),fontSize: 20)),
                          
                                  ],
                                ))),
                              ],
                            ),
                          ),
                        );
                      }),
                );
           
                }else{
                  return CircularProgressIndicator();
                }
           
              },
            ),
          ],
        ));
  }
}
