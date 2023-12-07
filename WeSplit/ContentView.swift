//
//  ContentView.swift
//  WeSplit
//
//  Created by Dexter on 07.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0;
    @State private var numberOfPeople: Int = 2;
    @State private var tipPercentage: Int = 20;
    @FocusState private var isFocused: Bool;
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        let amountPerPerson = (checkAmount + (checkAmount / 100 * tipSelection)) / peopleCount
        
        return amountPerPerson
    }
    private let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<8, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
