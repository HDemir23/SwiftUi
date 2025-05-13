//
//  ContentView.swift
//  KeepWRest
//
//  Created by Hakan Demir on 20.04.2025.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var getUp = defaultWake
    @State private var sleep = 8.0
    @State private var coffe = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWake: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date.now

        
    }
    
    var body: some View {
        
        
            NavigationView {

                ZStack{
                    VStack(spacing:20){
                        Form {
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("Please choose time")
                                    .font(.headline)
                                
                                DatePicker("Plesare aadasd", selection: $getUp , displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("How many hours do U want to sleep")
                                    .font(.headline)
                                    
                                Stepper("\(sleep.formatted()) hours" , value: $sleep, in: 4...12 , step: 0.10)
                                

                            }
                            VStack(alignment: .leading, spacing: 0){
                                Text("How many Coffe do U drink")
                                    .font(.headline)
                                
                                Stepper(coffe == 1 ? "1 cup" : "\(coffe) cup" , value: $coffe , in: 1...20 )
                            }
                            
                            
                            Button("Action" , action: estimatedSleep)
                                .padding()
                                .foregroundStyle(.primary)
                                .bold()
                                .background(Color.yellow)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity)
                            
                            
                            .navigationBarTitle("KeepWRest")
                        }
                            
                        .scrollContentBackground(.hidden)
                        .clipped()
                        
                            
                    }
                    
                }
                .background(Color.yellow)
                
                
                
                
                
                
                
                
                
                
                
                
                .alert(alertTitle, isPresented: $showAlert) {
                    Button("OK") {}
                } message: {
                    Text(alertMessage)
                }
                
            }
        
        

    
    }
    
    func estimatedSleep() {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCal(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: getUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let pred = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleep, coffee: Double(coffe))
            
            let sleepTime = getUp - pred.actualSleep
            alertTitle = "Ideal Bed Time"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "Error"
            alertMessage = error.localizedDescription
            
        }
        showAlert = true
    }
}

#Preview {
    ContentView()
}
