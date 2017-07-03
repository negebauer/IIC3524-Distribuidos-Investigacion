use CyclicDist;

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
    cities[visits] = destination;
    visited[destination] = true;
    cost += wsp.costs[cities[visits - 1], destination];
    visits +=1 ;
  }

  proc back(wsp: WSP) {
    visits -= 1;
    const destination = cities[visits];
    cost -= wsp.costs[cities[visits - 1], destination];
    visited[destination] = false;
  }

  proc updateCost(wsp: WSP) {
    if cost < wsp.cost {
      wsp.cost = cost;
      wsp.cities = cities;
    }
  }

  proc dfs(wsp: WSP): void {
    if visits == wsp.size {
      updateCost(wsp);
      return;
    }
    if cost >= wsp.cost then return;
    for destination in 1..wsp.size-1 {
      if !visited(destination) {
        advance(wsp, destination);
        dfs(wsp);
        back(wsp);
      }
    }
  }
}

class WSP {
  const size: int;
  var cost = 10000000;
  var cities: [0..size - 1] int;
  var costs: [0..size-1, 0..size-1] int;
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

const DestinationSpace = {1..size-1} dmapped Cyclic(startIdx=1);
forall destination in DestinationSpace {
  writeln('task ', here.id, ' destination ', destination);
  const route = new Route();
  route.advance(wsp, destination);
  route.dfs(wsp);
  writeln('task ', here.id, ' destination ', destination, ' finished');
}

writeln('wsp cost');
writeln(wsp.cost);
writeln('wsp cities');
writeln(wsp.cities);
