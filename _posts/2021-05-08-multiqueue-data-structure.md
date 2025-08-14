---
title: "Multiqueue data structure"
tags: 
  - math
  - youhearditherefirst	
old-link: https://fulldecent.blogspot.com/2021/05/multiqueue-data-structure.html
---

A multiqueue is to a queue as a multisite is to a set. This generic structure might be useful to some programmer somewhere and I haven't seen it in textbooks, so here is an example in Swift.

```swift
// This implementation uses O(N) memory, O(1) enqueue and O(N) dequeue.
// Other implementations with faster dequeue are possible by either
// sacrificing enqueue speed or using more memory.

struct MultiQueue<T> {
    private var elementsAndQuantities: [(element: T, quantity: Int)] = []

    // Quantity must be greater than zero
    mutating func enqueue(_ value: T, quantity: Int) {
        elementsAndQuantities.append((value, quantity))
    }
    
    mutating func dequeue() -> T? {
        guard !elementsAndQuantities.isEmpty else {
            return nil
        }
        let retval = elementsAndQuantities[0].element
        if elementsAndQuantities[0].quantity == 1 {
            elementsAndQuantities.removeFirst()
        } else {
            elementsAndQuantities[0].quantity -= 1
        }
        return retval
    }
}
```
