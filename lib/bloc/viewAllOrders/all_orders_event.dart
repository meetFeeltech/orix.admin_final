
part of 'all_orders_bloc.dart';

abstract class OrdersPageEvent{}

class OrdersPageInitialEvent extends OrdersPageEvent{}

class AllFetchDataForOrdersPageEvent extends OrdersPageEvent{}

class PutStatusEvent extends OrdersPageEvent{

  final String id;
  final Map<String, dynamic> message;
  PutStatusEvent(this.message,this.id);

}