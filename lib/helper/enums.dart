enum franchiseType {
  ALL_franchise,
}

enum CategoryType { CAR_SHOPPE, CAR_MECHANIC, CAR_SPA, QUICK_HELP }

enum SubTabType { NEW, ACTIVE, COMPELTED, CANCELLED }

enum OrderStatus {
  ACTIVE,
  PROCESSING,
  CONFIRMED,
  DISPATCHED,
  FAILED,
  ACCEPTED,
  REASSIGNED,
  COMPLETED,
  REJECTED,
  CANCELLED,
  IN_PROGRESS,
  RETURN_REQUESTED,
  RETURN_ACCEPTED,
  RETURN_APPROVED,
  RETURN_REJECTED,
  RETURN_RECIEVED,
  REFUND_PROCESSING,
  REFUND_COMPLETED,
  REPLACEMENT_PROCESSING,
  REPLACEMENT_DISPATCHED,
  REPLACEMENT_COMPLETED,
  OTHER
}

enum OrderPage { ACTIVE, HISTORY }

class EnumConverter {
  static orderStatusToTitle(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.ACTIVE:
        return "Active";
        break;
      case OrderStatus.PROCESSING:
        return "Processing";
        break;
      case OrderStatus.ACCEPTED:
        return "Accepted";
        break;
      case OrderStatus.REASSIGNED:
        return "Re Assigned";
        break;
      case OrderStatus.COMPLETED:
        return "Completed";
        break;
      case OrderStatus.REJECTED:
        return "Rejected";
        break;
      case OrderStatus.CANCELLED:
        return "Cancelled";
        break;
      case OrderStatus.IN_PROGRESS:
        return "In Progress";
        break;
      case OrderStatus.OTHER:
        return "Other";
        break;
      case OrderStatus.CONFIRMED:
        return "Confirmed";
        break;
      case OrderStatus.DISPATCHED:
        return "Dispatched";
        break;
      case OrderStatus.FAILED:
        return "Failed";
        break;
      case OrderStatus.RETURN_REQUESTED:
        return "Return Requested";
        break;
      case OrderStatus.RETURN_ACCEPTED:
        return "Return Policy";
        break;
      case OrderStatus.RETURN_APPROVED:
        return "Return Accepted";
        break;
      case OrderStatus.RETURN_REJECTED:
        return "Return Rejected";
        break;
      case OrderStatus.RETURN_RECIEVED:
        return "Return Recieved";
        break;
      case OrderStatus.REFUND_PROCESSING:
        return "Refund Processing";
        break;
      case OrderStatus.REFUND_COMPLETED:
        return "Refund Completed";
        break;
      case OrderStatus.REPLACEMENT_PROCESSING:
        return "Replacement Processing";
      case OrderStatus.REPLACEMENT_DISPATCHED:
        return "Replacement Dispatched";
        break;
      case OrderStatus.REPLACEMENT_COMPLETED:
        return "Replacement Completed";
        break;
    }
  }

  static String convertEnumToStatus(OrderStatus orderStatus) {
    var status = "";
    switch (orderStatus) {
      case OrderStatus.ACCEPTED:
        status = "Accepted";
        break;
      case OrderStatus.PROCESSING:
        status = "Processing";
        break;
      case OrderStatus.ACTIVE:
        status = "Active";
        break;
      case OrderStatus.REASSIGNED:
        status = "Reassigned";
        break;
      case OrderStatus.REJECTED:
        return "Rejected";
        break;
      case OrderStatus.COMPLETED:
        status = "Completed";
        break;
      case OrderStatus.CANCELLED:
        status = "Cancelletd";
        break;
      case OrderStatus.IN_PROGRESS:
        status = "In_Progress";
        break;
      case OrderStatus.OTHER:
        status = "Other";
        break;
      case OrderStatus.CONFIRMED:
        status = "Confirmed";
        break;
      case OrderStatus.DISPATCHED:
        status = "Dispatched";
        break;
      case OrderStatus.FAILED:
        status = "Failed";
        break;
      case OrderStatus.RETURN_REQUESTED:
        status = "Return_Requested";
        break;
      case OrderStatus.RETURN_ACCEPTED:
        status = "Return_Policy";
        break;
      case OrderStatus.RETURN_APPROVED:
        status = "Return_Accepted";
        break;
      case OrderStatus.RETURN_REJECTED:
        status = "Return_Rejected";
        break;
      case OrderStatus.RETURN_RECIEVED:
        status = "Return_Recieved";
        break;
      case OrderStatus.REFUND_PROCESSING:
        status = "Refund_Processing";
        break;
      case OrderStatus.REFUND_COMPLETED:
        status = "Refund_Completed";
        break;
      case OrderStatus.REPLACEMENT_PROCESSING:
        status = "Replacement_Processing";
        break;
      case OrderStatus.REPLACEMENT_DISPATCHED:
        status = "Replacement_Dispatched";
        break;
      case OrderStatus.REPLACEMENT_COMPLETED:
        status = "Replacement_Completed";
        break;
    }
    return status;
  }

  static OrderStatus convertEnumFromStatus(String orderStatus) {
    if (orderStatus == "Active") {
      return OrderStatus.ACTIVE;
    } else if (orderStatus == "Processing") {
      return OrderStatus.PROCESSING;
    } else if (orderStatus == "Reassigned") {
      return OrderStatus.REASSIGNED;
    } else if (orderStatus == "Accepted") {
      return OrderStatus.ACCEPTED;
    } else if (orderStatus == "In_Progress") {
      return OrderStatus.IN_PROGRESS;
    } else if (orderStatus == "Rejected") {
      return OrderStatus.REJECTED;
    } else if (orderStatus == "Completed") {
      return OrderStatus.COMPLETED;
    } else if (orderStatus == "Cancelletd") {
      return OrderStatus.CANCELLED;
    } else if (orderStatus == "Confirmed") {
      return OrderStatus.CONFIRMED;
    } else if (orderStatus == "Dispatched") {
      return OrderStatus.DISPATCHED;
    } else if (orderStatus == "Failed") {
      return OrderStatus.FAILED;
    } else if (orderStatus == "Refund_Completed") {
      return OrderStatus.REFUND_COMPLETED;
    } else if (orderStatus == "Refund_Processing") {
      return OrderStatus.REFUND_PROCESSING;
    } else if (orderStatus == "Replacement_Completed") {
      return OrderStatus.REPLACEMENT_COMPLETED;
    } else if (orderStatus == "Replacement_Dispatched") {
      return OrderStatus.REPLACEMENT_DISPATCHED;
    } else if (orderStatus == "Replacement_Processing") {
      return OrderStatus.REPLACEMENT_PROCESSING;
    } else if (orderStatus == "Return_Accepted") {
      return OrderStatus.RETURN_ACCEPTED;
    } else if (orderStatus == "Return_Approved") {
      return OrderStatus.RETURN_APPROVED;
    } else if (orderStatus == "Return_Recieved") {
      return OrderStatus.RETURN_RECIEVED;
    } else if (orderStatus == "Return_Rejected") {
      return OrderStatus.RETURN_REJECTED;
    } else {
      return OrderStatus.OTHER;
    }
  }

  static getCategoryString(CategoryType category) {
    var categoryString;
    switch (category) {
      case CategoryType.CAR_SHOPPE:
        categoryString = "order";
        break;
      case CategoryType.CAR_MECHANIC:
        categoryString = "mechanical-order";
        break;
      case CategoryType.CAR_SPA:
        categoryString = "carspa-order";
        break;
      case CategoryType.QUICK_HELP:
        categoryString = "quickhelp-order";
        break;
    }
    return categoryString;
  }

  static getNotificationString(CategoryType categoryType) {
    var categoryString;
    switch (categoryType) {
      case CategoryType.CAR_SHOPPE:
        categoryString = "Shoppe";
        break;
      case CategoryType.CAR_MECHANIC:
        categoryString = "Mechanical";
        break;
      case CategoryType.CAR_SPA:
        categoryString = "Carspa";
        break;
      case CategoryType.QUICK_HELP:
        categoryString = "Quickhelp";
        break;
    }
    return categoryString;
  }

  static getNotificationEnum(String categoryType) {
    if (categoryType == "Shoppe") {
      return CategoryType.CAR_SHOPPE;
    }
    if (categoryType == "Mechanical") {
      return CategoryType.CAR_MECHANIC;
    }
    if (categoryType == "Carspa") {
      return CategoryType.CAR_SPA;
    }
    if (categoryType == "Quickhelp") {
      return CategoryType.QUICK_HELP;
    }
  }

  static getResponseError(int statusCode) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return "Unauthorized Request";
        break;
      case 404:
        return "Not found";
        break;
      case 409:
        return "Error due to a conflict";
        break;
      case 408:
        return "Connection request timeout";
        break;
      case 500:
        return "Internal Server Error";
        break;
      case 503:
        return "Service unavailable";
        break;
      default:
        return "Received invalid status code";
    }
  }
}
