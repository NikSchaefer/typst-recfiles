# Recfiles

A simple and lightweight parser for [recfiles](https://www.gnu.org/software/recutils/) (recutils) data format in Typst.

## Features

- Parse recfiles into native Typst data structures
- Support for multiple records and field types
- Handle multi-value fields (converted to arrays)

## Installation

For local use, download and import:
```typst
#import "lib.typ": recfile
```

For package registry (when available):
```typst
#import "@preview/recfiles:0.1.0": recfile
```

## Quick Start

```typst
#import "lib.typ": recfile

// Load records from a recfile
#let records = recfile("data.rec")

// Display all records
#for (i, record) in records.enumerate() {
  [*Record #(i + 1):*]
  for (field, value) in record {
    [- #field: #value]
  }
  []
}
```

## API Reference

### `recfile(filename)`

Parses a recfile and returns an array of records.

**Parameters:**
- `filename` (string): Path to the recfile to parse

**Returns:**
- Array of dictionaries, where each dictionary represents a record with field-value pairs

**Example:**
```typst
#let data = recfile("employees.rec")
// Returns: (
//   (Name: "John Doe", Age: "30", Email: "john@example.com"),
//   (Name: "Jane Smith", Age: "28", Email: "jane@example.com")
// )
```

## Recfile Format

Recfiles use a simple text format:
- Records are separated by blank lines
- Fields use `field: value` format
- Comments start with `#`
- Record type declarations start with `%`
- Multiple values for the same field create arrays

Example recfile:
```
# Employee database
%rec: Employee

Name: John Doe
Age: 30
Email: john.doe@example.com
Department: Engineering

Name: Jane Smith
Age: 28
Email: jane.smith@example.com
Department: Marketing
```

## Multi-value Fields

When a field appears multiple times in a record, values are automatically converted to an array:

```
# Meeting record
Title: Sprint Planning
Attendees: John Doe
Attendees: Jane Smith
Attendees: Bob Wilson
```

Results in:
```typst
(
  Title: "Sprint Planning",
  Attendees: ("John Doe", "Jane Smith", "Bob Wilson")
)
```

## License

MIT License - see LICENSE file for details.

