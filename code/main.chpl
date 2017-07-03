config const input='./test/t3.txt';

const file = open(input, iomode.r);
const reader = file.reader();
var size: int;
reader.read(size);

class WSP {
  const size: int;
  var cost: int;
  var cities: [0..size - 1] int;
  var costs: [0..size-1, 0..size-1] int;
}

class Route {
  var cities: [0..size-1] int;
  var visited: [0..size-1] int;
  var size: int;
  var cost: int;
}

const wsp = new WSP(size);

for i in 0..size-1 {
  for j in i+1..size-1 {
    var cost: int;
    reader.read(cost);
    wsp.costs[i, j] = cost;
    wsp.costs[j, i] = cost;
  }
}
file.close();
