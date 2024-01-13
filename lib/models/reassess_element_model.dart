class ReassessElementModel {
  final String name;
  int count;
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

  void countUp(int count) {
    this.count += count;
  }
}
