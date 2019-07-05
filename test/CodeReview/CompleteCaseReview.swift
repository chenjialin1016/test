//
//  CompleteCaseReview.swift
//  test
//
//  Created by Jialin Chen on 2019/7/1.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

//MARK:-----初始代码
/*
//电影
class CompleteMovie{
    //电影的种类
    static let REGULAR : Int = 0          //普通片儿
    static let NEW_RELESE : Int = 1       //儿童片儿
    static let CHILDRENS : Int = 2        //新片儿
    
    var priceCode : Int                   //代码价格
    let title : String                    //电影名称
    
    init(_ title : String, _ priceCode : Int) {
        self.title = title
        self.priceCode = priceCode
    }
}
//租赁
class CompleteRental{
    let movie : CompleteMovie          //租赁的电影
    let daysRented : Int               //租赁的时间
    
    init(_ movie : CompleteMovie, daysRented : Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
}
//顾客
/*
 计算价格规则：
        普通片儿---2天之内含2天，每部收费2元，超过2天的部分每天收费1.5元，
        新片儿---每天每部3元
        儿童片儿---3天之内含3天，每部收费1.5元，超过3天的部分媒体收费1.5元
 积分计算规则：
        每借一步电影积分增加1，新片每部加2
 */
class CompleteCustomer{
    let name : String                    //用户名字
    private var rentals : [CompleteRental] = [] //用户租赁的电影
    
    init(_ name : String) {
        self.name = name
    }
    
    func addRental(_ rental : CompleteRental){
        self.rentals.append(rental)
    }
    
    func statement()->String{
        var totalAmount : Double = 0            //总金额
        var frequentRenterPoints : Int = 0      //用户积分
        var result : String = "\(self.name)的租赁账单:\n"
        
        for rental : CompleteRental in self.rentals {
            var thisAmount : Double = 0       //单价变量
            
            switch rental.movie.priceCode {
            case CompleteMovie.REGULAR:
                thisAmount += 2
                if rental.daysRented > 2{
                    thisAmount += Double(rental.daysRented-2)*1.5
                }
            case CompleteMovie.NEW_RELESE:
                thisAmount += Double(rental.daysRented*3)
            case CompleteMovie.REGULAR:
                thisAmount += 1.5
                if rental.daysRented > 3{
                    thisAmount += Double(rental.daysRented-3)*1.5
                }
            default:
                break
            }
            
            //计算积分
            frequentRenterPoints += 1
            if rental.movie.priceCode == CompleteMovie.NEW_RELESE && rental.daysRented > 1{
                frequentRenterPoints += 1
            }
            
            //展示result
            result += "\t\(rental.movie.title)\t\(thisAmount)\n"
            
            //计算总金额
            totalAmount += thisAmount
        }
        
        result += "总金额为：\(totalAmount)"
        result += "你本次出借获取的积分为：\(frequentRenterPoints)"
        
        return result
    }
}
*/
//MARK:-----第一次重构：对较长的statement函数进行重构,使用“Extract Method”原则
/*
//电影
class CompleteMovie{
    //电影的种类
    static let REGULAR : Int = 0          //普通片儿
    static let NEW_RELESE : Int = 1       //儿童片儿
    static let CHILDRENS : Int = 2        //新片儿
    
    var priceCode : Int                   //代码价格
    let title : String                    //电影名称
    
    init(_ title : String, _ priceCode : Int) {
        self.title = title
        self.priceCode = priceCode
    }
}
//租赁
class CompleteRental{
    let movie : CompleteMovie          //租赁的电影
    let daysRented : Int               //租赁的时间
    
    init(_ movie : CompleteMovie, daysRented : Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
}
//顾客
/*
 计算价格规则：
 普通片儿---2天之内含2天，每部收费2元，超过2天的部分每天收费1.5元，
 新片儿---每天每部3元
 儿童片儿---3天之内含3天，每部收费1.5元，超过3天的部分媒体收费1.5元
 积分计算规则：
 每借一步电影积分增加1，新片每部加2
 */
class CompleteCustomer{
    let name : String                    //用户名字
    private var rentals : [CompleteRental] = [] //用户租赁的电影
    
    init(_ name : String) {
        self.name = name
    }
    
    func addRental(_ rental : CompleteRental){
        self.rentals.append(rental)
    }
    
    func statement()->String{
        var totalAmount : Double = 0            //总金额
        var frequentRenterPoints : Int = 0      //用户积分
        var result : String = "\(self.name)的租赁账单:\n"
        
        for rental : CompleteRental in self.rentals {
            
            //将此处switch语句进行提取，将其封装成函数
            var thisAmount : Double = amountFor(rental)
            
            //计算积分
            frequentRenterPoints = getFrequentRenterPoints(rental)
            
            //展示result
            result += "\t\(rental.movie.title)\t\(thisAmount)\n"
            
            //计算总金额
            totalAmount += thisAmount
        }
        
        result += "总金额为：\(totalAmount)"
        result += "你本次出借获取的积分为：\(frequentRenterPoints)"
        
        return result
    }
    //根据租赁订单，计算当前电影的金额
    func amountFor(_ aRental : CompleteRental)->Double{
        var result : Double = 0       //单价变量
        
        switch aRental.movie.priceCode {
        case CompleteMovie.REGULAR:
            result += 2
            if aRental.daysRented > 2{
                result += Double(aRental.daysRented-2)*1.5
            }
        case CompleteMovie.NEW_RELESE:
            result += Double(aRental.daysRented*3)
        case CompleteMovie.REGULAR:
            result += 1.5
            if aRental.daysRented > 3{
                result += Double(aRental.daysRented-3)*1.5
            }
        default:
            break
        }
        return result
    }
    //计算积分
    func getFrequentRenterPoints(_ rental : CompleteRental)->Int{
        var frequentRenterPoints : Int = 0
        frequentRenterPoints += 1
        if rental.movie.priceCode == CompleteMovie.NEW_RELESE && rental.daysRented > 1{
            frequentRenterPoints += 1
        }
        return frequentRenterPoints
    }
}
*/
//MARK:-----第二次重构：将计算积分的部分添加进rental内
/*
//电影
class CompleteMovie{
    //电影的种类
    static let REGULAR : Int = 0          //普通片儿
    static let NEW_RELESE : Int = 1       //儿童片儿
    static let CHILDRENS : Int = 2        //新片儿
    
    var priceCode : Int                   //代码价格
    let title : String                    //电影名称
    
    init(_ title : String, _ priceCode : Int) {
        self.title = title
        self.priceCode = priceCode
    }
}
//租赁
class CompleteRental{
    let movie : CompleteMovie          //租赁的电影
    let daysRented : Int               //租赁的时间
    
    init(_ movie : CompleteMovie, daysRented : Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
    
    //根据租赁订单，计算当前电影的金额
    func getCharge()->Double{
        var result : Double = 0       //单价变量
        
        switch self.movie.priceCode {
        case CompleteMovie.REGULAR:
            result += 2
            if self.daysRented > 2{
                result += Double(self.daysRented-2)*1.5
            }
        case CompleteMovie.NEW_RELESE:
            result += Double(self.daysRented*3)
        case CompleteMovie.REGULAR:
            result += 1.5
            if self.daysRented > 3{
                result += Double(self.daysRented-3)*1.5
            }
        default:
            break
        }
        return result
    }
    
    //计算积分
    func getFrequentRenterPoints()->Int{
        var frequentRenterPoints : Int = 0
        frequentRenterPoints += 1
        if self.movie.priceCode == CompleteMovie.NEW_RELESE && self.daysRented > 1{
            frequentRenterPoints += 1
        }
        return frequentRenterPoints
    }
}
//顾客
/*
 计算价格规则：
 普通片儿---2天之内含2天，每部收费2元，超过2天的部分每天收费1.5元，
 新片儿---每天每部3元
 儿童片儿---3天之内含3天，每部收费1.5元，超过3天的部分媒体收费1.5元
 积分计算规则：
 每借一步电影积分增加1，新片每部加2
 */
class CompleteCustomer{
    let name : String                    //用户名字
    private var rentals : [CompleteRental] = [] //用户租赁的电影
    
    init(_ name : String) {
        self.name = name
    }
    
    func addRental(_ rental : CompleteRental){
        self.rentals.append(rental)
    }
    
    func statement()->String{
        var totalAmount : Double = 0            //总金额
        var frequentRenterPoints : Int = 0      //用户积分
        var result : String = "\(self.name)的租赁账单:\n"
        
        for rental : CompleteRental in self.rentals {
            
            //将此处switch语句进行提取，将其封装成函数
            var thisAmount : Double = rental.getCharge()
            
            //计算积分
            frequentRenterPoints = rental.getFrequentRenterPoints()
            
            //展示result
            result += "\t\(rental.movie.title)\t\(thisAmount)\n"
            
            //计算总金额
            totalAmount += thisAmount
        }
        
        result += "总金额为：\(totalAmount)"
        result += "你本次出借获取的积分为：\(frequentRenterPoints)"
        
        return result
    }
    
}
*/

//MARK:-----第三次重构：取出statement中的临时变量,使用“以查询取代临时变量”
/*
//电影
class CompleteMovie{
    //电影的种类
    static let REGULAR : Int = 0          //普通片儿
    static let NEW_RELESE : Int = 1       //儿童片儿
    static let CHILDRENS : Int = 2        //新片儿
    
    var priceCode : Int                   //代码价格
    let title : String                    //电影名称
    
    init(_ title : String, _ priceCode : Int) {
        self.title = title
        self.priceCode = priceCode
    }
}
//租赁
class CompleteRental{
    let movie : CompleteMovie          //租赁的电影
    let daysRented : Int               //租赁的时间
    
    init(_ movie : CompleteMovie, daysRented : Int) {
        self.movie = movie
        self.daysRented = daysRented
    }

    /**第二次重构移动的函数**/
    //根据租赁订单，计算当前电影的金额
    func getCharge()->Double{
        var result : Double = 0       //单价变量
        
        switch self.movie.priceCode {
        case CompleteMovie.REGULAR:
            result += 2
            if self.daysRented > 2{
                result += Double(self.daysRented-2)*1.5
            }
        case CompleteMovie.NEW_RELESE:
            result += Double(self.daysRented*3)
        case CompleteMovie.REGULAR:
            result += 1.5
            if self.daysRented > 3{
                result += Double(self.daysRented-3)*1.5
            }
        default:
            break
        }
        return result
    }
    
    /**第三次重构移动的函数**/
    //计算积分
    func getFrequentRenterPoints()->Int{
        var frequentRenterPoints : Int = 0
        frequentRenterPoints += 1
        if self.movie.priceCode == CompleteMovie.NEW_RELESE && self.daysRented > 1{
            frequentRenterPoints += 1
        }
        return frequentRenterPoints
    }
}
//顾客
/*
 计算价格规则：
 普通片儿---2天之内含2天，每部收费2元，超过2天的部分每天收费1.5元，
 新片儿---每天每部3元
 儿童片儿---3天之内含3天，每部收费1.5元，超过3天的部分媒体收费1.5元
 积分计算规则：
 每借一步电影积分增加1，新片每部加2
 */
class CompleteCustomer{
    let name : String                    //用户名字
    private var rentals : [CompleteRental] = [] //用户租赁的电影
    
    init(_ name : String) {
        self.name = name
    }
    
    func addRental(_ rental : CompleteRental){
        self.rentals.append(rental)
    }
    
    func statement()->String{
        
        var result : String = "\(self.name)的租赁账单:\n"
        
        for rental : CompleteRental in self.rentals {
            
            //展示result
            result += "\t\(rental.movie.title)\t\(rental.getCharge())\n"
        }
        
        result += "总金额为：\(getTotalCharge())"
        result += "你本次出借获取的积分为：\(getTotalFrequentRenterPoints())"
        
        return result
    }
    
    //抽取总额计算代码
    func getTotalCharge()->Double{
        var result : Double = 0
        for rental : CompleteRental in self.rentals {
            result += rental.getCharge()
        }
        return result
    }
    
    //计算总积分的代码
    func getTotalFrequentRenterPoints()->Int{
        var result : Int = 0
        for rental : CompleteRental in self.rentals {
            result += rental.getFrequentRenterPoints()
        }
        return result
    }
}
*/

//MARK:-----第四次重构：将switch语句移到movie中，因为一个对象最好不要在另一个对象中使用switch语句,（Move Method）
/*
//电影
class CompleteMovie{
    //电影的种类
    static let REGULAR : Int = 0          //普通片儿
    static let NEW_RELESE : Int = 1       //儿童片儿
    static let CHILDRENS : Int = 2        //新片儿
    
    var priceCode : Int                   //代码价格
    let title : String                    //电影名称
    
    init(_ title : String, _ priceCode : Int) {
        self.title = title
        self.priceCode = priceCode
    }
    
    //根据租赁订单，计算当前电影的金额
    func getCharge(_ daysRented : Int)->Double{
        var result : Double = 0       //单价变量
        
        switch self.priceCode {
        case CompleteMovie.REGULAR:
            result += 2
            if daysRented > 2{
                result += Double(daysRented-2)*1.5
            }
        case CompleteMovie.NEW_RELESE:
            result += Double(daysRented*3)
        case CompleteMovie.REGULAR:
            result += 1.5
            if daysRented > 3{
                result += Double(daysRented-3)*1.5
            }
        default:
            break
        }
        return result
    }
    
    //计算积分
    func getFrequentRenterPoints(_ daysRented : Int)->Int{
        //第六次重构
        if self.priceCode == CompleteMovie.NEW_RELESE && daysRented > 1{
            return 2
        }
        return 1
    }
}
//租赁
class CompleteRental{
    let movie : CompleteMovie          //租赁的电影
    let daysRented : Int               //租赁的时间
    
    init(_ movie : CompleteMovie, daysRented : Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
    
    //根据租赁订单，计算当前电影的金额
    func getCharge()->Double{
        return self.movie.getCharge(self.daysRented)
    }
    
    //计算当前电影的积分
    func getFrequentRenterPoints()->Int{
        return self.movie.getFrequentRenterPoints(self.daysRented)
    }
    
}
//顾客
/*
 计算价格规则：
 普通片儿---2天之内含2天，每部收费2元，超过2天的部分每天收费1.5元，
 新片儿---每天每部3元
 儿童片儿---3天之内含3天，每部收费1.5元，超过3天的部分媒体收费1.5元
 积分计算规则：
 每借一步电影积分增加1，新片每部加2
 */
class CompleteCustomer{
    let name : String                    //用户名字
    private var rentals : [CompleteRental] = [] //用户租赁的电影
    
    init(_ name : String) {
        self.name = name
    }
    
    func addRental(_ rental : CompleteRental){
        self.rentals.append(rental)
    }
    
    func statement()->String{
        
        var result : String = "\(self.name)的租赁账单:\n"
        
        for rental:CompleteRental in self.rentals {
            //展示result
            result += "\t\(rental.movie.title)\t\(rental.getCharge())\n"
        }
        
        result += "总金额为：\(getTotalCharge())\n"
        result += "你本次出借获取的积分为：\(getTotalFrequentRenterPoints())"
        
        return result
    }
    
    //添加支持输出html的代码
    func htmlStatement()->String{
        var result : String =  "<h1><em>\(self.name)</em>的租赁账单:</h1>\n"
        for rental : CompleteRental in self.rentals {
            
            //展示result
            result += "\t\(rental.movie.title)\t\(rental.getCharge())</br>\n"
        }
        
        result += "<p>总金额为：<em>\(getTotalCharge())</em></p>\n"
        result += "<p>你本次出借获取的积分为：<em>\(getTotalFrequentRenterPoints())</em></p>"
        
        return result
    }
    
    //抽取总额计算代码
    func getTotalCharge()->Double{
        var result : Double = 0
        for rental : CompleteRental in self.rentals {
            result += rental.getCharge()
        }
        return result
    }
    
    //计算总积分的代码
    func getTotalFrequentRenterPoints()->Int{
        var result : Int = 0
        for rental : CompleteRental in self.rentals {
            result += rental.getFrequentRenterPoints()
        }
        return result
    }
}
*/

//MARK:-----第五次重构：使用状态模式进行重构,使用“多态”取代条件表达式

//添加价格接口，在价格接口中有三个方法
protocol CompletePrice {
    func getPriceCode()->Int
    func getCharge(_ daysRented : Int)->Double
    func getFrequentRenterPoints(_ daysRented : Int)->Int
}
class CompleteRegularPrice : CompletePrice {
    func getPriceCode() -> Int {
        return CompleteMovie.REGULAR
    }
    
    func getCharge(_ daysRented: Int) -> Double {
        var result : Double = 2
        if daysRented > 2{
            result += Double(daysRented-2)*1.5
        }
        return result
    }
    
    func getFrequentRenterPoints(_ daysRented: Int) -> Int {
        return 1
    }
    
}
class CompleteNewReleasePrice:CompletePrice{
    func getPriceCode() -> Int {
        return CompleteMovie.NEW_RELESE
    }
    
    func getCharge(_ daysRented: Int) -> Double {
        return Double(daysRented*3)
    }
    
    func getFrequentRenterPoints(_ daysRented: Int) -> Int {
        return daysRented > 1 ? 2 : 1
    }
    
}
class CompleteChildrenPrice:CompletePrice{
    func getPriceCode() -> Int {
        return CompleteMovie.CHILDRENS
    }
    
    func getCharge(_ daysRented: Int) -> Double {
        var result : Double = 1.5
        if daysRented > 3{
            result += Double(daysRented-3)*1.5
        }
        return result
    }
    
    func getFrequentRenterPoints(_ daysRented: Int) -> Int {
        return 1
    }
    
}

//电影
class CompleteMovie{
    //电影的种类
    static let REGULAR : Int = 0          //普通片儿
    static let NEW_RELESE : Int = 1       //儿童片儿
    static let CHILDRENS : Int = 2        //新片儿
    
    var priceCode : Int = 0                   //代码价格
    let title : String                    //电影名称
    
    var price : CompletePrice? = nil      //价格对象
    
    init(_ title : String, _ priceCode : Int) {
        self.title = title
        setPriceCode(priceCode)
    }
    
    func setPriceCode(_ priceCode : Int){
        self.priceCode = priceCode
        switch priceCode {
        case CompleteMovie.REGULAR:
            self.price = CompleteRegularPrice()
        case CompleteMovie.NEW_RELESE:
            self.price = CompleteNewReleasePrice()
        case CompleteMovie.CHILDRENS:
            self.price = CompleteChildrenPrice()
        default:
            break
        }
    }
    
    //根据租赁订单，计算当前电影的金额
    func getCharge(_ daysRented : Int)->Double{
        return (self.price?.getCharge(daysRented))!
    }
    
    //计算积分
    func getFrequentRenterPoints(_ daysRented : Int)->Int{
        return (self.price?.getFrequentRenterPoints(daysRented))!
    }
}
//租赁
class CompleteRental{
    let movie : CompleteMovie          //租赁的电影
    let daysRented : Int               //租赁的时间
    
    init(_ movie : CompleteMovie, daysRented : Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
    
    //根据租赁订单，计算当前电影的金额
    func getCharge()->Double{
        return self.movie.getCharge(self.daysRented)
    }
    
    //计算当前电影的积分
    func getFrequentRenterPoints()->Int{
        return self.movie.getFrequentRenterPoints(self.daysRented)
    }
    
}
//顾客
/*
 计算价格规则：
 普通片儿---2天之内含2天，每部收费2元，超过2天的部分每天收费1.5元，
 新片儿---每天每部3元
 儿童片儿---3天之内含3天，每部收费1.5元，超过3天的部分媒体收费1.5元
 积分计算规则：
 每借一步电影积分增加1，新片每部加2
 */
class CompleteCustomer{
    let name : String                    //用户名字
    var rentals : [CompleteRental] = [] //用户租赁的电影
    
    init(_ name : String) {
        self.name = name
    }
    
    func addRental(_ rental : CompleteRental){
        self.rentals.append(rental)
    }
    
    func statement()->String{
        
        var result : String = "\(self.name)的租赁账单:\n"
        
        for rental:CompleteRental in self.rentals {
            //展示result
            result += "\t\(rental.movie.title)\t\(rental.getCharge())\n"
        }
        
        result += "总金额为：\(getTotalCharge())\n"
        result += "你本次出借获取的积分为：\(getTotalFrequentRenterPoints())"
        
        return result
    }
    
    //添加支持输出html的代码
    func htmlStatement()->String{
        var result : String =  "<h1><em>\(self.name)</em>的租赁账单:</h1>\n"
        for rental : CompleteRental in self.rentals {
            
            //展示result
            result += "\t\(rental.movie.title)\t\(rental.getCharge())</br>\n"
        }
        
        result += "<p>总金额为：<em>\(getTotalCharge())</em></p>\n"
        result += "<p>你本次出借获取的积分为：<em>\(getTotalFrequentRenterPoints())</em></p>"
        
        return result
    }
    
    //抽取总额计算代码
    func getTotalCharge()->Double{
        var result : Double = 0
        for rental : CompleteRental in self.rentals {
            result += rental.getCharge()
        }
        return result
    }
    
    //计算总积分的代码
    func getTotalFrequentRenterPoints()->Int{
        var result : Int = 0
        for rental : CompleteRental in self.rentals {
            result += rental.getFrequentRenterPoints()
        }
        return result
    }
}
