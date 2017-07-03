config const input='./test/t3.txt';

proc readRoadsCosts() {
  const file = open(input, iomode.r);
  const reader = file.reader();
  var size: int;
  reader.read(size);
  var costs: [0..size-1, 0..size-1] int;
  for i in 0..size-1 {
    for j in i+1..size-1 {
      var cost: int;
      reader.read(cost);
      costs[i, j] = cost;
      costs[j, i] = cost;
    }
  }
  file.close();
  return costs;
}

proc main() {
  const roadCost = readRoadsCosts();
}
