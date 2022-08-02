#!/usr/bin/env yamlscript

use: YS-TestYAMLScript

# Define function main/test1
test1():
- pass: Function test1 defined globally

main():
- test1: []     # Call test1

# - test2():      # Define function test2
#   - pass: Function test2 defined with 'test2():\ ...'
# - test2:        # Call test2

# Define a function with fn and assign to var test3
- def:
  - test3
  - fn:
    - []
    - pass: Function test3 defined with (def f (fn [] ...))
- test3:        # Call test3

# Define a function with defn
- defn:
  - test4
  - []
  - pass: Function test4 defined with (defn f [] ...)
- test4:        # Call test4
