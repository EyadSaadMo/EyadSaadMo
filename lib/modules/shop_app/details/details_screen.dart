import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenges/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_challenges/layout/shop_app/cubit/states.dart';
import 'package:flutter_challenges/models/shop_app/products_details_model.dart';
import 'package:flutter_challenges/shared/component/components.dart';
import 'package:flutter_challenges/shared/style/colors.dart';
import 'package:flutter_challenges/shared/style/icon_broken.dart';

class DetailsScreen extends StatelessWidget {
 // late final  ProductDetailsData? model;
 // DetailsScreen(this.model);
  // final List? index;
  // DetailsScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
         listener: (context,state){},
         builder: (context,state){
           return ConditionalBuilder(
               condition: state is !ShopLoadingProductDetailsState,
               builder: (context){
                 return Scaffold(
                   appBar: AppBar(
                     title: Text('Product Details'),
                     actions: [
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Icon(IconBroken.Buy),
                       ),
                     ],
                   ),
                   body:
                       Column(
                         children: [
                           Expanded(child:  buildDetailsItem(context,ShopCubit.get(context).productDetailsModel!.data.data[0] ),),

                         ],
                       ),
                   // body:  ListView.separated(
                   //   itemBuilder: (context,index)=>buildDetailsItem(context, ShopCubit.get(context).productDetailsModel!.data.data[index]),
                   //   separatorBuilder: (context,index)=>myDivider(),
                   //   itemCount: ShopCubit.get(context).productDetailsModel!.data.data.length,
                   //
                   // ),
                   bottomNavigationBar: Padding( padding: EdgeInsets.all(20.0), child:defaultButton(text: 'Add to chart', function: (){
                     showToast(msg: 'Added Successfully', state: ToastStates.SUCCESS);
                   })),
                 );
               },
               fallback: (context)=>Center(child: CircularProgressIndicator()),
           );
         },
    );
  }
  Widget buildDetailsItem(context,ProductDetailsData? model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: ListView(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: NetworkImage("${model!.image}"),
            ),
          ),
        ),
        SizedBox(height: 20.0,),
        Text('${model.name}',style: Theme.of(context).textTheme.subtitle1,),
        SizedBox(height: 12.0,),
        Text('${model.price}',style: Theme.of(context).textTheme.subtitle1!.copyWith(color: defaultColor),),
        SizedBox(height: 15.0,),
        Text('Details ',style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.deepOrange),),
        SizedBox(height: 15.0,),
        Text('${model.description}',style: Theme.of(context).textTheme.caption,),
        SizedBox(height: 15.0,),
       // defaultButton(text: 'Add to Chart', function: (){}),
      ],
    ),
  );
}
