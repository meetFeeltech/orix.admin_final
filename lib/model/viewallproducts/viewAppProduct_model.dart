class ViewAllPro_model {
  String? prodSortDesc;
  String? prodLongDesc;
  String? id;
  String? prodName;
  String? prodSku;
  dynamic tax;
  int? freight;
  int? prodQty;
  int? branchPrice;
  int? distributorPrice;
  int? dealerPrice;
  int? wholesalerPrice;
  int? technicianPrice;
  String? thumbnail;
  String? imgOne;
  String? imgTwo;
  bool? prodStock;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? brandId;
  String? categoryId;
  String? createdBy;
  String? updatedBy;
  Null? deletedBy;
  CreatedByUser? createdByUser;
  CreatedByUser? updatedByUser;
  Category? category;
  Brand? brand;

  ViewAllPro_model(
      {this.prodSortDesc,
        this.prodLongDesc,
        this.id,
        this.prodName,
        this.prodSku,
        this.tax,
        this.freight,
        this.prodQty,
        this.branchPrice,
        this.distributorPrice,
        this.dealerPrice,
        this.wholesalerPrice,
        this.technicianPrice,
        this.thumbnail,
        this.imgOne,
        this.imgTwo,
        this.prodStock,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.brandId,
        this.categoryId,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdByUser,
        this.updatedByUser,
        this.category,
        this.brand});

  ViewAllPro_model.fromJson(Map<String, dynamic> json) {
    prodSortDesc = json['prodSortDesc'];
    prodLongDesc = json['prodLongDesc'];
    id = json['id'];
    prodName = json['prodName'];
    prodSku = json['prodSku'];
    tax = json['tax'];
    freight = json['freight'];
    prodQty = json['prodQty'];
    branchPrice = json['branchPrice'];
    distributorPrice = json['distributorPrice'];
    dealerPrice = json['dealerPrice'];
    wholesalerPrice = json['wholesalerPrice'];
    technicianPrice = json['technicianPrice'];
    thumbnail = json['thumbnail'];
    imgOne = json['imgOne'];
    imgTwo = json['imgTwo'];
    prodStock = json['prodStock'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    brandId = json['brandId'];
    categoryId = json['categoryId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    createdByUser = json['CreatedByUser'] != null
        ? new CreatedByUser.fromJson(json['CreatedByUser'])
        : null;
    updatedByUser = json['UpdatedByUser'] != null
        ? new CreatedByUser.fromJson(json['UpdatedByUser'])
        : null;
    category = json['Category'] != null
        ? new Category.fromJson(json['Category'])
        : null;
    brand = json['Brand'] != null ? new Brand.fromJson(json['Brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prodSortDesc'] = this.prodSortDesc;
    data['prodLongDesc'] = this.prodLongDesc;
    data['id'] = this.id;
    data['prodName'] = this.prodName;
    data['prodSku'] = this.prodSku;
    data['tax'] = this.tax;
    data['freight'] = this.freight;
    data['prodQty'] = this.prodQty;
    data['branchPrice'] = this.branchPrice;
    data['distributorPrice'] = this.distributorPrice;
    data['dealerPrice'] = this.dealerPrice;
    data['wholesalerPrice'] = this.wholesalerPrice;
    data['technicianPrice'] = this.technicianPrice;
    data['thumbnail'] = this.thumbnail;
    data['imgOne'] = this.imgOne;
    data['imgTwo'] = this.imgTwo;
    data['prodStock'] = this.prodStock;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['brandId'] = this.brandId;
    data['categoryId'] = this.categoryId;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['deletedBy'] = this.deletedBy;
    if (this.createdByUser != null) {
      data['CreatedByUser'] = this.createdByUser!.toJson();
    }
    if (this.updatedByUser != null) {
      data['UpdatedByUser'] = this.updatedByUser!.toJson();
    }
    if (this.category != null) {
      data['Category'] = this.category!.toJson();
    }
    if (this.brand != null) {
      data['Brand'] = this.brand!.toJson();
    }
    return data;
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

class Category {
  String? id;
  String? categoryName;

  Category({this.id, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    return data;
  }
}

class Brand {
  String? id;
  String? brandName;

  Brand({this.id, this.brandName});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brandName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandName'] = this.brandName;
    return data;
  }
}
