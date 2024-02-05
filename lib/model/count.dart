class Count {
  var cricket;
  var soccer;
  var tennis;

  Count({
    this.cricket,
    this.soccer,
    this.tennis,
  });

  factory Count.fromjson(Map<String, dynamic> jsondata) {
    return Count(
      tennis: jsondata['2'],
      soccer: jsondata['1'],
      cricket: jsondata['4'],
    );
  }
}
