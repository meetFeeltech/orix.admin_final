class ViewAllOrders_model {
  String? id;
  int? itemCount;
  String? orderStatus;
  String? createdAt;
  int? orderNumber;
  int? total;
  CreatedByUser? createdByUser;
  Null? updatedByUser;
  Customer? customer;

  ViewAllOrders_model(
      {this.id,
        this.itemCount,
        this.orderStatus,
        this.createdAt,
        this.orderNumber,
        this.total,
        this.createdByUser,
        this.updatedByUser,
        this.customer});

  ViewAllOrders_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCount = json['itemCount'];
    orderStatus = json['orderStatus'];
    createdAt = json['createdAt'];
    orderNumber = json['orderNumber'];
    total = json['total'];
    createdByUser = json['CreatedByUser'] != null
        ? new CreatedByUser.fromJson(json['CreatedByUser'])
        : null;
    updatedByUser = json['UpdatedByUser'];
    customer = json['Customer'] != null
        ? new Customer.fromJson(json['Customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemCount'] = this.itemCount;
    data['orderStatus'] = this.orderStatus;
    data['createdAt'] = this.createdAt;
    data['orderNumber'] = this.orderNumber;
    data['total'] = this.total;
    if (this.createdByUser != null) {
      data['CreatedByUser'] = this.createdByUser!.toJson();
    }
    data['UpdatedByUser'] = this.updatedByUser;
    if (this.customer != null) {
      data['Customer'] = this.customer!.toJson();
    }
    return data;
  }
  @override
  String toString() {
    return "$orderNumber";
  }
}

class CreatedByUser {
  String? id;
  String? firstName;
  String? lastName;

  CreatedByUser({this.id, this.firstName, this.lastName});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? companyName;
  String? email;
  String? mobile;
  String? gst;
  String? pan;


  Customer(
      {this.id,
        this.firstName,
        this.lastName,
        this.companyName,
        this.email,
        this.mobile,
        this.gst,
        this.pan});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    companyName = json['companyName'];
    email = json['email'];
    mobile = json['mobile'];
    gst = json['gst'];
    pan = json['pan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['companyName'] = this.companyName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gst'] = this.gst;
    data['pan'] = this.pan;
    return data;
  }

}
