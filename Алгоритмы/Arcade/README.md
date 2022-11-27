# Arcade
https://habr.com/ru/post/701822/
## first


 Last-in first-out (LIFO)
 Push and pop are O(1) operations.

```swift
func findMergeInsight(headA: Node?, headB: Node?) -> Int? { // O(n)
   // Figure out which is longer
   // Swap if necessary

    // Calculate d
   // Walk d for longer
   // Walk remainder for both
   let m = length(headA) // O(n)
   let n = length(headB) // O(n)

    let d = m - n
    var currentA = headA
    for _ in 1...d { // O(n)
       currentA = currentA?.next
    }

    var currentB = headB
    for _ in 0...n-1 { // O(n)
        let A = currentA?.data
        let B = currentB?.data
        if A == B {
            return A
        }
        currentA = currentA?.next
        currentB = currentB?.next
    }
    return nil
}
```
