use CyclicDist;

config const input='./test/t3.txt';
config const size=12;

coforall loc in Locales {
  on loc {
    const DestinationSpace = {1..size-1} dmapped Cyclic(startIdx=1);
    forall destination in DestinationSpace {
      writeln('task ', here.id, ' destination ', destination);
    }
  }
}
