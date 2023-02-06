
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orix_aqua_adim/model/viewallorders/ViewAllOrders_model.dart';

import '../../model/orderstatus/order_status_model.dart';
import '../../network/repositary.dart';

part 'all_orders_event.dart';
part 'all_orders_state.dart';


class OrdersPageBloc extends Bloc<OrdersPageEvent, OrdersPageState> {
  final Repository repositoryRepo;

  OrdersPageBloc(this.repositoryRepo) : super(OrdersPageInitialState()) {
    on<OrdersPageEvent>((event, emit) async {

      if(event is AllFetchDataForOrdersPageEvent){
        late List<ViewAllOrders_model> allOrdersData;
        // late StatusChange_model statusChange_model_data;

        try{
          emit(OrdersPageLoadingState(true));
          allOrdersData = await repositoryRepo.getAllOrdersData();
          // statusChange_model_data = await repositoryRepo.putStatusData('message':event.);
          emit(OrdersPageLoadingState(false));
          emit(AllFetchDataForOrdersPageState(allOrdersData));

        }
        catch(error,stacktrace){
          print("stacktrave: $stacktrace");
          emit(OrdersPageLoadingState(false));
          emit(ApiFailureState(Exception(error.toString())));
        }

      }

      if(event is PutStatusEvent){
        late List<ViewAllOrders_model> allOrdersData;
        late StatusChange_model statusChange_model_data;
        try{
          emit(OrdersPageLoadingState(true));
          statusChange_model_data = await repositoryRepo.putStatusData(message: event.message,id: event.id);

          allOrdersData = await repositoryRepo.getAllOrdersData();
          emit(OrdersPageLoadingState(false));
          emit(AllFetchDataForOrdersPageState(allOrdersData));

        }
        catch(error,stacktrace){
          print("stacktrave: $stacktrace");
          emit(OrdersPageLoadingState(false));
          emit(ApiFailureState(Exception(error.toString())));
        }

      }



    });
  }
}


