//
//  ContentView.swift
//  UnitConversions
//
//  Created by Константин Шутов on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputType = UnitLength.meters
    @State private var outputType = UnitLength.meters
    @State private var userValue = 0.0
    
    let unitTypes: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    var convertedUnit: Double {
        let unitToConvert = Measurement(value: userValue, unit: inputType)
        let convertedUnit = unitToConvert.converted(to: outputType)
        
        return convertedUnit.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value", value: $userValue, format: .number)
                        .keyboardType(.numberPad)
                    
                    Picker("Unit selection", selection: $inputType) {
                        ForEach(unitTypes, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input")
                }
                
                Section {
                    Text(convertedUnit, format: .number)
                    
                    Picker("Unit selection", selection: $outputType) {
                        ForEach(unitTypes, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Length conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
