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

## Merge Sort
 Производительность сортировки делением O(n logn)

```swift
func merge(arr1: [Int], arr2: [Int]) -> [Int] {
    var arr1Index = 0
    var arr2Index = 0
        
    var sortedSublist = [Int]()
    
    while arr1Index < arr1.count && arr2Index < arr2.count {
        if arr1[arr1Index] < arr2[arr2Index] { 
            sortedArray.append(arr1[arr1Index])
            arr1Index += 1
        } else if arr1[arr1Index] > arr2[arr2Index] {
            sortedArray.append(arr2[arr2Index])
            arr2Index += 1
        } else {
            sortedArray.append(arr1[arr1Index])
            arr1Index += 1
            sortedArray.append(arr2[arr2Index])
            arr2Index += 1
            
        }
    }

    while arr1Index < arr1.count {
        sortedArray.append(arr1[arr1Index])
        arr1Index += 1
    }
    while arr2Index < arr2.count {
        sortedArray.append(arr2[arr2Index])
        arr2Index += 1
    }
    
    return sortedArray
}


func mergeSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    let cutIndex = array.count / 2
    
    let arr1 = mergeSort(Array(array[0..<cutIndex]))
    let arr2 = mergeSort(Array(array[cutIndex..<array.count]))
    
    return merge(arr1: arr1, arr2: arr2)
}
```

## Quick Sorting
Самый быстрый из представленных

 Производительность быстрой сортировки O(n logn)
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
