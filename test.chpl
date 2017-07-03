// Iterate over all locales
coforall loc in Locales {
  // Move execution to locale
  on loc {
    // Span 4 tasks
    coforall tid in 0..3 {
      writeln("Hello task ", tid, " locale ", loc.name, " (", here.id, "/", numLocales, ")");
    }
  }
}
