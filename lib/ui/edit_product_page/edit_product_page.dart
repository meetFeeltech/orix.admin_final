
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orix_aqua_adim/bloc/editAllProduct/editProduct_bloc.dart';
import 'package:orix_aqua_adim/model/EditProductmodel/editProductModel.dart';
import 'package:orix_aqua_adim/ui/view_all_products/view_all_products.dart';
import '../../api/api.dart';
import '../../bloc/viewAllProducts/all_product_bloc.dart';
import '../../commonWidget/theme_helper.dart';
import '../../network/repositary.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class EditProductPage extends StatefulWidget {


  final String id;
  EditProductPage({Key? key,required this.id}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {

  // final ViewAllProducts vp = ViewAllProducts();

  final _formKey = GlobalKey<FormState>();
  EditProduct_model? edpromdata;
  String? value;
  int? value1;


  EditProductPageBloc eapBloc = EditProductPageBloc(Repository.getInstance());


  late EditProduct_model allproductmodelData;

  String?
  prodName,
      prodSku,
      brandId,
      categoryId;

  int?  branchPrice,
      distributorPrice,
      dealerPrice,
      wholesalerPrice,
      technicianPrice,
      freight,prodQty,tax;


  File? thumbnail;

  final _picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    loadui5();
  }

  loadui5() {
    eapBloc.add(AllFetchDataForProductPageEvent2("${widget.id}"));
  }


  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if(pickedFile != null) {
      thumbnail = File(pickedFile.path);
      setState(() {
      });
      print(thumbnail);
    } else {
      print("No Image Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    final main_width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: BlocProvider<EditProductPageBloc>(
        create: (context) => eapBloc..add(EditProductPageInitialEvent()),
        child: BlocConsumer<EditProductPageBloc, EditProductPageState>(
          builder: (context, state) {
            if (state is EditProductPageLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else if (state is AllFetchDataForProductPageState2) {
              allproductmodelData = state.allProductModelresponse;
              prodSku = allproductmodelData.prodSku;
              tax = allproductmodelData.tax;
              freight = allproductmodelData.freight;
              categoryId = allproductmodelData.categoryId;
              brandId = allproductmodelData.brandId;
              prodQty = allproductmodelData.prodQty;
              print("this state : ${state.allProductModelresponse.prodName}");
              print("all details : ${allproductmodelData}");
              return mainAllEditProductsView(state.allProductModelresponse,context);
            }
            else {
              return ThemeHelper.buildCommonInitialWidgetScreen();
            }
          },
          listener: (context, state) {
            if (state is ApiFailureState2) {
              print(state.exception.toString());
            }else
            if(state is AllFetchDataForProductPageState){
              AllFetchDataForProductPageEvent;
            }else
              if(state is EditPutProductDataState){
                print("${state.productPutResponse.message}");

                TextSpan contentMes = TextSpan(
                    text: "Product has been edited by Admin",style: TextStyle(color: Colors.grey, fontSize: 15));
                ThemeHelper.customDialogForMessage(
                  isBarrierDismissible: false,
                    context,
                    "Edit Done",
                    main_width,
                    contentMessage: contentMes,
                        () {
                      // Navigator.of(context).pop('refresh');
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewAllProducts()));
                      // Navigator.of(context).pop('refresh');
                    },
                    ForSuccess: true);

              }
          },
        ),
      ),
    );
  }


  Widget mainAllEditProductsView(EditProduct_model user, BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    final main_width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,left: 10.0, right: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          child: Image.asset(
                            "assets/images/m.png",
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {

                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              print("pn:${prodName} bp : ${branchPrice} dbp: ${distributorPrice} dp: ${dealerPrice} wp: ${wholesalerPrice} tp : ${technicianPrice} ci :${categoryId} bi : ${brandId} psu: ${prodSku} pq:${prodQty} fri:${freight} tax:${tax} image:${thumbnail}");
                              eapBloc.add(PutProductDataEvent(widget.id,prodName,prodSku,tax,freight,prodQty,branchPrice,distributorPrice,dealerPrice,wholesalerPrice,technicianPrice,categoryId,brandId,thumbnail:thumbnail));
                            }

                            // showDialog(
                            //   context: context,
                            //   builder: (context) =>
                            //       AlertDialog(
                            //         backgroundColor: Colors.blue[50],
                            //         content: const Text("Product has been edited by Admin"),
                            //         actions: <Widget>[
                            //           TextButton(
                            //             onPressed: () {
                            //               Navigator.of(context).pop('refresh');
                            //               // Navigator.of(context).pop();
                            //             },
                            //             child: Container(
                            //               decoration: BoxDecoration(    color: Colors.blue,
                            //                 borderRadius: BorderRadius.circular(3)
                            //               ),
                            //
                            //               padding: const EdgeInsets.all(5),
                            //               child: const Text(" Done ",
                            //               style: TextStyle(
                            //                 fontSize: 18,
                            //                 color: Colors.black,
                            //                 fontWeight: FontWeight.w400
                            //               ),),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            // );

                          },
                          child: Text("Edit Done")),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Product Image : ",
                        style: TextStyle(fontWeight: FontWeight.w600),),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7)
                            ),
                            child: Material(
                                color: Colors.transparent,
                                child: user.thumbnail != null ?
                                thumbnail == null ?
                                Ink.image(
                                  image: NetworkImage("$BASEIMAGEURL${allproductmodelData.thumbnail}"),
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                  child: InkWell(
                                    onTap: () {
                                      getImage();
                                    },
                                  ),
                                ) :
                                GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Image.file(
                                    File("${thumbnail!.path}").absolute,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : thumbnail == null ?  Ink.image(
                                  image: AssetImage("assets/images/inf.jpg"),
                                  onImageError: (exception, stackTrace) => AssetImage("assets/images/inf.jpg"),
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                  child: InkWell(
                                    onTap: () {
                                      getImage();
                                    },
                                  ),
                                ) :
                                GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Image.file(
                                    File("${thumbnail!.path}").absolute,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                            ),
                          ),


                          //  Edit Icon on the image.
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: ClipOval(
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    color: Colors.white,
                                    child: ClipOval(
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        color: Colors.black45,
                                        child: Icon(
                                          Icons.edit,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Text(
                        "Product : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextFormField(
                      initialValue: "${allproductmodelData.prodName}",
                      onSaved: (onSavedVal) {
                        prodName = onSavedVal;
                      },
                      decoration: InputDecoration()),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Branch Price : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: "${allproductmodelData.branchPrice}",
                    onSaved: (onSavedVal) {
                      branchPrice = int.parse(onSavedVal!);
                    },
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Distributor Price : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: "${allproductmodelData.distributorPrice}",
                    onSaved: (onSavedVal) {
                      distributorPrice = int.parse(onSavedVal!);
                    },
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Dealer Price : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: "${allproductmodelData.dealerPrice}",
                    onSaved: (onSavedVal) {
                      dealerPrice = int.parse(onSavedVal!);
                    },
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        "Wholesaler Price : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: "${allproductmodelData.wholesalerPrice}",
                    onSaved: (onSavedVal) {
                      wholesalerPrice = int.parse(onSavedVal!);
                    },
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Text(
                        "Technician Price : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: "${allproductmodelData.technicianPrice}",
                    onSaved: (onSavedVal) {
                      technicianPrice = int.parse(onSavedVal!);
                    },
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 15,
                  ),


                  Row(
                    children: [
                      Text(
                        "Tax : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: "${allproductmodelData.tax}",
                    onSaved: (onSavedVal) {
                      tax = int.parse(onSavedVal!);
                    },
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 15,
                  ),


                  Row(
                    children: [
                      Text(
                        "freight : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: "${allproductmodelData.freight}",
                    onSaved: (onSavedVal) {
                      freight = int.parse(onSavedVal!);
                    },
                    decoration: InputDecoration(),
                  ),
                  SizedBox(
                    height: 15,
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


