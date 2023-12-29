module Series2

import ParseTree;
import IO;
import String;
import Set;
import Map;

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
          '  \"name\": \"Joe\",
          '    \"address\": {
          '     \"street\": \"Wallstreet\",
          '     \"number\": 102
          '  }
          '}
          ");    

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


set[str] propNames2(start[JSON] json) {
  set[str] names = {};
  visit (json) {
    case String s: {
      names = names + "<s>";
    }
  }
   return names;
}

// define a recursive transformation mapping JSON to map[str,value] 
// - every Value constructor alternative needs a 'transformation' function
// - define a data type for representing null;

data Null = null();

// map[str, value] json2map(start[JSON] json) = json2map(json.top);

// map[str, value] json2map((JSON)`<Object obj>`) ;

// map[str, value] json2map((Object)`<Element e>`) = json2map(e);
// map[str, value] json2map((Element)`<String s> : <Value v>`) = map[str, value] ( "<s>" <- json2value(v) ) + json2map(v);

// generics &t





str unquote(str s) = s[1..-1];
int toInt((Number)`str s`) = toInt(s);

value json2value((Value)`<String s>`) = unquote("<s>");
value json2value((Value)`<Number n>`) = toInt(unquote("<n>"));
value json2value((Value)`<Array a>`) = a;
value json2value((Value)`<Boolean b>`) = b;
value json2value((Value)`null`) = null();
default value json2value(Value v) { throw "No tranformation function for `<v>` defined"; }



 // This is an example how to transform the String literal to a value
// value json2value((Value)`<Number n>`)    = toInt(n); // ... This needs to change. The String module contains a function to convert a str to int
// int toInt(str s) throws IllegalArgumentx3;


// test bool example2map() = json2map(example()) == (
//   "age": 42,
//   "name": "Joe",
//   "address" : (
//      "street" : "Wallstreet",
//      "number" : 102
//   )
// );

