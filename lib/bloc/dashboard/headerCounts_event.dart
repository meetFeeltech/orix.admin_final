
part of 'headerCounts_bloc.dart';

abstract class DashboardEvent {}


class DashboardInitialEvent extends DashboardEvent {

}


class FetchHeaderCountForHomePageEvent extends  DashboardEvent{
  final String? startDate;
  final String? endDate;

  FetchHeaderCountForHomePageEvent({this.startDate,this.endDate});

}

