config const cores=4;
config const input='./test/t3.txt';

const file = open(input, iomode.r);
const reader = file.reader();
var size: int;
reader.read(size);

class Route {
  var cities: [0..size-1] int;
  var visited: [0..size-1] int;
  var cost: int;
}

class Status {
  var destination: int;
  var node: int;
  var finished: bool;
  var cost: int;
  var cities: [0..size-1] int;
}

class WSP {
  const size: int;
  var cost: int;
  var cities: [0..size - 1] int;
  var costs: [0..size-1, 0..size-1] int;
  var status: [1..size-1] Status;
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

for destination in 1..size-1 {
  wsp.status[destination] = new Status(destination, -1);
}

for loc in Locales {
  on loc {
    for status in wsp.status {
      if (!status.finished && status.node == -1) {
        status.node = here.id;
        // advance status.destination
        // dfs
        // continue
      }
    }
  }
}

for s in wsp.status do writeln(s);
