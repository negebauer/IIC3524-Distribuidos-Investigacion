config const input='./test/t3.txt';

/*
  Solo se van a compartir entre nodos
  - Costo ruta más barata     (costGlobal)
  - Ciudades ruta más barata  (citiesGlobal)
*/

const file = open(input, iomode.r);
const reader = file.reader();
var sizeGlobal: int;
reader.read(sizeGlobal);
file.close();

class WSP {
  var cost: int;
  var cities: [0..sizeGlobal-1] int;
}

const wspGlobal = new WSP(10000);

// Mapeamos destinos a los nodos
const destinationsForNode: int = (sizeGlobal-1)/numLocales;
var destinationsNode: [0..numLocales-1] domain(int);
var node = 0;
for destination in 1..sizeGlobal-1 {
  destinationsNode[node] += destination;
  if (node == numLocales-1) {
    node = 0;
  } else {
    node += 1;
  }
}
writeln('destinationsNode');
writeln(destinationsNode);

// Definimos la clase Ruta
class Route {
  var cities: [0..sizeGlobal-1] int;
  var visited: [0..sizeGlobal-1] bool;
  var cost: int;
  var visits: int;

  proc Route() {
    cities[0] = 0;
    visited[0] = true;
    visits = 1;
    cost = 0;
  }

  proc advance(costs: [] int, destination: int) {
    cities[visits] = destination;
    visited[destination] = true;
    cost += costs[cities[visits - 1], destination];
    visits +=1 ;
  }

  proc back(costs: [] int) {
    visits -= 1;
    const destination = cities[visits];
    cost -= costs[cities[visits - 1], destination];
    visited[destination] = false;
  }

  proc dfs(costs: [] int, size: int, wsp: WSP, wspGlobal: WSP) {
    if visits == size {
      if cost < wsp.cost {
        wsp.cost = cost;
        wsp.cities = cities;
        if cost < wspGlobal.cost {
          wspGlobal.cost = cost;
          wspGlobal.cities = cities;
        }
      }
      return;
    }
    if cost >= wsp.cost then return;
    for destination in 1..size-1 {
      if !visited(destination) {
        advance(costs, destination);
        dfs(costs, size, wsp, wspGlobal);
        back(costs);
      }
    }
  }
}

coforall loc in Locales {
  on loc {
    // Cargamos la matriz de costos en cada local
    var size = sizeGlobal;
    const wsp = wspGlobal;
    var costs: [0..size-1, 0..size-1] int;

    const file = open(input, iomode.r);
    const reader = file.reader();
    reader.read(size);
    for i in 0..size-1 {
      for j in i+1..size-1 {
        var cost: int;
        reader.read(cost);
        costs[i, j] = cost;
        costs[j, i] = cost;
      }
    }
    file.close();

    // Trabajamos en los destinos que le corresponden al nodo
    forall destination in destinationsNode[here.id] {
      writeln('task ', here.id, ' destination ', destination);
      const route = new Route();
      route.advance(costs, destination);
      route.dfs(costs, size, wsp, wspGlobal);
      writeln('task ', here.id, ' destination ', destination, ' finished');
    }
  }
}

writeln('cost');
writeln(wspGlobal.cost);
writeln('route');
writeln(wspGlobal.cities);
