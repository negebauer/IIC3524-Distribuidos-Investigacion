use CyclicDist;

config const cores=4;
config const input='./test/t3.txt';

const file = open(input, iomode.r);
const reader = file.reader();
var size: int;
reader.read(size);

class Route {
  var cities: [0..size-1] int;
  var visited: [0..size-1] bool;
  var cost: int;
  var visits: int;

  proc Route() {
    cities[0] = 0;
    visited[0] = true;
    visits = 1;
    cost = 0;
  }

  proc advance(wsp: WSP, destination: int) {
    visits +=1 ;
    cities[visits] = destination;
    visited[destination] = true;
    cost += wsp.costs[cities[visits - 1], cities[visits]];
  }

  proc dfs(wsp: WSP) {
    return;
  }
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

const DestinationSpace = {1..size-1} dmapped Cyclic(startIdx=1);

forall destination in DestinationSpace {
  const status = wsp.status[destination];
  status.node = here.id;
  const route = new Route();
  route.advance(wsp, destination);
  writeln(route);
}

/*coforall (loc, i) in zip(Locales, 0..) {
  coforall status in wsp.status {
    if (!status.finished && status.node == -1) {
      status.node = i;
      on loc {
        const route = new Route();
        route.advance(wsp, status.destination);
        route.dfs(wsp);
        status.finished = true;
        status.cost = route.cost;
        status.cities = route.cities;
      }
    }
  }
}*/

for s in wsp.status do writeln(s);
