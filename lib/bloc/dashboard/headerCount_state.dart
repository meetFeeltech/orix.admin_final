
part of 'headerCounts_bloc.dart';

abstract class DashboardState {}

class DashboardInitialState extends DashboardState {
}


class DashboardLoadingState extends DashboardState {
  final bool showProgress;
  DashboardLoadingState(this.showProgress);
}


class APIFailureState extends DashboardState {
  final Exception exception;
  APIFailureState(this.exception);
}


class FetchHeaderCountForHomePageState extends DashboardState {
  final Dashboard_model Dashboard_model_data;
  final List<ViewAllOrders_model> allOrderModel;

  FetchHeaderCountForHomePageState(this.Dashboard_model_data,this.allOrderModel);
}

