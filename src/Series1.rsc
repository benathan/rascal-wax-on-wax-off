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
  for ([*left, *right] := aList) {
    print(left);
    print("-");
    println(right);
  }
  
  // print all partitions of a set
  set[int] aSet = {1,2,3,4,5};
  for ({*left, *right} := aSet) {
    println(left);
  }
}
 
 
/*
 * Trees
 * - complete the data type ColoredTree with
 *   constructors for binary red and black branches
 * - use the exampleTree() to test in the console
 */
data ColoredTree
  = leaf(int n)
  | red(ColoredTree left, ColoredTree right) 
  | black(ColoredTree left, ColoredTree right);


ColoredTree exampleTree()
  =  red(black(leaf(1), red(leaf(2), leaf(3))),
              black(leaf(4), leaf(5)));  

  
// write a recursive function summing the leaves
// (use switch or pattern-based dispatch)
int sumLeaves(ColoredTree t) {
  for (leaf(int n) := t) {
    return n;
  }
  int sum = 0;
  for (red(ColoredTree left, ColoredTree right) := t) {
    sum = sum + sumLeaves(left);
    sum = sum + sumLeaves(right);
  }
  for (black(ColoredTree left, ColoredTree right) := t) {
    sum = sum + sumLeaves(left);
    sum = sum + sumLeaves(right);
  }
  return sum;
}

// same, but now with visit
int sumLeavesWithVisit(ColoredTree t) {
  int sum = 0;
  visit(t) {
    case leaf(int n): sum = sum + n;
  }
  return sum;
}

// same, but now with a for loop and deep match
int sumLeavesWithFor(ColoredTree t) {
  int sum = 0;
  for(/int N := t)
  sum = sum + N;
  return sum;
}

// same, but now with a reducer and deep match
// Reducer = ( <initial value> | <some expression with `it` | <generators> )
int sumLeavesWithReducer(ColoredTree t) {
  return (0 | it + e | /int e := t);
}


// add 1 to all leaves; use visit + =>
ColoredTree inc1(ColoredTree t) {
  return visit (t) {
    case leaf(int n) => leaf(n + 1)
    // case leaf(int n): insert leaf(n+1);
  };
}

// write a test for inc1, run from console using :test
test bool testInc1() = sumLeaves(inc1(exampleTree())) == 20; // 15+5=20

// define a property for inc1, i.e. a boolean
// function that checks if one tree is inc1 of the other
// (without using inc1).
// Use switch on the tupling of t1 and t2 (`<t1, t2>`)
// or pattern based dispatch.
// Hint! The tree also needs to have the same shape!
bool isInc1(ColoredTree t1, ColoredTree t2) {
  for (<red(ColoredTree l1, ColoredTree r1), red(ColoredTree l2, ColoredTree r2)> := <t1, t2>) {
    return isInc1(l1, l2) && isInc1(r1, r2);
  }
  for (<black(ColoredTree l1, ColoredTree r1), black(ColoredTree l2, ColoredTree r2)> := <t1, t2>) {
    return isInc1(l1, l2) && isInc1(r1, r2);
  }
  for (<leaf(int n1), leaf(int n2)> := <t1, t2>) {
    return n1 + 1 == n2;
  }
  return false;
}
 
// write a randomized test for inc1 using the property
// again, execute using :test
test bool testInc1Randomized(ColoredTree t1) = isInc1(t1, inc1(t1));


 

 
  
  
