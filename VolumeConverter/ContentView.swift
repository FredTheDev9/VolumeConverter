//
//  ContentView.swift
//  VolumeConverter
//
//  Created by Frédéric Rousseau on 2020-12-09.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedUnit : UnitType = .milliliters
    @State private var inputVolume = "1"
    @State private var outputUnit : UnitType = .liters
    
    func removeTrailingZeroes(_ value: Double) -> String {
        let tmp = String(format: "%g", value)
        return tmp
    }
    
    enum UnitType : CaseIterable, Hashable, Identifiable {
        case milliliters
        case liters
        case cups
        case pints
        case gallons
        
        var name: String {
            return "\(self)".map {$0.isUppercase ? " \($0)" : "\($0)"}.joined().capitalized
        }
        
        var id: UnitType {self}
    }
    
    let mlConvertTable = [UnitType.liters: 0.001, UnitType.cups: 0.0035, UnitType.pints: 0.0021, UnitType.gallons: 0.0003]
    
    let literConvertTable = [UnitType.milliliters: 1000, UnitType.cups: 4.2268, UnitType.pints: 2.1134, UnitType.gallons: 0.2642]
    
    let cupsConvertTable = [UnitType.milliliters: 284.1306, UnitType.liters: 0.2841, UnitType.pints: 0.6005, UnitType.gallons: 0.0751]
    
    let pintsConvertTable = [UnitType.milliliters: 473.1765, UnitType.liters: 0.4732, UnitType.cups: 2, UnitType.gallons: 0.125]
    
    let gallonsConvertTable = [UnitType.milliliters: 3785.4118, UnitType.liters: 3.7854, UnitType.cups: 16, UnitType.pints: 8]
    
    var convertedVolume: String {
        let volume = Double(inputVolume) ?? 0
        var convertRate: Double
        
        switch selectedUnit {
        case UnitType.milliliters:
            convertRate = (mlConvertTable[outputUnit] ?? 1)
        case UnitType.liters:
            convertRate = (literConvertTable[outputUnit] ?? 1)
        case UnitType.cups:
            convertRate = (cupsConvertTable[outputUnit] ?? 1)
        case UnitType.pints:
            convertRate = (pintsConvertTable[outputUnit] ?? 1)
        case UnitType.gallons:
            convertRate = (gallonsConvertTable[outputUnit] ?? 1)
        }
        
        return removeTrailingZeroes(volume * convertRate)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input volume")) {
                    Picker("Type", selection: $selectedUnit) {
                        ForEach(UnitType.allCases) { unit in
                            Text(unit.name).tag(unit)
                        }
                    }
                    
                    TextField("Enter quantity", text: $inputVolume).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Output volume")) {
                    Picker("Type", selection: $outputUnit) {
                        ForEach(UnitType.allCases) { unit in
                            Text(unit.name).tag(unit)
                        }
                    }
                    
                    
                }
                
                Section(header: Text("Results")) {
                    Text("\(inputVolume) \(selectedUnit.name) is equivalent to \(convertedVolume) \(outputUnit.name)")
                }
               
            }.navigationTitle("Volume Converter")
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
