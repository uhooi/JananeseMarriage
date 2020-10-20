//
//  Japanese.swift
//  JananeseMarriage
//
//  Created by saki iwamoto on 2020/10/21.
//

import Foundation

/// 日本人
class Japanese {
    /// 名
    let firstName: String
    /// 姓
    var familyName: String
    /// 生年月日
    let birthdate: DateComponents
    
    init(firstName given: String, familyName last: String, birthday: DateComponents) {
        firstName = given
        familyName = last
        birthdate = birthday
    }
    
    /// 年齢
    var age: Int {
        // 生年月日から算出
        let calendar = Calendar.current
        let now = calendar.dateComponents([.year, .month, .day], from: Date())
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        return ageComponents.year!
    }
    /// 性別
    var gender = Gender.Notknown
    /// 旧姓
    var maidenName: String?
    
    /// フルネームを返します
    ///
    /// - Parameter previous: 旧姓を返したい場合はtrue
    /// - Returns: 旧姓がない場合エラー返します
    func fullName(previous: Bool = false) throws -> String{
        if previous {
            guard let name = maidenName else { throw MarriageError.UnchangeName}
            return (name + " " + firstName)
        }
        return(familyName + " " + firstName)
    }
}

/// 結婚する人
class MarriagePartner: Japanese {
    
    /// 配偶者
    private (set) var partner: Japanese?
    
    /// 相手と結婚します
    ///
    /// - Parameters:
    ///   - spouse: 結婚相手
    ///   - changeName: 苗字変更をするか
    func marriage(spouse: Japanese, changeName: Bool) throws {
        // 既婚であればエラー
        guard partner == nil else { throw MarriageError.bigamy }
        
        // 性別・年齢チェック
        switch gender {
        case .Notknown, .NotApplicable:
            throw MarriageError.UnknownGender
        case .Male:
            if age < 18 {
                throw MarriageError.Underage
            }
        case .Female:
            if age < 16 {
                throw MarriageError.Underage
            }
        }
        if gender == spouse.gender {
            throw MarriageError.sameSexMarriage
        }
        
        // 苗字を変更します
        if changeName {
            maidenName = familyName
            familyName = spouse.familyName
        }
        
        partner = spouse
    }
}
