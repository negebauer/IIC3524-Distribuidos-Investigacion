class Node {
  var data: real;
  var next: Node;
}

var head    = new Node(0);

var current = head;

for i in 1..numLocales-1 do
  on Locales[i] {
    current.next = new Node(i);
    current      = current.next;
  }

current = head;

while current {
  writeln("node with data = ", current.data, " on locale ", current.locale.name);
  current = current.next;
}

writeln();

current = head;

while current {
  on current {
    writeln("node with data = ", current.data, " on locale ", here.name);
    current = current.next;
  }
}

current = head;

while current {
  on current {
    var ptr = current;
    current = current.next;
    delete ptr;
  }
}
