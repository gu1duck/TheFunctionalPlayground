import UIKit

// Recursive functions

// Easy max (with initial value)
func  max(_ input:[Int], _ initial: Int) -> Int {

    var temp = initial

    if input.count == 0 {
        return initial
    }
    if (input.first! > initial) {
        temp = input.first!
    }
    return max(Array(input.dropFirst()), temp)
}

// Harder Max (no initial value)
func max(_ input:[Int]) -> Int {

    if input.count == 1 {
        return input[0]
    }

    if input[0] > input[1] {
        return max([input[0]] + Array(Array(input.dropFirst()).dropFirst()))
    }
    return max(Array(input.dropFirst()))
}

let myMax = max([1,3,2,5])

myMax

// Take (grab the first X values of the array)

func take(_ number: Int, from input: [Int]) -> [Int] {
    if(number == 0 || input.count == 0) {
        return []
    }
    return [input.first!] + take(number - 1, from: Array(input.dropFirst()))
}

let myTake = take(3, from: [1,2,3,4,5])

// Zip: interweave arrays

func zip(_ array1: [Int], _ array2: [Int] ) -> [Int] {
    if (array1.count  == 0 && array2.count == 0) {
        return []
    }
    if (array1.count == 0) {
        return array2
    }
    if (array2.count == 0) {
        return array1
    }
//    return [array1.first!] + zip(array2, Array(array1.dropFirst()))
    return [array1.first!, array2.first!] + zip(Array(array1.dropFirst()), Array(array2.dropFirst()))
}

let myZip = zip([1,2,3],[7,8,9])

// High-order functions: map, filter and reduce

let myArray = [1,2,3,4,5]

// Map: apply the supplied function to each element

let myMappedArray = myArray.map { $0 + 1 }

myMappedArray

// Filter: use a boolean test to filter out some elements

 let myFilteredArray = myArray.filter { $0 % 2 == 0 }

myFilteredArray

 let myOtherFilteredArray = myArray.filter { $0 % 2 == 0 }

myOtherFilteredArray

let myReducedArray = myArray.reduce(0, {
    if $0 > $1 {
        return $0
    }
    return $1
})

myReducedArray

// We can also concatinate these — so functional, much stateless!

let myMappedAndFilteredArray = myArray.map{ $0 + 1 }.filter{ $0 % 2 == 0 }

myMappedAndFilteredArray

// Our functionalish stack — again, very stateless

struct Stack<T> {
    let values: [T]

    init(_ values: [T]) {
        self.values = values
    }

    func pushing(_ value: T) -> Stack {
        return Stack([value] + values)
    }

    func pop() -> (T?, Stack) {
        return (values.first, Stack(Array(values.dropFirst())))
    }
}

let firstStack = Stack([])
let secondStack = firstStack.pushing(5).pushing(6).pushing(7)

secondStack.values

let popped = secondStack.pop()

popped.0
popped.1.values

// Map can apply to basically any container that has been instructed to work with it (functor) — including optionals

let value: Int? = nil

let modifiedValue = value.map{$0 + 1}

modifiedValue

// If we are dealing with containers of containers, we need containers that know how to deal with that kind of context (monads) — then we can faltMap them

let optionalArray: [Int?] = [1,2,3,nil,5]

let toFlatten = [[1,2,3],[4,5,6], optionalArray]

let flattened = toFlatten.flatMap {$0}

let flattenedAgain = flattened.flatMap{$0}

print(flattened)
print(flattenedAgain)

// (poor, unfinished) RPN calculator demo:


// (1 + (1 + 2)) * 3 ==== 1 1 2 + + 3 *


// Array<T> == [T]
// let array = [String]()
// let array = Array<String>()

// let optional: String?
// let optional: Optional<String>

//The algorithm for evaluating any postfix expression is fairly straightforward:
//
//While there are input tokens left
//Read the next token from input.
//If the token is a value
//Push it onto the stack.
//Otherwise, the token is an operator (operator here includes both operators and functions).
//It is already known that the operator takes n arguments.
//If there are fewer than n values on the stack
//(Error) The user has not input sufficient values in the expression.
//Else, Pop the top n values from the stack.
//Evaluate the operator, with the values as arguments.
//Push the returned results, if any, back onto the stack.
//If there is only one value in the stack
//That value is the result of the calculation.
//Otherwise, there are more values in the stack

//struct RPNCalc {
//
//    var stack: Stack<Int>
//
//    init(stack: Stack<Int>) {
//        self.stack = stack
//    }
//
//    mutating func solve(_ input:[String]) -> Int {
//        if input.count == 0 {
//            return 0
//        }
//        if input.count == 1 {
//            return Int(input[0])!
//        }
//        stack = stack.pushing(Int(input[0])!)
//
//
//    }
//}
