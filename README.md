```
a345120268a9 is a probably turing complete brainfuck inspired language

cells can be any value from -18446744073709551615 to 18446744073709551615, or whatever is the limit for your computer (2^64 or 2^32 usually)

the 'pointer' can be moved anywhere on the tape, either absolutely or relatively. (absolutely meaning, it will move to that cell, relatively meaning, it will go forward/backward that many)

input can be read in 2 ways: plain digit (0), input is a number and is loaded into the cell, or brainfuck (1), the first inputted characters ASCII value is loaded into the cell

all instructions and options:

mp: move pointer
 a: absolute
  set the pointer to $2, regardless of what the cell is or where the pointer is
 r: relative
  add or subtract to the pointer location

rt: read tape
 0:
  print the digit at the cell
 1:
  print the digits of all cells

wt: write tape
 a: absolute
  write a positive or negative number to the cell, regardless of the cells value. equivalent to brainfuck's `[-](++++++ and so on)`
 r: relative
  add or subtract to the cell

bo: bit operation
 and:
  perform `and` operation
 or:
  perform `or` operation
 xor:
  perform `xor` operation

ri: read input
 0:
  read number, write to cell
 1:
  take ASCII of first byte inputted, write to cell

cm: compare
 =:
  check if the cell is equal to $2
 !=:
  check if the cell is not equal to $2
 >:
  check if the cell is greater than $2
 <:
  check if the cell is less than $2

em: extra math
 **:
  raise the cell to the power of $3
 %:
  modulo the cell by $3
 *:
  multiply the cell by $3
 /:
  divide the cell by $3

rb: read binary
 [takes no arguments]:
  print the cells ASCII value as binary (not 00000000-11111111)

pt: print text
 [no defined argument]:
  print $1 (no newline, yes ANSI escape codes)

sv: save value
 tape:
  save all cell values
 pointer:
  save the pointer value

lv: load value
 tape:
  load all cell values
 pointer:
  load pointer value

np: nop
 [takes no arguments]:
  do nothing

cl: call
 [no defined argument]:
  source a bash script

wn: while not
 [no defined arguments]:
  run commands until a condition is met (brainfuck "[]" but for more than 0)
```
