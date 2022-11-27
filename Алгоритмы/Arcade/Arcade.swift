
import Foundation
import UIKit

class Node {
    var data: Int
    var next: Node?

    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}
func length(_ head: Node?) -> Int {
    if head == nil {
        return 0
    }

    var len = 0
    var current = head
    while current != nil {
        len += 1
        current = current?.next
    }
    return len
}
func printLinkedList(_ head: Node?) {
    if head == nil { return }

    var result = [Int]()
    var node = head
    result.append(node!.data)

    while node?.next != nil {
        result.append(node!.next!.data)
        node = node?.next
    }

    print(result)
}
// Пройти по всем элементам A проверяя элементы B
func findMergeBrute(headA: Node?, headB: Node?) -> Int? { // O(m*n)
    let m = length(headA) // O(m)
    let n = length(headB) // O(n)

    var currentA = headA
// Один луп вложен в другой!
    for _ in 0...m-1 { // O(m)
        var currentB = headB
        for _ in 0...n-1 { // O(n)
            let A = currentA?.data
            let B = currentB?.data
            print("A: \(A ?? 0) B: \(B ?? 0)")
            if A == B {
                return currentA?.data
            }
            currentB = currentB?.next
        }
        currentA = currentA?.next
    }
    return nil
}
// Меняем время на память
func findMergeSpaceTime(headA: Node?, headB: Node?) -> Int? { // O(2m + 2n)

    let m = length(headA) // O(m)
    let n = length(headB) // O(n)
    var dict = [Int?: Bool]()
    var currentB = headB
    for _ in 0...n-1 { // O(n)
        let B = currentB?.data
        dict[B] = true
        currentB = currentB?.next
    }

    var currentA = headA
    for _ in 0...m-1 { // O(m)
        let A = currentA?.data
        if dict[A] == true {
            return A
        }
        currentA = currentA?.next
    }
    return nil
}
// Инсайт: Если мы сможем выстроить массивы в ряд, мы сможем пройтись по ним один раз
func findMergeInsight(headA: Node?, headB: Node?) -> Int? { // O(n + m)
    // Найти какой длинее
    // Поменять местами если надо

    // Посчитать d
    let m = length(headA) // O(m)
    let n = length(headB) // O(n)
    var currentA = headA
       var currentB = headB

       if n > m {
           let temp = currentA
           currentA = currentB
           currentB = temp
       }

       let d = abs(m - n)
       for _ in 1...d { // O(n)
           currentA = currentA?.next
       }

       for _ in 0...n-1 { // O(n)
           print(4)
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
   // 1 2 3 4 5 6
   let node6 = Node(6)
   let node5 = Node(5, node6)
   let node4 = Node(4, node5)
   let node3 = Node(3, node4)
   let node2 = Node(2, node3)
   let node1 = Node(1, node2)
   // 10 11 12 13 4 5 6
   let node11 = Node(11, node4)
   let node10 = Node(10, node11)
   printLinkedList(node1)
   printLinkedList(node10)
   //findMergeBrute(headA: node1, headB: node10)
   //findMergeSpaceTime(headA: node1, headB: node10)
   findMergeInsight(headA: node1, headB: node10)

// Инсайт: Простой
func findMergeInsight(headA: Node?, headB: Node?) -> Int? { // O(n)
    // Посчитать какой длинее
    // поменять если надо местами
    // Посчитать d

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
