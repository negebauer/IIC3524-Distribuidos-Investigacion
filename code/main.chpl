config const input='./test/t3.txt';

proc main() {
  const file = open(input, iomode.r);
  const reader = file.reader();
  var size: int;
  reader.read(size);
  var roadsCost: [0..size-1, 0..size-1] int;

  for i in 0..size-1 {
    for j in i+1..size-1 {
      var cost: int;
      reader.read(cost);
      roadsCost[i, j] = cost;
      roadsCost[j, i] = cost;
    }
  }
}
