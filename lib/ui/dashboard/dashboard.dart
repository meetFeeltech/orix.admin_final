import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orix_aqua_adim/bloc/dashboard/headerCounts_bloc.dart';
import 'package:orix_aqua_adim/network/repositary.dart';
import 'package:orix_aqua_adim/ui/view_all_category/view_all_category.dart';
import 'package:orix_aqua_adim/ui/view_all_orders/view_all_orders.dart';
import 'package:orix_aqua_adim/ui/view_all_products/view_all_products.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../commonWidget/global_methods.dart';
import '../../commonWidget/theme_helper.dart';
import '../../model/dashboard/dashboard_model.dart';
import '../../model/viewallorders/ViewAllOrders_model.dart';
import '../GridDataCommonFunc/GridDataCommonFunc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  HeaderCountsBloc headBloc = HeaderCountsBloc(Repository.getInstance());
  Dashboard_model? Dashboard_model_data;
  String? headerCountDateRange;

  List<ViewAllOrders_model>? allordersmodelData;
  late AllOrdersDataSource _allOrdersDataSource;


  @override
  void initState() {
    super.initState();
    loadAllAPIsForUI();
    allordersmodelData = [];
  }

  void loadAllAPIsForUI() {
    DateTime todayDate = DateTime.now();
    String convertedTodayDateToYMD = GlobalMethods.convertToYMDFormat(todayDate.toString());
    headerCountDateRange =
        GlobalMethods.filterRangeFormat(todayDate: todayDate);
    String monthStartDate = "${todayDate.year}-${todayDate.month}-01";
    headBloc.add(FetchHeaderCountForHomePageEvent(startDate: monthStartDate,endDate: convertedTodayDateToYMD));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: BlocProvider<HeaderCountsBloc>(
        create: (context) => headBloc..add(DashboardInitialEvent()),
        child: BlocConsumer<HeaderCountsBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else if (state is FetchHeaderCountForHomePageState) {
              Dashboard_model_data = state.Dashboard_model_data;
              for(int i=0;i<=20;i++){
                print("5th data : ${state.allOrderModel.elementAt(5)}");
                // print("${state.allOrderModel[i]}");
                 allordersmodelData?.add(state.allOrderModel[i]);
                // print("${state.allOrderModel[i]}");
                // print(i);
              }
              _allOrdersDataSource =
                  AllOrdersDataSource(allordersmodelData!, context);

              return mainDashboard();
            } else
              return Center(
                child: Text("sry Error here"),
              );
          },
          listener: (context, state) {},
        ),
      ),
      // body: mainDashboard(),
    );
  }

  Widget mainDashboard() {
    double main_Width = MediaQuery.of(context).size.width;
    double main_Height = MediaQuery.of(context).size.height;

    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(

      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 0, 160, 227),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Meet"),
              decoration: BoxDecoration(color: Colors.white),
              accountEmail: Text("mevadameet@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Image.asset(
                  "assets/images/m1.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "View all Products",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ViewAllProducts()));
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                "View all categories",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ViewAllCategory()));
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                "View all Orders",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewAllOrders()));
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),

      key: scaffoldKey,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh:() async{
              loadAllAPIsForUI();
          } ,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 15, left: 12, right: 12),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: Container(
                                child: Image.asset(
                                  "assets/images/r.png",
                                ),
                              ),
                              onTap: () {
                                scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Orix Aqua",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 160, 227),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Feeltech Solution",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ],
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xFF121223),
                          child: Icon(
                            Icons.shopping_bag_sharp,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PRODUCTS & ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "ORDERS details : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              PickerDateRange? dateRange =
                              await selectDateRangeForFilter(context,
                                  homePageBloc: headBloc);
                              if (dateRange?.startDate != null &&
                                  dateRange?.endDate != null) {
                                print(
                                    "GlobalMethods.convertToDMYFormat(dateRange?.startDate.toString(): ${GlobalMethods.convertToDMYFormat(dateRange?.startDate.toString() ?? "")}");
                                print("inside");
                                setState(() {
                                  // initialDateRangeForAll = null;
                                  headerCountDateRange =
                                      GlobalMethods.filterRangeFormat(
                                          startDate: dateRange?.startDate,
                                          endDate: dateRange?.endDate);
                                });

                                headBloc.add(FetchHeaderCountForHomePageEvent(
                                    startDate: GlobalMethods.convertToYMDFormat(
                                        dateRange?.startDate.toString() ?? ""),
                                    endDate: GlobalMethods.convertToYMDFormat(
                                        dateRange?.endDate.toString() ?? "")));
                              }
                              print("popup data: ${dateRange?.startDate}");
                              print("popup data: ${dateRange?.endDate}");
                            },
                            child: Material(
                              elevation: 2,
                              // shadowColor: transparentColor,
                              borderRadius: BorderRadius.circular(5),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // color: const Color.fromARGB(158, 235, 235, 235),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.blue, width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 8,
                                            spreadRadius: -2,
                                            color: Color.fromARGB(255, 190, 190, 190),
                                            // blurStyle: BlurStyle.normal
                                            blurStyle: BlurStyle.solid),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          headerCountDateRange ?? "",
                                          style: const TextStyle(
                                            // fontSize: 12
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(
                                              minWidth: 15, minHeight: 40),
                                          // constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),

                                          onPressed: null,
                                          disabledColor: Colors.black,
                                          // icon: Icon(
                                          //   Icons.calendar_month,
                                          // )
                                          icon: Image(
                                              image: AssetImage(
                                                  "assets/images/calender.png")),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 1, right: 1),
                      child: Container(
                        height: main_Height * 0.21,
                        width: main_Width * 1,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(blurRadius: 0.000001, color: Colors.grey),
                            ],
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 5),
                                          child: Text(
                                            "${Dashboard_model_data?.totalCustomer}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 5),
                                          child: Text(
                                            "Total Customers :",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    height: main_Height * 0.08,
                                    width: main_Width * 0.415,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 5),
                                          child: Text(
                                            "${Dashboard_model_data?.totalPendingCustomer}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 5),
                                          child: Text(
                                            "Pending Customers :",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    height: main_Height * 0.08,
                                    width: main_Width * 0.415,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 5),
                                          child: Text(
                                            "${Dashboard_model_data?.totalOrder}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 5),
                                          child: Text(
                                            "Total placed orders :",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    height: main_Height * 0.08,
                                    width: main_Width * 0.415,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 5),
                                          child: Text(
                                            "${Dashboard_model_data?.totalProduct}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 5),
                                          child: Text(
                                            "Total product actives :",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    height: main_Height * 0.08,
                                    width: main_Width * 0.415,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),






                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    

                    Padding(
                      padding:
                          const EdgeInsets.only( top: 15,bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RECENT PLACED Orders : ",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w600),

                                  ),

                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),

                    Container(
                      height: main_Height * 0.9,
                      width: main_Width * 1,
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                          headerColor: Colors.blue[300],
                          sortIconColor: Colors.white,
                        ),
                        child: SfDataGrid(
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
                          // rowsPerPage: 20,
                          // frozenColumnsCount: 20,
                          // frozenRowsCount: 20,
                          // footerFrozenRowsCount: 50,
                          // rowsCacheExtent: 20,



                          columns: [
                            GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'orderNumber',
                              toolTipMessage: "orderNumber",
                              columnTitle: "orderNumber",
                              columnWidthModeData: ColumnWidthMode.fill,
                            ),
                            GridDataCommonFunc.tableColumnsDataLayout(
                              columnName: 'companyName',
                              toolTipMessage: 'companyName',
                              columnTitle: 'companyName',
                              columnWidthModeData: ColumnWidthMode.fitByColumnName,
                            ),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'itemCount',
                                toolTipMessage: 'itemCount',
                                columnTitle: 'itemCount',
                                columnWidthModeData:
                                ColumnWidthMode.lastColumnFill),
                          ],
                        ),
                      ),
                    )



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Future<PickerDateRange?> selectDateRangeForFilter(BuildContext context,
    {HeaderCountsBloc? homePageBloc}) {
  double mainWidth = MediaQuery.of(context).size.height;
  double mainHeight = MediaQuery.of(context).size.height;

  return showDialog<PickerDateRange>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Select Date Range'),
            content: SizedBox(
              height: mainHeight / 3,
              width: mainWidth,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                showActionButtons: true,
                selectionShape: DateRangePickerSelectionShape.rectangle,
                // showTodayButton: true,
                onSubmit: (p0) {
                  print("here in");
                  if (p0 != null) {
                    print(p0);
                    Navigator.of(context).pop(p0);
                  } else {
                    print("p0: $p0");
                  }
                },
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ));
}


class AllOrdersDataSource extends DataGridSource {
  final BuildContext _context2;


  late List<DataGridRow> dataGridRows;
  AllOrdersDataSource(List<ViewAllOrders_model> machineProductionTargetData,
      this._context2) {
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
        DataGridCell(columnName: "itemCount", value: dataGridRows.itemCount),
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

          void main()
          {
            int num = 1;
            for(num; num<=20; num++)
                {
              print(num);
            }
          }

          return Container(
            alignment: Alignment.center,
            child: Align(
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
