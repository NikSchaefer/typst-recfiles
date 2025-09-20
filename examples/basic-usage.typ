#import "../lib.typ": recfile

// Basic usage example
#let records = recfile(read("../test.rec"))

= Recfiles Package Example

This document demonstrates the basic usage of the recfiles package.

== Loading Data

```typst
#import "@preview/recfiles:0.1.0": recfile

#let records = recfile(read("data.rec"))
```

== Basic Record Display

Total records loaded: #records.len()

== Filtering Records by Type

=== People Records
#for record in records.filter(r => "Name" in r and "Age" in r) [
  - *#record.Name* (Age: #record.Age)
    - Email: #record.at("Email", default: "N/A")
    - Department: #record.at("Department", default: "N/A")
]

=== Project Records  
#for record in records.filter(r => "Title" in r and "Status" in r) [
  - *#record.Title*
    - Status: #record.Status
    - Budget: #record.at("Budget", default: "N/A")
    - Owner: #record.at("Owner", default: "Unassigned")
]

== Working with Multi-value Fields

=== Meetings with Multiple Attendees
#for record in records.filter(r => "Attendees" in r) [
  *#record.Title*
  
  Attendees:
  #if type(record.Attendees) == array [
    #for attendee in record.Attendees [
      - #attendee
    ]
  ] else [
    - #record.Attendees
  ]
]

== Record Statistics

#let person-records = records.filter(r => "Name" in r and "Age" in r)
#let project-records = records.filter(r => "Title" in r and "Status" in r)
#let meeting-records = records.filter(r => "Title" in r and "Date" in r)

- People: #person-records.len()
- Projects: #project-records.len() 
- Meetings: #meeting-records.len()
- Total: #records.len()