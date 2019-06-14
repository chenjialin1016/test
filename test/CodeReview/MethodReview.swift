//
//  MethodReview.swift
//  test
//
//  Created by  on 2019/6/4.
//  Copyright © 2019年 . All rights reserved.
//

import Foundation

//函数重构

//MARK:===========1、Extract Method 提取函数
/*1、Extract Method 提取函数------将大函数按模块拆分成几个小函数
 
 现象：一段代码可以被组织在一起并独立出来
 解决方案：将这段代码放进一个独立的函数中，并让函数名解释该函数的用途
 使用Extract Method：把一段代码从原函数中提取出来，放进一个单独函数里，这与inline Method 相反：将一个函数调用动作替换为该函数本体
 */
//--------------------------重构前--------------------------
/*
class MyCustomer {
    let name : String
    let orders : [Int]

    init(_ name : String, _ orders : [Int]) {
        self.name = name
        self.orders = orders
    }

    func printOwing(){
        //print banner
        print("**************************************")
        print("*********   Custome Owes  ************")
        print("**************************************")

        var outstanding : Int = 0
        for order in orders{
            outstanding += order
        }

        //print detail
        print("name : \(self.name)")
        print("amount : \(outstanding)")
    }
}
 */
//--------------------------重构后--------------------------
class MyCustomer {
    let name : String
    let orders : [Int]
    
    init(_ name : String, _ orders : [Int]) {
        self.name = name
        self.orders = orders
    }
    
    func printOwing(){
        printBanner()
        printDetail(getOutstanding())
        
    }
    func printBanner(){
        print("**************************************")
        print("*********   Custome Owes  ************")
        print("**************************************")
    }
    func printDetail(_ outstanding : Int){
        //print detail
        print("name : \(self.name)")
        print("amount : \(outstanding)")
    }
    func getOutstanding()->Int{
        var result : Int = 0
        for order in orders{
            result += order
        }
        return result
    }
}

//MARK:===========2、Inline Method 内联函数
/*2、Inline Method 内联函数------将微不足道的小函数进行整合
 
 现象：对模块过度进行了封装，即使用 extract method 过头
 解决方案：使用 inline method进行中和，将没有必要过度封装的函数放回去
 */
//MARK:===========3、Replace Temp with Query 以查询取代临时变量
/*3、Replace Temp with Query 以查询取代临时变量------将一些临时变量使用函数替代
 
 现象：在应用程序中，以一个临时变量保存某一个表达式的运算结果
 解决方案：将这个表达式提炼到一个独立的函数中，将这个临时变量的所有引用点替换为对新函数的调用，此后，新函数可以被其他函数使用
 */
//--------------------------重构前--------------------------
/*
class Product{
    var quantity : Int
    var itemPrice : Double
    init(_ quantity : Int, itemPrice : Double) {
        self.quantity = quantity
        self.itemPrice = itemPrice
    }

    func getPrice()->Double{
        let basePrice : Double = Double(self.quantity)*self.itemPrice

        var discountFactor : Double = 1
        if basePrice > 1000 {
            discountFactor = 0.95
        }else{
            discountFactor = 0.98
        }
        return basePrice * discountFactor
    }
}
 */
//--------------------------重构后--------------------------
class Product{
    var quantity : Int
    var itemPrice : Double
    init(_ quantity : Int, itemPrice : Double) {
        self.quantity = quantity
        self.itemPrice = itemPrice
    }
    
    func getPrice()->Double{
        return getBasePrice() * getDiscountFactor()
    }
    func getBasePrice()->Double{
        return Double(self.quantity)*self.itemPrice
    }
    func getDiscountFactor()->Double{
        if getBasePrice() > 1000{
            return 0.95
        }else{
            return 0.98
        }
    }
}


//MARK:===========4、Inline Temp 内联临时变量
/*4、Inline Temp 内联临时变量------与Replace Temp with Query相反
 
 现象：使用replace temp with query 规则使用过度
 解决方案：使用inline temp修正
 */

//MARK:===========5、Introduce Explaining Variable 引入解释性变量
/*5、Introduce Explaining Variable 引入解释性变量------将复杂的表达式拆分成多个变量
 
 现象：函数中含有一个复杂的表达式
 解决方案：将复杂表达式（或其中一部分）的结果放进一个临时变量，以此变量名称来解释表达式用途
 */
//--------------------------重构前--------------------------
/*
 class Product1{
    var quantity : Int
    var itemPrice : Double
    init(_ quantity : Int, itemPrice : Double) {
        self.quantity = quantity
        self.itemPrice = itemPrice
    }
    
    func getPrice()->Double{
         return quantity * itemPrice - max(0, quantity-500)*itemPrice*0.05+min(quantity*itemPrice*0.1, 100)
    }
}
 */
//--------------------------重构中--------------------------
/*
//1、表达式使用临时变量代替，，Introduce Explaining Variable(引入解释性变量)
class Product1{
    var quantity : Int
    var itemPrice : Double
    init(_ quantity : Int, itemPrice : Double) {
        self.quantity = quantity
        self.itemPrice = itemPrice
    }

    func getPrice()->Double{

        let basePrice : Double = Double(quantity)*itemPrice         //基础价格
        let quantityDiscount : Double = max(0, Double(quantity)-500)*itemPrice*0.05                     //折扣
        let shipping : Double = min(basePrice*0.1, 100)              //运费
        return basePrice - quantityDiscount+shipping
    }
}
 */
//--------------------------重构后--------------------------
//2、Replace Temp with Query 以查询代替临时变量  &  Extract Method 提取函数
class Product1{
    var quantity : Int
    var itemPrice : Double
    init(_ quantity : Int, itemPrice : Double) {
        self.quantity = quantity
        self.itemPrice = itemPrice
    }
    
    func getPrice()->Double{
        
        return basePrice() - quantityDiscount() + shipping()
    }
    func basePrice()->Double{
        return Double(self.quantity)*self.itemPrice
    }
    func quantityDiscount()->Double{
        return max(0, Double(quantity)-500)*itemPrice*0.05               //折扣
    }
    func shipping()->Double{
        return min(basePrice()*0.1, 100)
    }
}

//MARK:===========6、Split Variable 分解临时变量
/*6、Split Variable 分解临时变量------一心不可二用
 
 现象：在程序中一个临时变量被多次赋值
 解决方案：针对每次赋值，创建一个独立、对应的临时变量
 */
//--------------------------重构前--------------------------
/*
 func splitTemp(){
     var temp : String = "AAA"
     print(temp)
 
     temp = "BBB"
     print(temp)
 
 }
 */
//--------------------------重构后--------------------------
func splitTemp(){
    let aaa : String = "AAA"
    print(aaa)
    
    let bbb : String = "BBB"
    print(bbb)
}

//MARK:===========7、Remove Assignments to Parameters
/*7、Remove Assignments to Parameters------移除对参数的赋值
 
 现象：代码对一个函数的参数进行了赋值
 解决方案：以一个临时变量取代该参数的位置
 */
//--------------------------重构前--------------------------
/*
 func discount( inputVal : inout Int, quantity : Int, yearToDate : Int)->Int{
    if inputVal > 50 {
        inputVal -= 2
    }
    if quantity > 100 {
        inputVal -= 1
    }
    if yearToDate > 5000{
        inputVal -= 3
    }
    return inputVal
 }
 */
//--------------------------重构后--------------------------
func discount( inputVal : inout Int, quantity : Int, yearToDate : Int)->Int{
    var result = inputVal
    if inputVal > 50 {
        result -= 2
    }
    if quantity > 100 {
        result -= 1
    }
    if yearToDate > 5000{
        result -= 3
    }
    return result
    
}

//MARK:===========8、Replace Method with Method Object
/*8、Replace Method with Method Object------以函数对象取代函数
 
 现象：对应大型函数，其中对局部变量的使用使你无法采用 extract method
 解决方案：将函数放入一个单独的对象中，将局部变量变成该单独对象的属性，然后就可以对该函数使用extract method了
 */
//--------------------------重构前--------------------------
/*
class Account{
    func discount( inputVal : inout Int, quantity : Int, yearToDate : Int)->Int{
        let importValue1 = inputVal*quantity+10
        var importValue2 = inputVal*yearToDate+100
        if (yearToDate - importValue1) > 100 {
            importValue2 -= 2
        }
        let importValue3 = importValue2*8
        
        return importValue3 - 2*importValue1
    }
}
 */
//--------------------------重构中--------------------------
/*
class Account{
    func discount( inputVal : inout Int, quantity : Int, yearToDate : Int)->Int{
        return Discount(self, inputVal, quantity, yearToDate).compute()
    }
}
//1、常见函数对象，将代码进行转移，并在原类中进行委托
class Discount {
    private let account : Account
    
    private var inputVal : Int
    private var quantity : Int
    private var yearToDate : Int
    private var importValue1 : Int = 0
    private var importValue2 : Int = 0
    private var importValue3 : Int = 0
    
    init(_ account : Account, _ inputVal : Int, _ quantity : Int, _ yearToDate : Int) {
        self.account = account
        self.inputVal = inputVal
        self.quantity = quantity
        self.yearToDate = yearToDate
    }
    
    func compute()->Int{
        importValue1 = inputVal*quantity+10
        importValue2 = inputVal*yearToDate+100
        if (yearToDate - importValue1) > 100 {
            importValue2 -= 2
        }
        importValue3 = importValue2*8
        
        return importValue3 - 2*importValue1

    }
}
*/
//--------------------------重构后--------------------------
/*
 //2、extract method 提取方法
class Account{
    func discount( inputVal : inout Int, quantity : Int, yearToDate : Int)->Int{
        return Discount(self, inputVal, quantity, yearToDate).compute()
    }
}
class Discount {
    private let account : Account
    
    private var inputVal : Int
    private var quantity : Int
    private var yearToDate : Int
    private var importValue1 : Int = 0
    private var importValue2 : Int = 0
    private var importValue3 : Int = 0
    
    init(_ account : Account, _ inputVal : Int, _ quantity : Int, _ yearToDate : Int) {
        self.account = account
        self.inputVal = inputVal
        self.quantity = quantity
        self.yearToDate = yearToDate
    }
    
    func compute()->Int{
        //2、extract method 提取方法
        return getResult()
    }
    func countImportValue1(){
        importValue1 = inputVal*quantity+10
    }
    func countImportValue2(){
        importValue2 = inputVal*yearToDate+100
        if (yearToDate - importValue1) > 100 {
            importValue2 -= 2
        }
        
    }
    func countImportValue3(){
        importValue3 = importValue2*8
    }
    func getResult()->Int{
        
        countImportValue1()
        countImportValue2()
        countImportValue3()
        return importValue3 - 2*importValue1
    }
}
*/

//--------------------------重构完成--------------------------
class Account{
    func discount( inputVal : inout Int, quantity : Int, yearToDate : Int)->Int{
        return Discount(self, inputVal, quantity, yearToDate).compute()
    }
}
//3、replace temp with query 用函数取代临时变量
class Discount {
    private let account : Account
    
    private var inputVal : Int
    private var quantity : Int
    private var yearToDate : Int
    private var importValue1 : Int = 0
    private var importValue2 : Int = 0
    private var importValue3 : Int = 0
    
    init(_ account : Account, _ inputVal : Int, _ quantity : Int, _ yearToDate : Int) {
        self.account = account
        self.inputVal = inputVal
        self.quantity = quantity
        self.yearToDate = yearToDate
    }
    
    func compute()->Int{
        return getResult()
    }
    func countImportValue1()->Int{
        return inputVal*quantity+10
    }
    func countImportValue2()->Int{
        var result = inputVal*yearToDate+100
        if (yearToDate - countImportValue1()) > 100 {
            result -= 2
        }
        return result
        
    }
    func countImportValue3()->Int{
        return countImportValue2()*8
    }
    func getResult()->Int{
        return countImportValue3() - 2 * countImportValue1()
    }
    
}
