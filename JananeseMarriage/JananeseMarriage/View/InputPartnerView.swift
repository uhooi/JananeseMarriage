//
//  InputPartnerView.swift
//  JananeseMarriage
//
//  Created by saki iwamoto on 2020/10/21.
//

import SwiftUI

struct InputPartnerView: View {
    /// 姓
    @State var familyName = ""
    /// 名
    @State var firstName = ""
    /// 生年月日
    @State var birthdate = Date() // TODO:修正
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Text("名字")
                    .padding()
                TextField("", text: $familyName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    .padding()  // 余白を追加
            }
            HStack {
                Text("名前")
                    .padding()
                TextField("", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    .padding()  // 余白を追加
            }
            DatePicker("誕生日", selection: $birthdate, displayedComponents: [.date])
                .datePickerStyle(WheelDatePickerStyle())
                // .labelsHidden()
                .padding()  // 余白を追加
            Button(action: {
                // 閉じる
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("入力完了")
            }
        }
    }
}

struct InputPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        InputPartnerView()
    }
}
