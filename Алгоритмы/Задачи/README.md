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