
part of 'all_orders_bloc.dart';

abstract class OrdersPageState{}

class OrdersPageInitialState extends OrdersPageState{}

class AllFetchDataForOrdersPageState extends OrdersPageState{
  final List<ViewAllOrders_model> allOrderModel;
  AllFetchDataForOrdersPageState(this.allOrderModel);
}

class OrdersPageLoadingState extends  OrdersPageState{
  final bool showProgress;
  OrdersPageLoadingState(this.showProgress);
}

class ApiFailureState extends OrdersPageState{
  final Exception exception;
  ApiFailureState(this.exception);
}

class PutStatusState extends OrdersPageState{
  final StatusChange_model message;
  PutStatusState(this.message);
}

