# typhon
A repo for the typhon programming language


## features
* python-like whitespace-based scoping
* TypeScript-like structural typing
* functions declared as lambda expressions and assigned to variables
* `has` keyword for composition over inheritance:

  ```
  function <T has('myParser') IMyParser>myFunc: (T) -> Void =
    (x: T) =>
      # x.myParser has type 'IMyParser' with auto-complete support
      # this is effectively shorthand for TypeScript-like 'T extends { myParser: IMyParser }'
  ```
* auto-boxing of elements into singleton arrays to match function signature
  
  ```
  # inside a class
  foo: (integer[]) -> boolean =
    (validIntegers: integer[]): boolean
      return this.numbers.any((num: integer) =>
        validIntegers.contains(num));    
  # foo can be called as foo(5) which will be implicitly invoked as foo([5])  
  ```
  
* angular-style dependency injection in class constructors

  ```
  class myClass:
      constructor(private myParser: IMyParser, public displaySetter: DisplaySetter)
      
      # rest of the class can use self.myParser etc.
  ```

* Uniform Method Call Syntax as seen in Nim, D (possibly only if the first argument is named 'self' as in python classes)

  ```
  # outside of a class
  <T>findIndicesMatching =
    (self: T[], predicate: (arg: T): boolean) =>
      return self.map((x, i) =>
        return { x, i }).filter(({ x, i }) =>
          return predicate(x)).map(({ x, i }) =>
            return x)

  # can be used as:
  numbers: integer[] = [1, 2, 3, 10, 11]
  matchingIndices = numbers.findIndicesMatching((x: number) =>
    x > 7)
   # or:
   matchingIndicesAgain = findIndicesMatching(numbers, (x: number) =>
    x > 7)
  ```
