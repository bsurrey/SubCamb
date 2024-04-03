//
//  CycleView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 03.04.24.
//

import SwiftUI    
/*
 struct CycleView: View {
 enum Frequency: Codable {
 case daily
 case weekly
 case monthly
 case yearly
 }
 
 @Binding private var frequency: Frequency = Frequency.daily
 
 var body: some View {
 Section {
 Picker("Frequency", selection: $frequency) {
 Text("Daily").tag(Frequency.daily)
 Text("Weekly").tag(Frequency.weekly)
 Text("Monthly").tag(Frequency.monthly)
 Text("Yearly").tag(Frequency.yearly)
 }
 
 HStack {
 Picker("Every", selection: $selectedContractType) {
 ForEach((1...365), id: \.self) {
 Text("\($0)")
 }
 }.pickerStyle(WheelPickerStyle())
 
 Picker("Every", selection: $selectedContractType) {
 Text("Day")
 }.pickerStyle(WheelPickerStyle())
 }
 }
 
 Section(header: Text("interes rate")) {
 Picker("Contract Type", selection: $selectedContractType) {
 Text("Monthly").tag(ContractType.expense)
 Text("Quarterly").tag(ContractType.expense)
 Text("Yearly").tag(ContractType.income)
 }
 .pickerStyle(SegmentedPickerStyle())
 
 TextField("16 %", text: $url)
 }
 
 Section(header: Text("Fee")) {
 Picker("Contract Type", selection: $selectedContractType) {
 Text("Monthly").tag(ContractType.expense)
 Text("Quarterly").tag(ContractType.expense)
 Text("Yearly").tag(ContractType.income)
 }
 .pickerStyle(SegmentedPickerStyle())
 
 TextField("3€", text: $url)
 }
 }
 }
 */
