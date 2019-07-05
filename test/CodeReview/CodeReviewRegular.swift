//
//  CodeReviewRegular.swift
//  test
//
//  Created by  on 2019/6/3.
//  Copyright © 2019年 . All rights reserved.
//

import Foundation

/*
 为什么要重构代码？什情况下需要重构？
 答：代码重构可以改善既有的代码设计，增强既有过程的可扩充性、可维护性。随着需求的不断迭代/更新，所写的代码也在时刻变化，新增的功能模块，可能在下次就不用了，或者需求更新/变更，使原有的方法变得臃肿，以及各个模块的耦合度增加，这些都需要代码重构
 
 什么是重构？
 答：在不改变代码对外的表现的情况下，修改代码的内部特征，即对既有代码的结构进行修改
 */

//代码重构规则

//MARK:---------重构规则
func codeReviewTest(){
    
    //函数重构
    methodReviewTest()
    
    //类重构
    classReviewTest()
    
    //数据重构
    dataReviewTest()
    
    //条件表达式重构
    conditionalExpressionReviewTest()
    
    //继承关系重构
    extendsReviewTest()
    
    //规则完成案例
    completeCaseTest()
}

//MARK:-----------1、函数重构规则-----------
/*
 Extract Method, Inline Method, Inline Temp, Replace Temp with Query, Introduce Explaining Variable, Split Temporary Variable, Remove Assignments to Parameters, Replace Method with Method Object
 */
func methodReviewTest(){
    print("函数重构----Extract Method 提取函数")
    let myCustome : MyCustomer = MyCustomer("zeluli", [10, 20, 30, 40, 50])
    myCustome.printOwing()
    print("\n")
    
    print("函数重构----Replace Temp with Query 以查询取代临时变量")
    let product : Product = Product(1, itemPrice: 1000)
    let price = product.getPrice()
    print(price)
    print("\n")
    
    print("函数重构----Introduce Explaining Variable(引入解释性变量)")
    let product1: Product1 = Product1(1, itemPrice: 1000)
    let price1 = product1.getPrice()
    print(price)
    print("\n")
    
    print("函数重构----Split Temporary Variable 分解临时变量")
    splitTemp()
    print("\n")
    
    print("函数重构----Remove Assignments to Parameters(移除对参数的赋值)")
    var inputval = 50
    let count = discount(inputVal: &inputval, quantity: 200, yearToDate: 5500)
    print(count)
    print("\n")
    
    print("函数重构----Replace Method with Method Object(以函数对象取代函数)")
    let count2 = Account().discount(inputVal: &inputval, quantity: 200, yearToDate: 5500)
    print(count2)
    print("\n")
}


//MARK:-----------2、类重构规则-----------

func classReviewTest(){
    print("类重构----Move Method 方法迁移")
    let bookCustomer = BookCustomer("cjl", true)
    bookCustomer.books.append(Book(0, "book name 1"))
    bookCustomer.books.append(Book(1, "book name 2"))
    bookCustomer.books.append(Book(2, "book name 3"))
    print(bookCustomer.charge())
    print("\n")
    
    print("类重构----Move Class 提炼类")
    let employee : Employee = Employee("cjl", TelPhoneNumber("010", "0123456789"))
    print(employee.getOfficeAreaCode())
    print(employee.getOfficeNumber())
    print("\n")
    
    print("类重构----Inline Class 内联类")
    print("无示例\n")
    
    print("类重构----Hide Delegate 隐藏“委托关系”")
    let scotterManager = People("scott", Department("creditease", nil))
     let cjl = People("cjl", Department("creditease", scotterManager))
//    print("重构前：", cjl.department.manager.name)
    print("重构后：", cjl.getManager().name)
    print("\n")
    
    print("类重构----Introduce Foreign Method 引入外加函数")
    MyTest.method1()
    MyTest.method2()
    print("\n")
}


//MARK:-----------3、数据重构规则-----------
func dataReviewTest(){
    print("数据重构----Self Encapsulate Field 自封装字段")
    var capRange : CappedRange = CappedRange.init(10, 100, 50)
    print(capRange.getHigh())
    print(capRange.include(51))
    print(capRange.include(50))
    print("\n")
    
    print("数据重构----Change Value to Reference 将值对象改变成引用对象")
    /*
     //3个order指向customer，当一个改变时，其他不会改变，出现数据不同步问题
    print("重构前")
    let order1 : Order = Order.init("cjl", idCard: "123456")
    let order2 : Order = Order.init("cjl", idCard: "123456")
    let order3 : Order = Order.init("cjl", idCard: "123456")
    var customer1 = order1.getCustomer()
    withUnsafePointer(to: &customer1) { print("customer1 \($0)") }
    var customer2 = order2.getCustomer()
    withUnsafePointer(to: &customer2) { print("customer2 \($0)") }
    var customer3 = order3.getCustomer()
    withUnsafePointer(to: &customer3) { print("customer3 \($0)") }
    order2.setCustomerName("zeluli")
    print(order1.getCustomerName())
    print(order2.getCustomerName())
    print(order3.getCustomerName())
 */
    /*
    //3个order指向customer，当一个改变时，其他会一起改变，其改变的是不仅仅是模块内部的结构，而且修改了模块的调用方式。也就是说里外都被修改了，这与我们重构所提倡的“改变模块内部结构，而不改变对外调用方式”所相悖
    print("重构中")
    let cjl = Customer.init("cjl", "123456")
    let order1 : Order = Order.init(cjl)
    let order2 : Order = Order.init(cjl)
    let order3 : Order = Order.init(cjl)
    var customer1 = order1.getCustomer()
    withUnsafePointer(to: &customer1) { print("customer1 \($0)") }
    var customer2 = order2.getCustomer()
    withUnsafePointer(to: &customer2) { print("customer2 \($0)") }
    var customer3 = order3.getCustomer()
    withUnsafePointer(to: &customer3) { print("customer3 \($0)") }
    order2.setCustomerName("zeluli")
    print(order1.getCustomerName())
    print(order2.getCustomerName())
    print(order3.getCustomerName())
    */
    //从根本上重构
    print("重构后")
    let order1 : Order = Order.init("cjl", "123456")
    let order2 : Order = Order.init("cjl", "123456")
    let order3 : Order = Order.init("cjl", "123456")
    var customer1 = order1.getCustomer()
    withUnsafePointer(to: &customer1) { print("customer1 \($0)") }
    var customer2 = order2.getCustomer()
    withUnsafePointer(to: &customer2) { print("customer2 \($0)") }
    var customer3 = order3.getCustomer()
    withUnsafePointer(to: &customer3) { print("customer3 \($0)") }
    order2.setCustomerName("zeluli")
    print(order1.getCustomerName())
    print(order2.getCustomerName())
    print(Customer.customers)
    print("\n")
    
    print("数据重构----Change Reference to Value(将引用对象改为值对象)")
    var c1 = Currency("001")
    var c2 = Currency("002")
    print(c1 == c2)
    print(c1 === c2)
    withUnsafePointer(to: &c1) { print("customer1 \($0)") }
    withUnsafePointer(to: &c2) { print("customer1 \($0)") }
    print("\n")
    
    print("数据重构----Replace Array or Dictionary with Object(以对象取代数组或字典)")
    print(studentXiaoMing)
    print(studentArray)
    print(Student.init("小明", 18))
     print("\n")
    print("数据重构----Duplicate Observed Data(复制“被监测数据”)")
    print("运行程序，见首页按钮点击")
     print("\n")
    
    print("数据重构----Change Unidirectional Association to Bidirectional(将单向关联改为双向关联)")
    let order4 : Order1 = Order1.init("cjl", "123456")
    let order5 : Order1 = Order1.init("cjl", "123456")
    let order6 : Order1 = Order1.init("cjl", "123456")
    dump(order5.getCustomer().orders)
    print("\n")
    
    print("数据重构----Encapsulate Field（封装字段)")
    print("\n")
    
    print("数据重构----Encapsulate Collection（封装集合)")
//    print("重构前")
//    //先创建一个书籍数组
//    var books : [LibraryBook] = [LibraryBook]()
//    //添加要借的书籍
//    books.append(LibraryBook("《雪碧加盐》"))
//    books.append(LibraryBook("《格林童话》"))
//    books.append(LibraryBook("《智慧意林》"))
//    //创建借书人
//    let lender : Lender = Lender("cjl")
//    lender.setLendBooks(books)
//    //获取所借的书籍
//    var mybooks = lender.getLendBooks()
//    print(mybooks)
//    //对书籍数组修改后再赋值回去
//    mybooks.removeFirst()
//    lender.setLendBooks(mybooks)
//    print(mybooks)
    print("重构后")
    var bookLender = Lender("cjl")
    bookLender.addBook("《雪碧加盐》")
    bookLender.addBook("《福尔摩斯》")
    print(bookLender.getLendBooks())
    bookLender.removeBook("《福尔摩斯》")
    print(bookLender.getLendBooks())
    print("\n")
    
    print("数据重构----Replace Subclass with Fields（以字段取代子类)")
//    print("重构前")
//    let male : PersonType = Male()
//    print(male.isMale())
//    print(male.getCode())
//    let female : PersonType = Female()
//    print(female.isMale())
//    print(female.getCode())
    print("重构后")
    let male = PersonType.createMale()
    print(male.getIsMale())
    print(male.getCode())
    let female = PersonType.createFemale()
    print(female.getIsMale())
    print(female.getCode())
    print("\n")
}


//MARK:-----------4、条件表达式重构规则-----------
func conditionalExpressionReviewTest(){
    print("条件重构----Replace Nested Condition with Guard Clauses(以卫语句取代嵌套的条件)")
    conditionNest()
    conditionNest2()
    print("\n")
    
    print("条件重构----Replace Condition with Polymorphism(以多态取代条件表达式)")
    let book = ConditionBook(ConditionBook.NEW_BOOK, "《福尔摩斯》")
    print(book.charge())
    print("\n")
}

//MARK:-----------5、继承关系重构规则-----------
func extendsReviewTest(){
    print("继承重构----Form Template Method (构造模板函数)")
    let sub1 : Subcalass1 = Subcalass1()
    print(sub1.calculateMethod())
    let sub2 : Subcalass2 = Subcalass2()
    print(sub2.calculateMethod())
    print("\n")
    
    print("继承重构----以委托取代继承（Replace Inheritance with Delegation）")
    let subObject = subClass041()
    subObject.display(subObject.c)
    print("\n")
}


//MARK:-----------6、代码冲能够完整案例-----------
//https://www.cnblogs.com/ludashi/p/5279459.html
func completeCaseTest(){
    //创建用户
    let customer = CompleteCustomer("cjl")
    
    //创建电影
    let regularMovie : CompleteMovie = CompleteMovie("《老炮儿》", CompleteMovie.REGULAR)
    let newMovie : CompleteMovie = CompleteMovie("《福尔摩斯》", CompleteMovie.NEW_RELESE)
    let childrenMovie : CompleteMovie = CompleteMovie("《葫芦娃》", CompleteMovie.CHILDRENS)
    
    //创建租赁数据
    let rental1 = CompleteRental(regularMovie, daysRented: 5)
    let rental2 = CompleteRental(newMovie, daysRented: 8)
    let rental3 = CompleteRental(childrenMovie, daysRented: 2)
    
    customer.rentals.append(rental1)
    customer.rentals.append(rental2)
    customer.rentals.append(rental3)
    
    let result = customer.statement()
    print(result)
}
