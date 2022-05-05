import 'package:ecommerceapplication/screens/home.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if(state is ClearScreenState)
            {
              titleController.text='';
              descriptionController.text='';
              categoryNameController.text='';
              priceController.text='';
              quantityController.text='';
              brandController.text='';
            }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      HomeCubit.get(context).imageFile != null) {
                    HomeCubit.get(context).uploadPhoto().then((value) {
                      print(
                          "Image Url From Fab ${HomeCubit.get(context).imageUrl}");
                      HomeCubit.get(context).uploadProduct(
                        title: titleController.text,
                        imageUrl: HomeCubit.get(context).imageUrl,
                        description: descriptionController.text,
                        quantity: int.parse(quantityController.text),
                        categoryName: categoryNameController.text,
                        brand: brandController.text,
                        price: double.parse(priceController.text),
                      ).then((value) {
                        HomeCubit.get(context).clearScreen();

                      });
                    }).catchError((error) {});
                  }
                },
                child: Icon(Icons.add)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          onTap: () {
                            HomeCubit.get(context).getPhotoGallery();
                          },
                          child: HomeCubit.get(context).imageFile != null
                              ? Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  height: 300,
                                  width: 300,
                                  child: Image.file(
                                    HomeCubit.get(context).imageFile!,
                                    fit: BoxFit.cover,
                                  ))
                              : Container(
                                  height: 300,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      color:
                                          Colors.transparent.withOpacity(.4)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Title";
                                }
                              },
                              controller: titleController,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Theme.of(context).textSelectionColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'Title',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Theme.of(context)
                                            .textSelectionColor),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Description";
                                }
                              },
                              controller: descriptionController,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Theme.of(context).textSelectionColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Theme.of(context)
                                            .textSelectionColor),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Enter Category";
                                }
                              },
                              controller: categoryNameController,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Theme.of(context).textSelectionColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'Category',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Theme.of(context)
                                            .textSelectionColor),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Price";
                                }
                              },
                              controller: priceController,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Theme.of(context).textSelectionColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'Price',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Theme.of(context)
                                            .textSelectionColor),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Brand";
                                }
                              },
                              controller: brandController,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Theme.of(context).textSelectionColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'brand',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Theme.of(context)
                                            .textSelectionColor),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Quantity";
                                }
                              },
                              controller: quantityController,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Theme.of(context).textSelectionColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'Quantity',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Theme.of(context)
                                            .textSelectionColor),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
