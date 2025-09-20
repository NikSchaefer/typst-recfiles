// Simple recfile parser - loads data into basic Typst structures

#let recfile(content) = {
  let lines = content.split("\n")
  let records = ()
  let current-record = (:)

  for line in lines {
    let line = line.trim()

    // Empty line ends current record
    if line == "" {
      if current-record != (:) {
        records.push(current-record)
        current-record = (:)
      }
      continue
    }

    // Skip comments and record type declarations
    if line.starts-with("#") or line.starts-with("%") {
      continue
    }

    // Check if this is a field line
    if line.contains(":") {
      let colon-pos = line.position(":")
      let field-name = line.slice(0, colon-pos).trim()
      let field-value = line.slice(colon-pos + 1).trim()

      // Add field to current record
      if field-name in current-record {
        // Multiple values - convert to array
        if type(current-record.at(field-name)) == array {
          current-record.at(field-name).push(field-value)
        } else {
          current-record.insert(field-name, (
            current-record.at(field-name),
            field-value,
          ))
        }
      } else {
        current-record.insert(field-name, field-value)
      }
    }
  }

  // Save last record if exists
  if current-record != (:) {
    records.push(current-record)
  }

  return records
}

