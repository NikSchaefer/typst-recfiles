#import "lib.typ": recfile

// Load the test recfile
#let records = recfile("test.rec")

= Simple Recfile Demo

Total records loaded: #records.len()

== All Records
#for (i, record) in records.enumerate() {
  [*Record #(i + 1):*]
  for (field, value) in record {
    [- #field: #value]
  }
  []
}
