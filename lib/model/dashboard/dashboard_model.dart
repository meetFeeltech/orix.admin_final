class Dashboard_model {
  int? totalProduct;
  int? totalCustomer;
  int? totalPendingCustomer;
  int? totalOrder;

  Dashboard_model(
      {this.totalProduct,
        this.totalCustomer,
        this.totalPendingCustomer,
        this.totalOrder});

  Dashboard_model.fromJson(Map<String, dynamic> json) {
    totalProduct = json['totalProduct'];
    totalCustomer = json['totalCustomer'];
    totalPendingCustomer = json['totalPendingCustomer'];
    totalOrder = json['totalOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalProduct'] = this.totalProduct;
    data['totalCustomer'] = this.totalCustomer;
    data['totalPendingCustomer'] = this.totalPendingCustomer;
    data['totalOrder'] = this.totalOrder;
    return data;
  }
}
