#!/bin/bash

assert() {
  expected="$1"
  input="$2"

  ./9cc "$input" > tmp.s
  cc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 0 0
assert 42 42
assert 21 "5+20-4"
# assert 22 " 5 + 21 - 4"
# assert 41 " 12 + 34 - 5"
# assert 41 "foo"
assert 47 '5 +6*7'
assert 15 '5*(9-6)'
assert 4 '-3++7'
assert 13 '-3*-6-5'
assert 2 "-2*-1"
echo OK
