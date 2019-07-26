//
//  SwiftTraversalOperation.swift
//  test
//
//  Created by Jialin Chen on 2019/7/9.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

//swift 中的遍历方式总结

func TraversalTest(){
    //MARK:----------for-in循环遍历
    print("for-in 循环遍历")
    /*
     遍历数组
     */
    let swiftArray = ["L", "O", "V", "E", "S", "W", "I", "F", "T"]
    //第一种方式：Swift中普通的for循环语法，在索引index和遍历范围0...6之间用关键字in，这里要注意0...6的表示的范围是：0<= index <= 6，而0..<6表示的是：0<= index < 6，这里要注意的是没有：0<..6的形式
    for index in 0...6{
        print(swiftArray[index])
    }
    for index in 0..<6{
        print(swiftArray[index])
    }
    //拓展1:0...6的形式还可以取出制定范围的数组中的元素
    let selectionArray = swiftArray[0...4]
    print("selectionArray : \(selectionArray)")
    //拓展2:0...6的形式还可以用来初始化创建数组
    let numbers = Array(1...7)
    print("numbers:\(numbers)")
    //第二种方式：不需要索引直接就可以访问到数组中的元素
    for element in swiftArray{
        print(element)
    }
    
    /*
     遍历字典
     */
    let swiftDict = ["1":"one", "2":"two", "3":"three", "4":"four"]
    //同时遍历key和value利用了swift中的元祖
    for (key, value) in swiftDict{
        print("\(key):\(value)")
    }
    //单独遍历字典的key和value
    let keys = swiftDict.keys
    for k in keys{
        print(k)
    }
    let values = swiftDict.values
    for v in values{
        print(v)
    }
    //将字典的keys转换成数组
    let keysArr = Array(swiftDict.keys)
    print("keysArr:\(keysArr[0])")
    
    //MARK:----------for-in 反向遍历
    //在Swift中为了保证程序的稳定，也建议在遍历集合需要修改集合元素时采用反向遍历。
    print("\n for-in 反向遍历")
    //倒序遍历数组
    //无论是0...6这种索引方式还是快速遍历，都可直接调用reversed()函数轻松实现反向遍历
    for index in (0...6).reversed(){
        print(swiftArray[index])
    }
    for element in swiftArray.reversed(){
        print(element)
    }
    //倒序遍历字典
    for (key, value) in swiftDict{
        print("\(key):\(value)")
    }
    //扩展：可以利用reversed()函数得到一个倒序的集合
    let reversedArray = Array(swiftArray.reversed())
    print("reversedArray:",reversedArray)
    
    //MARK:----------forEach 遍历
    /*
     1、不能使用“break”或者“continue”退出遍历；
     2、使用“return”结束当前循环遍历，这种方式只是结束了当前闭包内的循环遍历，并不会跳过后续代码的调用。
     */
    print("\n forEach 遍历")
    //使用forEach 正向遍历
    swiftArray.forEach { (word) in
        print(word)
    }
    
    //使用forEach 反向遍历
    swiftArray.reversed().forEach { (word) in
        print(word)
    }
    
    //MARK:----------stride 遍历
    /*
     stride遍历分为
     stride<T : Strideable>(from start: T, to end: T, by stride: T.Stride)
     和
     stride<T : Strideable>(from start: T, through end: T, by stride: T.Stride)
     
     1、stride单词的含义“大步跨过”，使用这种方式遍历的好处自然是可以灵活的根据自己的需求遍历，比如我们有时需要遍历索引为偶数或者基数的元素，或者每隔3个元素遍历一次等等类似的需求都可以轻松实现
     2、stride遍历同样可以实现正向和反向的遍历，在by后面添加正数表示递增的正向遍历，添加负数表示递减的反向遍历
     3、to和through两种遍历方式的不同在于to不包含后面的索引，而through包含后面的索引，以to: 6和through: 6为例，to：<6或者>6，through：<=6或者>=6，至于是<还是>取决于是正向遍历还是反向遍历。
     */
    //stride 正向遍历
    for index in stride(from: 1, to: 6, by: 1){
        print(index)
        print(swiftArray[index])
    }
    //stride 正向跳跃遍历
    for index in stride(from: 1, to: 6, by: 2){
        print(index)
        print(swiftArray[index])
    }
    
    //stride 反向遍历
    for index in stride(from: 6, to: 1, by: -1){
        print(index)
        print(swiftArray[index])
    }
    
    //stride through 正向遍历
    for index in stride(from: 0, through: 6, by: 1){
        print(index)
        print(swiftArray[index])
    }
    
    //MARK:----------基于块的遍历
    /*
     正向遍历
     1、(n, c)中n表示元素的输入顺序，c表示集合中的每一个元素；2、由于数组是有序的，所以在数组中n自然也可以表示每一个元素在数组中索引，而字典是无序的，但是n依然会按照0、1、2...的顺序输入，因此不可以代表在字典中的索引。
     */
    //遍历数组
    for (index, element) in swiftArray.enumerated(){
        print("\(index) : \(element)")
    }
    //遍历字典
    for (n, c) in swiftDict.enumerated(){
        print("\(n):\(c)")
    }
    /*
     反向遍历
     反向遍历就是直接在enumerated()函数后调用reversed()函数。
     */
    //反向遍历数组
    for (index, element) in swiftArray.enumerated().reversed(){
        print("\(index) : \(element)")
    }
    //反向遍历字典
    for (n, c) in swiftDict.enumerated().reversed(){
        print("\(n):\(c)")
    }
    //MARK:----------一边遍历，一边删除，使用基于块的遍历
    //不通过下标删除数组元素
    var array = swiftArray[0...4]
    print(array)
    //删除“O”
//    array = array.filter { $0 != "O"  }
    print(array)
}

