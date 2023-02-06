import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orix_aqua_adim/model/viewallcategories/ViewAllCategories_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../bloc/viewAllCategories/all_categories_bloc.dart';
import '../../commonWidget/theme_helper.dart';
import '../../network/repositary.dart';
import '../GridDataCommonFunc/GridDataCommonFunc.dart';

class ViewAllCategory extends StatefulWidget {
  const ViewAllCategory({Key? key}) : super(key: key);

  @override
  State<ViewAllCategory> createState() => _ViewAllCategoryState();
}

class _ViewAllCategoryState extends State<ViewAllCategory> {

  CateoryPageBloc vacBloc = CateoryPageBloc(Repository.getInstance());

  List<ViewAllCategories_model>? allcategorymodelData;

  late AllCategoryDataSource _allCategoryDataSource;

  @override
  void initState() {
    super.initState();
    loadui1();
  }

  loadui1(){
    vacBloc.add(AllFetchDataForCategoryPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CateoryPageBloc>(
        create: (context) => vacBloc..add(CategoryPageInitialEvent()),
        child: BlocConsumer<CateoryPageBloc, CategoryPageState>(
          builder: (context, state) {
            if (state is CategoryPageLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else if (state is AllFetchDataForCategryPageState) {
              allcategorymodelData = state.allCatoModel;
              _allCategoryDataSource =
                  AllCategoryDataSource(allcategorymodelData!,context);
              return mainAllCategoryView();
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

  Widget mainAllCategoryView(){
    double main_Width = MediaQuery.of(context).size.width;
    double main_Height = MediaQuery.of(context).size.height;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async{
            loadui1();
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
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "All Categories Details : ",
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                            var row = _allCategoryDataSource.effectiveRows
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
                                          height: main_Height * 0.28,
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
                                                        "Category Name : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                      "${row.getCells()[1].value.toString()}"),
                                                  SizedBox(
                                                    height: 12,
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Description : ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Text("${row.getCells()[2].value.toString()}",
                                                  textAlign: TextAlign.center,),
                                                  SizedBox(
                                                    height: 12,
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
                        verticalScrollPhysics: AlwaysScrollableScrollPhysics(),
                        source: _allCategoryDataSource,


                        columns: [

                          GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'prodImg',
                              toolTipMessage: "prodImg",
                              columnTitle: "prodImg",
                              columnWidthModeData: ColumnWidthMode.fill
                          ),
                          GridDataCommonFunc.tableColumnsDataLayout(
                            columnName: 'categoryName',
                            toolTipMessage: "categoryName",
                            columnTitle: "categoryName",
                          ),
                          GridDataCommonFunc.tableColumnsDataLayout(
                            columnName: 'categoryDesc',
                            toolTipMessage: 'categoryDesc',
                            columnTitle: 'categoryDesc',
                          ),
                          GridDataCommonFunc.tableColumnsDataLayout(
                            columnName: 'status',
                            toolTipMessage: 'status',
                            columnTitle: 'status',
                          ),

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
    );
  }
}


class AllCategoryDataSource extends DataGridSource{
   final BuildContext _context1;

  late List<DataGridRow> dataGridRows;


  AllCategoryDataSource(List<ViewAllCategories_model> machineProductionTargetData, this._context1) {
    dataGridRows = machineProductionTargetData.map<DataGridRow>((dataGridRows) {
      return DataGridRow(cells: [

        DataGridCell(columnName: "prodImg", value: dataGridRows.prodImg),
        DataGridCell(columnName: "categoryName", value: dataGridRows.categoryName),
        DataGridCell(columnName: "categoryDesc", value: dataGridRows.categoryDesc),
        DataGridCell(
            columnName: "status", value: dataGridRows.status),

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
        return const Color.fromARGB(150,227, 242, 253);
      }
      return const Color.fromARGB(255, 255, 255, 255);
    }

    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          double main_Width = MediaQuery.of(_context1).size.width;
          double main_Height = MediaQuery.of(_context1).size.height;

          return Container(
            alignment: Alignment.center,
            child: dataGridCell.columnName=="prodImg" ?
            GestureDetector(


              onTap: () {
                showDialog(
                  context: _context1,
                  builder: (_)=>

                      Column(
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
                                  MediaQuery.of(_context1).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:
                                    FadeInImage.assetNetwork(
                                      placeholder: "assets/images/inf.jpg",
                                      image: "https://orixapi.feeltechsolutions.com/${dataGridCell.value}",
                                      imageErrorBuilder:((context, error, stackTrace) {
                                        return Image.asset("assets/images/inf.jpg");
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
                                      Navigator.pop(_context1);
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
                      )




                      // FadeInImage.assetNetwork(
                      //   placeholder: "assets/images/inf.jpg",
                      //   image: "https://orixapi.feeltechsolutions.com/${dataGridCell.value}",
                      //   imageErrorBuilder:((context, error, stackTrace) {
                      //     return Image.asset("assets/images/inf.jpg");
                      //   }),
                      // ),

                );
              },



              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/inf.jpg",
                  image: "https://orixapi.feeltechsolutions.com/${dataGridCell.value}",
                  imageErrorBuilder:((context, error, stackTrace) {
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
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          );
        }).toList());
  }



}
