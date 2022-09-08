# Sorting Algoritmhs

## Bubble Sorting
 Производительность пузырьковой сортировки O(n^2)
```swift
import UIKit

/*
 ___      _    _    _       ___          _
| _ )_  _| |__| |__| |___  / __| ___ _ _| |_
| _ \ || | '_ \ '_ \ / -_) \__ \/ _ \ '_|  _|
|___/\_,_|_.__/_.__/_\___| |___/\___/_|  \__|
 */



class BubbleSort {
    func sort(_ array: [Int]) -> [Int] {
        var arr = array
        let n = arr.count
        for i in 0..<n-1 {
            for j in 0..<n-i-1 {
                if arr[j] > arr[j+1] {
                    // swap
                    let temp = arr[j]
                    arr[j] = arr[j+1]
                    arr[j+1] = temp
                }
            }
        }
        
        return arr
    }
}

let bubbleSort = BubbleSort()
bubbleSort.sort([5, 4, 3, 2, 1])
```
## Quick Sorting
 Производительность пузырьковой сортировки O(n logn)
```swift
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
  guard a.count > 1 else { return a }
 
  let pivot = a[a.count/2]
  let less = a.filter { $0 < pivot }
  let equal = a.filter { $0 == pivot }
  let greater = a.filter { $0 > pivot }
 
  return quicksort(less) + equal + quicksort(greater)
}

let list = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
quicksort(list)

```