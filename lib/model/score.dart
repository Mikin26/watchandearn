class Cricket12 {
  var back1;
  var lay1;
  int back2 = 0;
  int lay2 = 0;

  Cricket12({
    this.back1,
    this.lay1,
    this.back2 = 0,
    this.lay2 = 0,
  });

  factory Cricket12.fromjson(Map<String, dynamic> jsondata) {
    return Cricket12(
      back1: jsondata['back1'],
      lay1: jsondata['lay1'],
    );
  }
}
