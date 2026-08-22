class ComplaintTypeModel {
  ComplaintTypeModel({
    required this.complaintTypeId,
    required this.complaintIssueMessage,
  });

  final String complaintTypeId;
  final String complaintIssueMessage;

  factory ComplaintTypeModel.fromJson(Map<String, dynamic> json) {
    return ComplaintTypeModel(
      complaintTypeId: json['id'],
      complaintIssueMessage: json['name'],
    );
  }
}
