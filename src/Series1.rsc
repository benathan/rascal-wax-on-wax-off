module Series1

import IO;
import List;

/*
 * Documentation: https://www.rascal-mpl.org/docs/GettingStarted/
 */

/*
 * Hello world
 *
 * - Import IO, write a function that prints out Hello World!
 * - open the console (click "Import in new Rascal Terminal")
 * - import this module and invoke helloWorld.
 */
 
void helloWorld() {
  println("Hello Word");
} 


/*
 * FizzBuzz (https://en.wikipedia.org/wiki/Fizz_buzz)
 * - implement imperatively
 * - implement as list-returning function
 */
 
void fizzBuzzImp() {
  for (int n <- [1..100]) {
    if (n % 15 == 0) {
      println("FizzBuzz");
    } else if (n % 3 == 0) {
      println("Fizz");
    } else if (n % 5 == 0) {
        println("Buzz");
    } else {
        println(n);
    }
  }
}

list[str] fizzBuzzList() {
  return fizzBuzzHelper([], 1);
}

list[str] fizzBuzzHelper(list[str] l, int n) {
  if (n == 100) {
    return l;
  } else if (n % 15 == 0) {
    return fizzBuzzHelper(l + ["FizzBuzz"], n + 1);
  } else if (n % 3 == 0) {
    return fizzBuzzHelper(l + ["Fizz"], n + 1);
  } else if (n % 5 == 0) {
    return fizzBuzzHelper(l + ["Buzz"], n + 1);
  } else {
    return fizzBuzzHelper(l + ["<n>"], n + 1);
  }
}



list[value] fizzBuzzLoop() {
  result = [];
  for (int n <- [1..100]) {
    if (n % 15 == 0) {
      result += ["FizzBuzz"];
    } else if (n % 3 == 0) {
      result += ["Fizz"];
    } else if (n % 5 == 0) {
      result += ["Buzz"];
    } else {
      result += [n];
    }
  }
  return result;
}

/*
 * Factorial
 * - first using ordinary recursion
 * - then using pattern-based dispatch 
 *  (complete the definition with a default case)
 */
default int factorial(int n) {
  switch (n) {
    case 0: return 1;
    default: return n * factorialP(n - 1);
  }
}

int factorialP(0) = 1;
int factorialP(1) = 1;

default int factorialP(int n) {
  return n * factorialP(n-1);
}


/*
 * Comprehensions
 * - use println to see the result
 */
 
void comprehensions() {
  // construct a list of squares of integer from 0 to 9 (use range [0..10])
  list[int] squares = [n * n | n <- [0..10]];
  println(squares);
  
  // same, but construct a set
  set[int] squares2 = {n * n | n <- [0..10]};
  println(squares);
  
  // same, but construct a map
  map[int, int] squares3 = (n : n * n | n <- [0..10]);
  println(squares);

  // construct a list of factorials from 0 to 9
  list[int] factorials = [factorial(n) | n <- [0..10]];
  println(factorials);

  // same, but now only for even numbers
  list[int] factorialsEven = [factorial(n) | n <- [0..10], n % 2 == 0];
  println(factorialsEven);
}
 

/*
 * Pattern matching
 * - fill in the blanks with pattern match expressions (using :=)
 */
 

void patternMatching() {
  str hello = "Hello World!";
  
  
 
  // print all splits of list
  list[int] aList = [1,2,3,4,5];
  for ([] := aList) {
    ;
  }
  
  // print all partitions of a set
  set[int] aSet = {1,2,3,4,5};
  for ({} := aSet) {
    ;
  } 
}  
 
 
 
/*
 * Trees
 * - complete the data type ColoredTree with
 *   constructors for binary red and black branches
 * - use the exampleTree() to test in the console
 */
 
data ColoredTree
  = leaf(int n);
  

ColoredTree exampleTree()
  =  red(black(leaf(1), red(leaf(2), leaf(3))),
              black(leaf(4), leaf(5)));  
  
  
// write a recursive function summing the leaves
// (use switch or pattern-based dispatch)

int sumLeaves(ColoredTree t) = 0; // TODO: Change this!

// same, but now with visit
int sumLeavesWithVisit(ColoredTree t) {
  return -1; // <- replace
}

// same, but now with a for loop and deep match
int sumLeavesWithFor(ColoredTree t) {
  return -1; // <- replace 
}

// same, but now with a reducer and deep match
// Reducer = ( <initial value> | <some expression with `it` | <generators> )
int sumLeavesWithReducer(ColoredTree t) = 0; // TODO: Change this!


// add 1 to all leaves; use visit + =>
ColoredTree inc1(ColoredTree t) {
  return leaf(-1); // <- replace 
}

// write a test for inc1, run from console using :test
test bool testInc1() = false;

// define a property for inc1, i.e. a boolean
// function that checks if one tree is inc1 of the other
// (without using inc1).
// Use switch on the tupling of t1 and t2 (`<t1, t2>`)
// or pattern based dispatch.
// Hint! The tree also needs to have the same shape!
bool isInc1(ColoredTree t1, ColoredTree t2) {
  return false; // <- replace
}
 
// write a randomized test for inc1 using the property
// again, execute using :test
test bool testInc1Randomized(ColoredTree t1) = false;


 

 
  
  
