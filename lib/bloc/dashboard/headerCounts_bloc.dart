
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/dashboard/dashboard_model.dart';
import '../../model/viewallorders/ViewAllOrders_model.dart';
import '../../network/repositary.dart';

part 'headerCount_state.dart';
part 'headerCounts_event.dart';

class HeaderCountsBloc extends Bloc<DashboardEvent,DashboardState>{

  final Repository repositaryRepo;

  HeaderCountsBloc(this.repositaryRepo) : super(DashboardInitialState()){

    on<DashboardEvent>((event, emit) async {

      if(event is FetchHeaderCountForHomePageEvent){
        late Dashboard_model Dashboard_model_data;
        late List<ViewAllOrders_model> allOrdersData1;
        String? queryData;

        if(event.startDate == null && event.endDate == null){
           queryData = null;

        }else{
           queryData = "sd=${event.startDate}&ed=${event.endDate}";
        }

        try {

          emit(DashboardLoadingState(true));
          Dashboard_model_data = await repositaryRepo.getHeaderCountsData(dateRangeQuery: queryData);
          allOrdersData1 = await repositaryRepo.getAllOrdersData();
          emit(DashboardLoadingState(false));
          emit(FetchHeaderCountForHomePageState(Dashboard_model_data,allOrdersData1));
        }
        catch (error) {
          emit(DashboardLoadingState(false));
          emit(APIFailureState(Exception(error.toString())));
        }


      }


      }

    );



  }



}


