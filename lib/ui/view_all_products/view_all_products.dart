import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orix_aqua_adim/api/api.dart';
import 'package:orix_aqua_adim/ui/dashboard/dashboard.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../bloc/viewAllProducts/all_product_bloc.dart';
import '../../commonWidget/theme_helper.dart';
import '../../model/viewallproducts/viewAppProduct_model.dart';
import '../../network/repositary.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../GridDataCommonFunc/GridDataCommonFunc.dart';
import '../edit_product_page/edit_product_page.dart';

class ViewAllProducts extends StatefulWidget {
  @override
  State<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  ProductPageBloc vapBloc = ProductPageBloc(Repository.getInstance());

  List<ViewAllPro_model>? allproductmodelData;

  late AllProductDataSource _allProductDataSource;
  final _formKey = GlobalKey<FormState>();

  String? prodName,
      prodSku,
      tax,
      freight,
      prodQty,
      branchPrice,
      distributorPrice,
      dealerPrice,
      wholesalerPrice,
      technicianPrice,
      categoryId,
      brandId;

  @override
  void initState() {
    super.initState();
    loadui3();
  }

  loadui3() {
    vapBloc.add(AllFetchDataForProductPageEvent(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ProductPageBloc>(
        create: (context) => vapBloc..add(ProductPageInitialEvent()),
        child: BlocConsumer<ProductPageBloc, ProductPageState>(
          builder: (context, state) {
            if (state is ProductPageLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else if (state is AllFetchDataForProductPageState) {
              allproductmodelData = state.allProductModelresponse;
              _allProductDataSource =
                  AllProductDataSource(allproductmodelData!, context, vapBloc);
              return mainAllProductsView();

            }else if (state is AllFetchDataForProductPageState3) {
              allproductmodelData = state.allProductModelresponse;
              _allProductDataSource =
                  AllProductDataSource(allproductmodelData!, context, vapBloc);
              print("all rpoduct ${allproductmodelData}");
              return mainAllProductsView();

            } else {
              return ThemeHelper.buildCommonInitialWidgetScreen();
            }
          },
          listener: (context, state) {
            if (state is ApiFailureState) {
              print(state.exception.toString());
            }
          },
        ),
      ),
    );
  }

  Widget mainAllProductsView() {
    double main_Width = MediaQuery.of(context).size.width;
    double main_Height = MediaQuery.of(context).size.height;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              loadui3();
            },
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8),
                    child: Row(
                      children: [
                        InkWell(
                          child: Container(
                            child: Image.asset(
                              "assets/images/m.png",
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Dashboard()), (route) => false);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "All Products Details : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: main_Height * 0.9,
                    width: main_Width * 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                          headerColor: Colors.blue[300],
                          sortIconColor: Colors.white,
                        ),
                        child: SfDataGrid(
                          onCellTap: (details) {
                            if (details.rowColumnIndex.rowIndex != 0) {
                              int selectedRowIndex =
                                  details.rowColumnIndex.rowIndex - 1;
                              var row = _allProductDataSource.effectiveRows
                                  .elementAt(selectedRowIndex);

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  content: Stack(
                                    children: <Widget>[
                                      Container(
                                          color: Color.fromARGB(
                                              150, 227, 242, 253),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Container(
                                            height: main_Height * 0.5,
                                            width: main_Width * 1,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Product Details ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blue[300],
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Product name : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        "${row.getCells()[2].value.toString()}"),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Brand name : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[3].value.toString()}")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Category name : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "${row.getCells()[4].value.toString()}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Branch price : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[5].value.toString()}")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Distributor Price: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[6].value.toString()}")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Dealer Price : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[7].value.toString()}")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Wholesaler name : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[8].value.toString()}")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Technician Price : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[9].value.toString()}")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Tax : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[13].value.toString()}")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Freight : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[14].value.toString()}")
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      Positioned(
                                        top: 0.0,
                                        right: 0.0,
                                        child: FloatingActionButton(
                                          child: Image.asset(
                                              "assets/images/q.png"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80)),
                                          backgroundColor: Colors.white,
                                          mini: true,
                                          elevation: 5.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );

                              // Stack(
                              //   children: <Widget>[
                              //     Container(
                              //       color: Colors.blue,
                              //       width: MediaQuery.of(context).size.width,
                              //       child: Column(
                              //         children: <Widget>[
                              //           Text("abc")
                              //         ],
                              //       ),
                              //     ),
                              //     Positioned(
                              //       top: 0.0,
                              //       right: 0.0,
                              //       child: FloatingActionButton(
                              //         child: Text("a"),
                              //         onPressed: (){
                              //           Navigator.pop(context);
                              //         },
                              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                              //         backgroundColor: Colors.white,
                              //         mini: true,
                              //         elevation: 5.0,
                              //       ),
                              //     ),
                              //   ],
                              // );
                            }
                          },

                          shrinkWrapRows: true,
                          // allowFiltering: true,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          columnWidthMode: ColumnWidthMode.fitByCellValue,
                          rowHeight: 50,
                          headerRowHeight: 40,
                          footerHeight: 30,
                          isScrollbarAlwaysShown: true,
                          // verticalScrollPhysics: AlwaysScrollableScrollPhysics(),
                          // horizontalScrollPhysics: AlwaysScrollableScrollPhysics(),
                          source: _allProductDataSource,

                          columns: [
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'Edit',
                                toolTipMessage: "Edit",
                                columnTitle: "Edit",
                                columnWidthModeData: ColumnWidthMode.fill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'ProductImg',
                                toolTipMessage: "ProductImg",
                                columnTitle: "ProductImg",
                                columnWidthModeData: ColumnWidthMode.fill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'Product',
                              toolTipMessage: "Product",
                              columnTitle: "Product",
                            ),
                            GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'Brand',
                              toolTipMessage: 'Brand',
                              columnTitle: 'Brand',
                            ),
                            GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'category',
                              toolTipMessage: 'category',
                              columnTitle: 'category',
                            ),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'branchprice',
                                toolTipMessage: 'branchprice',
                                columnTitle: 'branchprice',
                                columnWidthModeData:
                                    ColumnWidthMode.lastColumnFill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'distributorPrice',
                                toolTipMessage: 'distributorPrice',
                                columnTitle: 'distributorPrice',
                                columnWidthModeData:
                                    ColumnWidthMode.lastColumnFill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'dealerPrice',
                                toolTipMessage: 'dealerPrice',
                                columnTitle: 'dealerPrice',
                                columnWidthModeData:
                                    ColumnWidthMode.lastColumnFill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'wholesalerPrice',
                                toolTipMessage: 'wholesalerPrice',
                                columnTitle: 'wholesalerPrice',
                                columnWidthModeData:
                                    ColumnWidthMode.fitByColumnName),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'technicianPrice',
                                toolTipMessage: 'technicianPrice',
                                columnTitle: 'technicianPrice',
                                columnWidthModeData:
                                    ColumnWidthMode.fitByColumnName),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                visible: false,
                                columnName: 'id',
                                toolTipMessage: 'id',
                                columnTitle: 'id',
                                columnWidthModeData:
                                    ColumnWidthMode.fitByColumnName),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                visible: false,
                                columnName: 'prodSku',
                                toolTipMessage: 'prodSku',
                                columnTitle: 'prodSku',
                                columnWidthModeData:
                                    ColumnWidthMode.fitByCellValue),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                visible: false,
                                columnName: 'prodQty',
                                toolTipMessage: 'prodQty',
                                columnTitle: 'prodQty',
                                columnWidthModeData:
                                    ColumnWidthMode.fitByColumnName),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                // visible: false,
                                columnName: 'tax',
                                toolTipMessage: 'tax',
                                columnTitle: 'tax',
                                columnWidthModeData:
                                    ColumnWidthMode.fitByColumnName),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                // visible: false,
                                columnName: 'freight',
                                toolTipMessage: 'freight',
                                columnTitle: 'freight',
                                columnWidthModeData:
                                    ColumnWidthMode.fitByColumnName),
                          ],
                        ),
                      ),
                    ),
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

class AllProductDataSource extends DataGridSource {
  final BuildContext _context;

  final ProductPageBloc pageac;

  late List<DataGridRow> dataGridRows;
  AllProductDataSource(List<ViewAllPro_model> machineProductionTargetData,
      this._context, this.pageac) {
    // print("machineProductionTargetData: $machineProductionTargetData");

    dataGridRows = machineProductionTargetData.map<DataGridRow>((dataGridRows) {
      // print("loadui6data${dataGridRows.prodName}");

      return DataGridRow(cells: [
        DataGridCell(columnName: "Edit", value: null),
        DataGridCell(columnName: "ProductImg", value: dataGridRows.thumbnail),
        DataGridCell(columnName: "Product", value: dataGridRows.prodName),
        DataGridCell(columnName: "Brand", value: dataGridRows.brand!.brandName),
        DataGridCell(
            columnName: "category", value: dataGridRows.category!.categoryName),
        DataGridCell(
            columnName: "branchprice", value: dataGridRows.branchPrice),
        DataGridCell(
            columnName: "distributorPrice",
            value: dataGridRows.distributorPrice),
        DataGridCell(
            columnName: "dealerPrice", value: dataGridRows.dealerPrice),
        DataGridCell(
            columnName: "wholesalerPrice", value: dataGridRows.wholesalerPrice),
        DataGridCell(
            columnName: "technicianPrice", value: dataGridRows.technicianPrice),
        DataGridCell(columnName: "id", value: dataGridRows.id),
        DataGridCell(columnName: "prodSku", value: dataGridRows.prodSku),
        DataGridCell(columnName: "prodQty", value: dataGridRows.prodQty),
        DataGridCell(columnName: "tax", value: dataGridRows.tax),
        DataGridCell(columnName: "freight", value: dataGridRows.freight),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        summaryValue == ""
            ? "T:  0"
            : "T:  ${double.parse(summaryValue).toStringAsFixed(2)}",
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getRowBackgroundColor() {
      final int index = effectiveRows.indexOf(row);
      if (index % 2 != 0) {
        return const Color.fromARGB(150, 227, 242, 253);
      }
      return const Color.fromARGB(255, 255, 255, 255);
    }

    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          double main_Width = MediaQuery.of(_context).size.width;
          double main_Height = MediaQuery.of(_context).size.height;

          String data = dataGridCell.value.toString();

          final ab = row.getCells()[10].value;
          return Container(
            alignment: Alignment.center,
            child: dataGridCell.columnName == "Edit"
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          print("$ab");
                          String refresh = await Navigator.of(_context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditProductPage(id: ab)));

                          if (refresh == "refresh") {
                            print("load ui 6 is called");
                            pageac.add(AllFetchDataForProductPageEvent3(""));
                          } else {
                            print("laod ui 6 not called");
                          }
                        },
                        child: Text("Edit")),
                  )
                : dataGridCell.columnName == "ProductImg"
                    ? GestureDetector(
                        onTap: () {
                          showDialog(
                            context: _context,
                            builder: (_) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: main_Height * 0.6,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // color: Colors.white,
                                        width:
                                            MediaQuery.of(_context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                "assets/images/inf.jpg",
                                            image:
                                                "$BASEIMAGEURL${dataGridCell.value}",
                                            imageErrorBuilder:
                                                ((context, error, stackTrace) {
                                              return Image.asset(
                                                  "assets/images/inf.jpg");
                                            }),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0.0,
                                        right: 0.0,
                                        child: FloatingActionButton(
                                          child: Image.asset(
                                              "assets/images/q.png"),
                                          onPressed: () {
                                            Navigator.pop(_context);
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80)),
                                          backgroundColor: Colors.white,
                                          mini: true,
                                          elevation: 5.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },





                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/inf.jpg",
                            image: "$BASEIMAGEURL${dataGridCell.value}",
                            imageErrorBuilder: ((context, error, stackTrace) {
                              return Image.asset("assets/images/inf.jpg");
                            }),
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Text(
                          dataGridCell.value
                              .toString()
                              .replaceAll("(", "")
                              .replaceAll(")", ""),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
          );
        }).toList());
  }
}
