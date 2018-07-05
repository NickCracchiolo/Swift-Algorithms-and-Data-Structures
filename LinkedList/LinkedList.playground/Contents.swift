//: Playground - noun: a place where people can play

import Foundation

var list = LinkedList<Int>(startingItem: 1)

list.printList()

list.addFirst(item: 2)

list.printList()

list.addLast(item: 3)

list.printList()

print(list.endIndex)
print(list.startIndex)

list.remove(atIndex: list.endIndex)

print(list.endIndex)


