# Composite

Вы задумывались как много в нашей жизни древовидных структур? Начиная собственно с самих деревьев и заканчивая структурами компаний. Да ладно, даже,  компаний – целые страны используют древовидные структуры чтобы построить власть.

Во главе компании или страны частенько стоит один человек, у него есть с 10 помошников. У них тоже есть с десяток помошников, и так далее… Если нарисовать их отношения на листе бумаги – увидим дерево!
Очень часто, и мы используем такие типы даных, которые лучше всего храняться в древовидной структуре. Возьмите к примеру стандартный UI: в начале у нас есть View, в нем находяться Subview, в которых могут быть или другие View, или все такие компоненты. Та же самая структура:)

Именно для хранения таких типов данных, а вернее их организации, используется паттерн – Composite или Компоновщик.

### **Когда использовать такой паттерн?**

Собственно когда вы работаете с древовидными типами данных, или хотите отобразить иерархию даных таким образом.
Давайте разберем более детально структуру:
В начале всегда есть контейнер в котором находятся все остальные объекты. Контейнер может хранить как другие контейнеры – ветки нашего дерева, так и объекты которые контейнерами не являюстся – листья нашего дерева. Не сложно представить, что контейнеры второго уровня могут хранить как другие контейнеры, так и листья.
Давайте пример!
Начнем с создания протокола для наших объектов:

```swift
protocol CompositeObjectProtocol {
    func getData() -> String
    func addComponent(aComponent: CompositeObjectProtocol)
}

class Leaf: CompositeObjectProtocol {
    var leafValue: String = ""
    
    func getData() -> String {
        return "Leaf value: \(leafValue)"
    }
    
    func addComponent(aComponent: CompositeObjectProtocol) {
        print("Это листок дерева. К нему добавить ветку не могу")
    }
}
```
Как видим наш объект не может добавлять себе детей (ну он же не контейнер:) ), и может возвращать свое значение с помощью метода getData.

Теперь нам очень необходим контейнер:
```swift
class Container: CompositeObjectProtocol {
    var components = [CompositeObjectProtocol]()
    
    func addComponent(aComponent: CompositeObjectProtocol) {
        self.components.append(aComponent)
    }
    
    func getData() -> String {
        var valueToReturn = "\n<ContainerValues>\n"
        
        for obj in components {
            valueToReturn.appendContentsOf(obj.getData())
        }
        
        valueToReturn.appendContentsOf("\n</ContainerValues>")
        
        return valueToReturn
    }
}
```
Как видим, наш контейнер может добавлять в себя детей, которые могут быть как типа Container так и типа Leaf. Метод getData бегает по всем объектам в массиве components, и вызывает тот же самый метод в детях. Вот собственно и все.
Теперь, конечно же пример:
```swift
let rootContainer = Container()
let leaf1 = Leaf()
leaf1.leafValue = "level1 value"
rootContainer.addComponent(leaf1)

let firstLevelContainer1 = Container()
let leaf2 = Leaf()
leaf2.leafValue = "level2 value1"
firstLevelContainer1.addComponent(leaf2)
rootContainer.addComponent(firstLevelContainer1)

let firstLevelContainer2 = Container()
let leaf3 = Leaf()
leaf3.leafValue = "level2 value2"
firstLevelContainer2.addComponent(leaf3)
rootContainer.addComponent(firstLevelContainer2)

print(rootContainer.getData())

//console:
<ContainerValues>
Leaf value: level1 value
<ContainerValues>
Leaf value: level2 value1
</ContainerValues>
<ContainerValues>
Leaf value: level2 value2
</ContainerValues>
</ContainerValues>
```
В корневом контейнере содержится один лист и две ветки, которые содержат по одному листу. Именно это и отражает наш лог.
