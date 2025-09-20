#import "../lib.typ": recfile

// Advanced filtering and processing example
#let employees = recfile(read("employees.rec"))

= Employee Directory

== All Employees

#table(
  columns: 4,
  [*Name*], [*Department*], [*Age*], [*Skills*],
  ..employees.map(emp => (
    emp.Name,
    emp.at("Department", default: "N/A"),
    emp.at("Age", default: "N/A"),
    if "Skills" in emp {
      if type(emp.Skills) == array {
        emp.Skills.join(", ")
      } else {
        emp.Skills
      }
    } else {
      "None listed"
    }
  )).flatten()
)

== Department Breakdown

#let departments = employees.map(emp => emp.at("Department", default: "Unknown")).dedup()

#for dept in departments [
  === #dept
  
  #let dept-employees = employees.filter(emp => emp.at("Department", default: "Unknown") == dept)
  
  Average age: #calc.round(dept-employees.map(emp => int(emp.at("Age", default: "0"))).sum() / dept-employees.len(), digits: 1)
  
  Team members:
  #for emp in dept-employees [
    - #emp.Name (#emp.at("Age", default: "?")) - #emp.at("Email", default: "No email")
  ]
]

== Skills Analysis

#let all-skills = employees.filter(emp => "Skills" in emp).map(emp => {
  if type(emp.Skills) == array {
    emp.Skills
  } else {
    (emp.Skills,)
  }
}).flatten().dedup().sorted()

Most common skills across the team:
#for skill in all-skills [
  - *#skill*: #employees.filter(emp => {
    if "Skills" in emp {
      if type(emp.Skills) == array {
        skill in emp.Skills
      } else {
        emp.Skills == skill
      }
    } else {
      false
    }
  }).len() people
]