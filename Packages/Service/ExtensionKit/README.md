# ExtensionKit

## Bool 布尔值
Map
* 使用值
```
let foo: Bool = true
print(foo.map(true: "foo", false: "bar")) -> "foo"
```
* 使用函数
```
let foo: Bool = true
let bar: String = foo.map(true: {
    return "foo"
}, false: {
    return "bar"
})
print(bar) -> "foo"
```

---
## Collection 集合

### Collection.Safe
安全模式,数组溢出返回nil

* index

```
let result = ["foo","bar"]
print(result[safe: 2]) -> nil
```
* range
```
let result = ["foo","bar"]
print(result[safe: 0..<3]) -> nil
```
### Collection.Equal
* equal
```
let foo = ["foo", "bar"]
let bar = ["foo", "bar"]
print(foo == bar) -> true
```
---
## Dictonary

### Dictionary.Merge 字典合并
* merging 返回字典
```
let foo: [String: String] = ["foo":"1"]
let bar: [String: String] = ["bar":"2"]
let result = bar.merging(foo)
print(result) -> ["bar": "2", "foo": "1"]
```
* 可变字典使用merge
```
let foo = ["foo":"1"]
var bar = ["bar":"2"]
bar.merge(foo)
print(bar) -> ["bar": "2", "foo": "1"]
```
* 直接使用运算符 +/+=
```
let foo = ["foo":"1"]
let bar = ["bar":"2"]
print(foo+bar) -> ["bar": "2", "foo": "1"]
```

### Dictionary.Flatten 字典
获取非空 value 的字典
* fltterning 返回字典
```
var result = ["bar":"2","foo":nil]
print(result.flattening()) -> ["bar": Optional("2")]
```
* 可变字典使用flatten
```
var result = ["bar":"2","foo":nil]
result.flatten()
print(result) -> ["bar": Optional("2")]
```

## Optional
### Optional.Wrapped
* unwrapped 如果有值返回,没有值返回默认值
```
let foo: String? = nil
print(foo.unwrapped(or: "bar")) -> "bar"

let bar: String? = "bar"
print(bar.unwrapped(or: "foo")) -> "bar"
```
* unwrapped 如果有值返回值,没有就返回错误
```
let foo: String? = nil
try print(foo.unwrapped(or: MyError.notFound)) -> error: MyError.notFound

let bar: String? = "bar"
try print(bar.unwrapped(or: MyError.notFound)) -> "bar"
```
* run 如果有值执行run,没有不执行
```
let foo: String? = nil
foo.run { unwrappedFoo in
    // block不会执行,因为foo是nil
    print(unwrappedFoo)
}

let bar: String? = "bar"
bar.run { unwrappedBar in
    // block会执行,因为bar不是nil
    print(unwrappedBar) -> "bar"
}
```
* ??= 等号右边有值就赋值,nil就不赋
```
let someParameter: String? = nil
let parameters = [String: Any]()
parameters[someKey] ??= someParameter // 不会赋值,因为someParameter为nil
```

* ?= 等号左边有值就不赋值,nil就赋值
```
var someText: String? = nil
let newText = "Foo"
let defaultText = "Bar"
someText ?= newText // someText为"Foo",因为someText在赋值前是nil
someText ?= defaultText // someText不会变,因为someText在赋值前不是nil
```
### Collection
* isNilOrEmpty 如果是nil或者集合内容是空返回true,否则是false
```
var foo: [Any]? = []
print(foo.isNilOrEmpty) -> true
foo?.append(1)
print(foo.isNilOrEmpty) -> false
var bar:[Any]? = nil;
print(bar.isNilOrEmpty) -> true
```
* nonEmpty 集合如果没有值或者为nil时,返回nil
```
var foo: [Any]? = []
print(foo.nonEmpty) -> nil
foo?.append(1)
print(foo.nonEmpty) -> Optional([1])
var bar:[Any]? = nil;
print(bar.nonEmpty) -> nil
```
### 枚举值和常量的直接比较
* swift里 枚举值不能和常量直接比较,ExtensionKit提供该功能
```
enum Flag: Int {
    case foo = 1
    case bar = 2
}
        
print(Flag.foo == 1) -> true
print(Flag.bar == 1) -> false
print(Flag.bar != 1) -> true
```
---
## String
### String.Radix
* 二进制/十进制/十六进制 插值
```
print("\(10, radix: .binary)")
// Prints "1010"
print("\(10, radix: .binary, prefix: true)")
// Prints "ob1010"
print("\(10, radix: .octal)")
// Prints "12"
print("\(10, radix: .decimal)")
// Prints "10"
print("\(10, radix: .hex)")
// Prints "A"
```
* removingPrefix、removingSuffix 移除首部字符串、尾部字符串
```
let result = "bar001foo"
print(result.removingPrefix("bar"))
// Prints "001foo"
print(result.removingSuffix("foo"))
// Prints "bar001"
```
* safe index、range 安全模式取子字符串
```
let result = "bar001foo"
print(result[safe: 0])
// Prints Optional("b")
print(result[safe: 10])
// Prints nil
print(result[safe: 0..<2])
// Prints Optional("ba")
print(result[safe: 0..<10])
// Prints nil
```
* slice 字符串切片 slicing 返回一个新的字符串, slice 可变字符串返回自身
```
var result = "bar001foo"
print(result.slicing(from: 1, length: 2))
// Prints Optional("ar")
result.slice(from: 1, length: 2)
print(result)
// Prints "ar"
```