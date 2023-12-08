module Series2

import ParseTree;
import IO;
import String;
import Set;

/*
 * Syntax definition
 * - define a grammar for JSON (https://json.org/)
 */
 
start syntax JSON
  = Object;
  
syntax Object
  = "{" {Element ","}* "}"
  ;
  
syntax Element
  = String ":" Value;
  
syntax Value
  = String
  | Number
  | Array
  | Object
  | Boolean
  | Null
  ;

syntax Null
  = "null";
  
syntax Boolean
  = "True"
  | "False"
  ;  

syntax Array
  = "[" {Value ","}* "]"
  ;  
  
lexical String
  = [\"] ![\"]* [\"]; // slightly simplified
  
lexical Number
  = [0] | ([1-9] [0-9]*);

layout Whitespace = [\ \t\n\r]* !>> [\ \t\n\r];

// import the module in the console
start[JSON] example() 
  = parse(#start[JSON], 
          "{
          '  \"age\": 42, 
          '  \"name\": \"Joe\",
          '    \"address\": {
          '     \"street\": \"Wallstreet\",
          '     \"number\": 102
          '  }
<<<<<<< Updated upstream
          '}
          ");    
=======
          '}");
  
Tree testBool() = parse(#Boolean, "True");
Tree testNumber() = parse(#Number, "745");
Tree testString() = parse(#String, "String");
>>>>>>> Stashed changes

// import Parsetree;

Null parseNull() = parse(#Null, "null");
test bool testNull() {
  for (Null := parse(#Null, "null")){
    return true;
  }
  return false;
} 


Boolean parseBool() = parse(#Boolean, "True");
Number parseNumber() = parse(#Number, "745");
Number parseNumberZero() = parse(#Number, "0");
String parseString() = parse(#String, "\"String\"");
Element parseElement() = parse(#Element, "\"String\": 45");
Object parseObject() = parse(#Object, "{\"String\" : 45, \"String\" : 45}");
Array parseArray() = parse(#Array, "[\"String\", 45, null]");
start[JSON] parseJSON() = parse(#start[JSON], "{\"name\": \"Joe\", \"address\": {\"street\": \"Wallstreet\",\"number\": 102}}");


// use visit/deep match to find all element names
// - use concrete pattern matching
// - use "<x>" to convert a String x to str
<<<<<<< Updated upstream


set[str] propNames1(start[JSON] json) {
  set[str] names = {};
  visit (json) {
    case String s: {
      println(s);
      names = names + {s};
      if (str l := names) {
        println(l);
      }
    }
  }
   return names;
}

=======
set[str] propNames(start[JSON] json) {

}
>>>>>>> Stashed changes

// define a recursive transformation mapping JSON to map[str,value] 
// - every Value constructor alternative needs a 'transformation' function
// - define a data type for representing null;

map[str, value] json2map(start[JSON] json) = json2map(json.top);

map[str, value] json2map((JSON)`<Object obj>`)  = json2map(obj);
map[str, value] json2map((Object)`{<{Element ","}* elems>}`) = ( /* Create the map using a comprehension */);

str unquote(str s) = s[1..-1];

value json2value((Value)`<String s>`)    = unquote("<s>"); // This is an example how to transform the String literal to a value
value json2value((Value)`<Number n>`)    = -1; // ... This needs to change. The String module contains a function to convert a str to int
// The other alternatives are missing. You need to add them.

default value json2value(Value v) { throw "No tranformation function for `<v>` defined"; }

// test bool example2map() = json2map(example()) == (
//   "age": 42,
//   "name": "Joe",
//   "address" : (
//      "street" : "Wallstreet",
//      "number" : 102
//   )
// );

