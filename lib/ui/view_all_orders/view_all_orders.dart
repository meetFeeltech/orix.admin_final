import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orix_aqua_adim/bloc/viewAllOrders/all_orders_bloc.dart';
import 'package:orix_aqua_adim/model/viewallorders/ViewAllOrders_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../commonWidget/theme_helper.dart';
import '../../model/orderstatus/order_status_model.dart';
import '../../network/repositary.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../GridDataCommonFunc/GridDataCommonFunc.dart';

class ViewAllOrders extends StatefulWidget {
  const ViewAllOrders({Key? key}) : super(key: key);

  @override
  State<ViewAllOrders> createState() => _ViewAllOrdersState();
}

class _ViewAllOrdersState extends State<ViewAllOrders> {
  OrdersPageBloc vaoBloc = OrdersPageBloc(Repository.getInstance());

  StatusChange_model? statusChange_model_data;

  String? message;
  List<ViewAllOrders_model>? allordersmodelData;
  late AllOrdersDataSource _allOrdersDataSource;

  @override
  void initState() {
    super.initState();
    loadui2();
  }

  loadui2() {
    vaoBloc.add(AllFetchDataForOrdersPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<OrdersPageBloc>(
        create: (context) => vaoBloc..add(OrdersPageInitialEvent()),
        child: BlocConsumer<OrdersPageBloc, OrdersPageState>(
          builder: (context, state) {
            if (state is OrdersPageLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else if (state is AllFetchDataForOrdersPageState) {
              allordersmodelData = state.allOrderModel;
              _allOrdersDataSource =
                  AllOrdersDataSource(allordersmodelData!, context, vaoBloc);
              return mainAllOrdersView();
            } else if (state is PutStatusState) {
              statusChange_model_data = state.message;
              print("$message");
              return mainAllOrdersView();
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

  Widget mainAllOrdersView() {
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
              loadui2();
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
                          "All Orders Details : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                              var row = _allOrdersDataSource.effectiveRows
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
                                            height: main_Height * 0.35,
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
                                                          "Orders Details ",
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
                                                          "Order Number: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[0].value.toString()}"),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),


                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Company Name : ",
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
                                                          "Customer name : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),

                                                      ],
                                                    ),
                                                    Text(
                                                      "${row.getCells()[2].value.toString()}",
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),

                                                    SizedBox(
                                                      height: 12,
                                                    ),


                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Order Status : ",
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
                                                          "Itom counts : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[4].value.toString()}")
                                                      ],
                                                    ),


                                                    SizedBox(
                                                      height: 12,
                                                    ),


                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Total Price : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        Text(
                                                            "${row.getCells()[5].value.toString()}")
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
                          source: _allOrdersDataSource,
                          allowSorting: true,

                          // tableSummaryRows: [
                          //   GridTableSummaryRow(
                          //       color: Color.fromARGB(255, 189, 215, 238),
                          //       showSummaryInRow: false,
                          //       columns: [
                          //         const GridSummaryColumn(
                          //             name: 'Sum',
                          //             columnName: 'orderNumber',
                          //             summaryType: GridSummaryType.sum),
                          //         const GridSummaryColumn(
                          //             name: 'Sum',
                          //             columnName: 'companyName',
                          //             summaryType: GridSummaryType.sum),
                          //         const GridSummaryColumn(
                          //             name: 'Sum',
                          //             columnName: 'name',
                          //             summaryType: GridSummaryType.sum),
                          //         const GridSummaryColumn(
                          //             name: 'Sum',
                          //             columnName: 'orderStatus',
                          //             summaryType: GridSummaryType.sum),
                          //         const GridSummaryColumn(
                          //             name: 'Sum',
                          //             columnName: 'itemCount',
                          //             summaryType: GridSummaryType.sum),
                          //         const GridSummaryColumn(
                          //             name: 'Sum',
                          //             columnName: 'total',
                          //             summaryType: GridSummaryType.sum),
                          //         const GridSummaryColumn(
                          //             name: 'Sum',
                          //             columnName: 'id',
                          //             summaryType: GridSummaryType.sum),
                          //       ],
                          //       position: GridTableSummaryRowPosition.bottom)
                          // ],

                          columns: [
                            GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'orderNumber',
                              toolTipMessage: "orderNumber",
                              columnTitle: "orderNumber",
                              columnWidthModeData: ColumnWidthMode.lastColumnFill,
                            ),
                            GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'companyName',
                              toolTipMessage: 'companyName',
                              columnTitle: 'companyName',
                            ),
                            GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'name',
                              toolTipMessage: 'name',
                              columnTitle: 'name',
                            ),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'orderStatus',
                                toolTipMessage: 'orderStatus',
                                columnTitle: 'orderStatus',
                                columnWidthModeData:
                                    ColumnWidthMode.lastColumnFill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'itemCount',
                                toolTipMessage: 'itemCount',
                                columnTitle: 'itemCount',
                                columnWidthModeData:
                                    ColumnWidthMode.lastColumnFill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'total',
                                toolTipMessage: 'total',
                                columnTitle: 'total',
                                columnWidthModeData:
                                    ColumnWidthMode.lastColumnFill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'id',
                                toolTipMessage: 'id',
                                columnTitle: 'id',
                                columnWidthModeData:
                                    ColumnWidthMode.lastColumnFill,
                                visible: false),
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

class AllOrdersDataSource extends DataGridSource {
  final BuildContext _context2;
  final OrdersPageBloc _ordersPageBloc;
  late List<DataGridRow> dataGridRows;
  AllOrdersDataSource(List<ViewAllOrders_model> machineProductionTargetData,
      this._context2, this._ordersPageBloc) {
    dataGridRows = machineProductionTargetData.map<DataGridRow>((dataGridRows) {
      dynamic name = dataGridRows.customer!.firstName;
      dynamic name2 = dataGridRows.customer!.lastName;
      String a = name + " " + name2;

      return DataGridRow(cells: [
        DataGridCell(
            columnName: "orderNumber", value: dataGridRows.orderNumber),
        DataGridCell(
            columnName: "companyName",
            value: dataGridRows.customer!.companyName),
        DataGridCell(columnName: "name", value: a),
        DataGridCell(
            columnName: "orderStatus", value: dataGridRows.orderStatus),
        DataGridCell(columnName: "itemCount", value: dataGridRows.itemCount),
        DataGridCell(columnName: "total", value: dataGridRows.total),
        DataGridCell(columnName: "id", value: dataGridRows.id),
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
          var items1 = [
            'Pending',
            'Processing',
            'Dispatched',
            'Refunded',
            'Delivered',
          ];

          String dropdownvalue = dataGridCell.value.toString();
          return Container(
            alignment: Alignment.center,
            child: dataGridCell.columnName == "orderStatus"
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                          context: _context2, builder: (_) => Text("abc"));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: dropdownvalue == "Pending"
                                ? Colors.deepOrangeAccent[100]
                                : dropdownvalue == "Dispatched"
                                    ? Colors.deepPurple[100]
                                    : dropdownvalue == "Refunded"
                                        ? Colors.red[50]
                                        : dropdownvalue == "Delivered"
                                            ? Colors.green[100]
                                            : dropdownvalue == "Processing"
                                                ? Colors.blue[100]
                                                : Colors.white),
                        child: DropdownButton<String>(
                            value: dropdownvalue,
                            items: items1.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              _ordersPageBloc.add(PutStatusEvent(
                                  {"orderStatus": newValue},
                                  row.getCells()[6].value));
                              dropdownvalue = newValue!;
                              items1[4] = newValue;
                              notifyListeners();
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
