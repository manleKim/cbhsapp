class ReassessElementModel {
  final String name;
  final int count;
  final int total;

  ReassessElementModel({
    required this.name,
    required this.count,
    required this.total,
  });

  bool isSatisfied() {
    //횟수를 다 채웠는가
    return count / total >= 1;
  }
}
