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
  foo(validIntegers: integer[]) {
   return this.numbers.any(num => validIntegers.contains(num));
  }
  
  # foo can be called as foo(5) which will be implicitly invoked as foo([5])  
  ```
