// Number of tasks
config const tasks = 3;

// Iterate over all locales
coforall loc in Locales {
  // Move execution to locale
  on loc {
    // Span tasks
    coforall tid in 1..tasks {
      writeln("Hello task ", tid, " locale ", loc.name, " (", here.id, "/", numLocales, ")");
    }
  }
}
