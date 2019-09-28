# typhon
A repo for the typhon programming language


## features
* python-like whitespace-based scoping
* TypeScript-like structural typing
* `has` keyword for composition over inheritance:

  ```
  function myFunc<T has('myParser') IMyParser>(x: T):
      # x.myParser has type 'IMyParser' with auto-complete support
      # this is effectively shorthand for TypeScript-like 'T extends { myParser: IMyParser }'
  ```
* auto-boxing of elements into singleton arrays to match function signature
  
  ```
  foo(validIntegers: integer[]):
      return this.numbers.any(num => validIntegers.contains(num));    
      # foo can be called as foo(5) which will be implicitly invoked as foo([5])  
  ```
  
* angular-style dependency injection in class constructors

  ```
  class myClass:
      constructor(private myParser: IMyParser, public displaySetter: DisplaySetter)
      
      # rest of the class can use self.myParser etc.
  ```

* Uniform Method Call Syntax as seen in Nim, D (possibly only if the first argument is named 'self' as in python classes
