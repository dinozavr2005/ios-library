# Arcade
https://habr.com/ru/post/701822/
## Задачи в файле Arcade.swft

примеры задач:
```swift
func findMergeInsight(headA: Node?, headB: Node?) -> Int? { // O(n)
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
