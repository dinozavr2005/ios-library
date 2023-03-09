# Задачи из собеседований

## Бинарный поиск
```swift
func search(_ nums: [Int], _ target: Int) -> Int {
        if nums == [] {
            return -1
        }
        var left = 0, right = nums.count-1
        
        while left <= right {
            let mid = left + (right-left) / 2
            if nums[mid] == target {
                return mid
            }
            
            if target < nums[mid]
            {
                right = mid - 1
            }
            else
            {
                left = mid + 1
            }
        }

        // We didn't find it
        return -1
		}
```
Алгоритм
1) Инициализируем границы пространства поиска как left = 0 и right = nums.count - 1.
2) Если в диапазоне [left, right] есть элементы, находим средний индекс mid = (left + right) / 2 и сравниваем среднее значение nums[mid] с целевым:
- Если nums[mid] = target, возвращаем mid.
- Если nums[mid] < target, пусть left = mid + 1 и повторите шаг 2.
- Если nums[mid] > target, пусть right = mid - 1 и повторите шаг 2.
3) Завершаем цикл, не найдя цель, возвращаем -1.

## Вставка на позицию
```swift
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0, right = nums.count - 1
        
        while left <= right {
            var pivot = left + (right - left) / 2
            if nums[pivot] == target {
                return pivot
            } else if nums[pivot] > target {
                right = pivot - 1
            } else {
                left = pivot + 1
            }
        }
        
        return left
    }
```
Обычно при двоичном поиске мы сравниваем целевое значение со средним элементом массива на каждой итерации.

Если целевое значение равно среднему элементу, работа завершена.

Если целевое значение меньше среднего элемента, продолжаем поиск слева.

Если целевое значение больше среднего элемента, продолжайте поиск справа.

## Возведение массива в квадрат
```swift
     func sortedSquares(_ A: [Int]) -> [Int] {
        return A.map{ $0 * $0 }.sorted()
    }
```

## Двигаем нули
```swift
    func moveZeroes(_ nums: inout [Int]) {
        var writeIdx = 0
        // Move non-zero items
        for num in nums where num != 0 {
            nums[writeIdx] = num
            writeIdx += 1
        }
        
        // Fill the remaining with zero
        for i in writeIdx..<nums.count {
            nums[i] = 0
        }
    }
```

## Длина строки без повторов букв
```swift
func lengthOfLongestSubstring(_ s: String) -> Int {
        
        if s.count == 0{
            return 0
        }else if s.count == 1{
          return 1
        }
        
        var maxLength = 0
        var temp = [Character]()
        let charArray = Array(s)
        temp.append(charArray[0])
        
        for i in 1...charArray.count-1{
            
            if let index = temp.firstIndex(of: charArray[i]){
                temp.removeFirst(index+1)
            }
            temp.append(charArray[i])
            maxLength = max(maxLength, temp.count)
            
        }
        return maxLength
    }
```

## Обобщение диапазонов
```swift
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        if strs.isEmpty { return [] }
        
        var map = [String: [String]]()
        for str in strs {
            let sortedStr = String(str.sorted())
            map[sortedStr, default: []] += [str]
        }
                
        return Array(map.values)
    }
```
Чтобы суммировать диапазоны, нам нужно знать, как их разделить. Массив отсортирован и не имеет дубликатов. В таком массиве два соседних элемента имеют разность либо 1, либо больше 1. Если разность равна 1, их следует поместить в один диапазон, в противном случае - разделить диапазоны.

Нам также необходимо знать начальный индекс диапазона, чтобы поместить его в список результатов. Таким образом, мы храним два индекса, представляющие две границы текущего диапазона. Для каждого нового элемента мы проверяем, расширяет ли он текущий диапазон. Если нет, то мы помещаем текущий диапазон в список.

Не забудьте поместить в список последний диапазон. Это можно сделать либо специальным условием в цикле, либо поместить последний диапазон в список после цикла.

## Пермутация
```swift
     func checkInclusion(_ s1: String, _ s2: String) -> Bool {
            guard s2.count >= s1.count else { return false }
    let chars = Array(s2)
    let countsOfS1 = Array(s1).reduce(into: [:]) { $0[$1, default: 0] += 1 }
    
    var charCountsInSlidingRange = [Character: Int]()
    for i in 0 ..< s2.count {
        
        let indexToRemove = i - s1.count
        if indexToRemove >= 0 {
            let count = charCountsInSlidingRange[chars[indexToRemove]]!
            charCountsInSlidingRange[chars[indexToRemove]] = count > 1 ? count - 1 : nil
        }
        
        charCountsInSlidingRange[chars[i], default: 0] += 1
        if countsOfS1 == charCountsInSlidingRange {
            return true
        }
    }
    return false
    } 
```

## Плохая версия
```swift
func firstBadVersion(_ n: Int) -> Int {
        var left = 1
        var right = n
        var mid = 0
        while left + 1 < right {
            mid = left + (right - mid) / 2
            if isBadVersion(mid) {
                right = mid
            } else {
                left = mid + 1
            }
        }
        if isBadVersion(left) {
            return left
        }
        return right
    }
```

## Прокрутка массива
```swift
    func rotate(_ nums: inout [Int], _ k: Int) {
guard 0 < k else { return }

for _ in (0..<k) {
    nums.insert(nums.removeLast(), at: 0)
        }
    }
```

## Разворот строки
```swift
    func reverseString(_ s: inout [Character]) {
        var lastIndex = s.count - 1
        
        for i in 0 ..< s.count {
            if i > lastIndex {
                break
            }
            
            s.swapAt(i, lastIndex)
            lastIndex -= 1
        }
    }
```

## Разворот односвязного списка
```swift
func reverseList(_ head: ListNode?) -> ListNode? {

    var previous: ListNode? = nil
    var current: ListNode? = head

    while current != nil {
        let nextTmp = current?.next
        current?.next = previous
        previous = current
        current = nextTmp
    }

    return previous
}
```


## Сложить два числа в массиве
```swift
 func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    for index in 0..<nums.count {
        if let found = dict[target - nums[index]] {
            return [found, index]
        } else {
            dict[nums[index]] = index
        }
    }
    return []
    }
```

## Сумма  двух чиселв массиве  
```swift
    guard numbers.count > 1 else {
        return []
    }
    
    var left = 0
    var right = numbers.count - 1
    
    while left < right {
        let sum = numbers[left] + numbers[right]
        if sum == target {
            return [left + 1, right + 1]
        } else if sum > target {
            right -= 1
        } else {
            left += 1
        }
    }
    
    return []
```
## Уникальные повторония цифр в массиве
```swift
    func uniqueOccurrences(_ arr: [Int]) -> Bool {
        var numDict: [Int: Int] = [:]
        for num in arr {
            if let val = numDict[num] {
                numDict[num] = val + 1
            } else {
                numDict[num] = 1
            }
        }
        
        let values = Array(numDict.values)
        return values.count == Set(values).count
    }
}
```
- Сохраните частоты элементов массива arr в хэш-карте numDict.
- Итерация по хэш-карте numDict и вставка частот всех уникальных элементов массива arr в хэш-набор Set.
- Верните true, если размер хэш-набора Set равен размеру хэш-карты numDict, иначе верните false.

## Fizz Buzz
```swift
        func fizzBuzz(_ n: Int) -> [String] {
        var result = [String]()
        for i in 1...n {
            if i % 3 == 0 && i % 5 == 0 {
                result.append("FizzBuzz")
            } else if i % 3 == 0 {
                result.append("Fizz")
            } else if i % 5 == 0 {
                result.append("Buzz")
            } else {
                result.append("\(i)")
            }
        }
          return result
    }
```
- Инициализируйте пустой список ответов.
- Итерация по числам от 1...N1 ... N1...N.
- Для каждого числа, если оно делится и на 3, и на 5, добавьте FizzBuzz в список ответов.
- Иначе, Проверьте, делится ли число на 3, добавьте Fizz.
- Иначе, проверьте, делится ли число на 5, добавьте Buzz.
- Иначе, добавьте число.

## Развернуть строку
```swift
    func reverseString(_ s: inout [Character]) {
        var lastIndex = s.count - 1
        for i in 0..<s.count {
            if i > lastIndex {
                break
            }
            s.swapAt(i, lastIndex)
            lastIndex -= 1
        }
    }
```
```swift
    func reverseString(_ s: inout [Character]) {
        return s.reverse()
    }
```

## Развернуть слова в строке
```swift
    func reverseWords(_ s: String) -> String {
        let array = s.components(separatedBy: " ")
        var result = ""
        for i in 0 ..< array.count {
            result += String(array[i].reversed()) + " "
        }
        result.removeLast()
        return result
    }
```

## Полиндромный связный список

```swift
 func isPalindrome(_ head: ListNode?) -> Bool
    {
        if head == nil {return true}

        var values: [Int] = []
        var reversedValues: [Int] = []
        var head = head

        while head != nil
        {
            if let val = head?.val
            {
                values.append(val)
                reversedValues.insert(val, at: 0)
                head = head?.next
            }
        }
        return values == reversedValues
    }
```



## Поиск анаграмм
```swift
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        if strs.isEmpty { return [] }
        
        var map = [String: [String]]()
        for str in strs {
            let sortedStr = String(str.sorted())
            map[sortedStr, default: []] += [str]
        }
                
        return Array(map.values)
    }
```




## Простое сравнение двух строк
```swift
    func arrayStringsAreEqual(_ word1: [String], _ word2: [String]) -> Bool {
        return word1.joined() == word2.joined()
    }
```

## Середина связного списка
```swift
    func middleNode(_ head: ListNode?) -> ListNode? {
      var middle: ListNode? = head
        var end: ListNode? = head
        
        while end?.next != nil {
            middle = middle?.next
            end = end?.next?.next
        }
        return middle
    }
```

## Удаление n-ой ноды с конца
```swift
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
      var slow = head, fast = head
        for _ in 0..<n {
            fast = fast?.next
        }
        if fast == nil {
            return head?.next
        }
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next
        }
        slow?.next = slow?.next?.next
        return head  
    }
```
Приведенный выше алгоритм может быть оптимизирован до одного прохода. Вместо одного указателя можно использовать два указателя. Первый указатель продвигает список на n+1n+1n+1 шагов от начала, а второй указатель начинает с начала списка. Теперь оба указателя находятся точно на расстоянии nnn узлов друг от друга. Мы поддерживаем это постоянное расстояние, продвигая оба указателя вместе до тех пор, пока первый указатель не окажется за последним узлом. Второй указатель будет указывать на nnn-ый узел, считая от последнего. Мы связываем следующий указатель узла, на который ссылается второй указатель, чтобы он указывал на следующий за ним узел.

## () {} [] true/false
```swift
 func isValid(_ s: String) -> Bool {
        var arr = [Character]()
        for c in s{
            switch c{
                case ")":
                    if arr.isEmpty{ return false }
                    if arr.removeLast() != "(" { return false }
                    break
                case "}":
                    if arr.isEmpty{ return false }
                    if arr.removeLast() != "{" { return false }
                    break
                case "]":
                    if arr.isEmpty{ return false }
                    if arr.removeLast() != "[" { return false }
                    break
                default:
                    arr.append(c)
            }
        }
        return arr.isEmpty
    }   
```

