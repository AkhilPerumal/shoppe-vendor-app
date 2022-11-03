class AllStateDistrictModel {
  AllStateDistrictModel({
    this.status,
    this.message,
    this.resultData,
  });

  String status;
  String message;
  Map<String, List<String>> resultData;
  List<StateDistrict> stateDistrictList;
  List<String> stateList;

  AllStateDistrictModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] == null ? null : json["status"];
    message = json["message"] == null ? null : json["message"];
    resultData = json["resultData"] == null
        ? null
        : Map.from(json["resultData"]).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x))));
    stateList = [];
    stateDistrictList = [];
    resultData.forEach((key, value) {
      stateList.add(key);
      stateDistrictList.add(StateDistrict(state: key, districtList: value));
    });
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "resultData": resultData == null
            ? null
            : Map.from(resultData).map((k, v) => MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x)))),
      };
}

class StateDistrict {
  String state;
  List<String> districtList;
  StateDistrict({this.state, this.districtList});
}
