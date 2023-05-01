//
//  ContentView.swift
//  MortgageLabApp
//
//  Created by Philip Trwoga on 11/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("interestRate") var interestRate: String = ""
    @AppStorage("amountBorrowed") var amountBorrowed: String = ""
    @AppStorage("LoanTimeYears") var LoanTimeYears: String = ""
    @AppStorage("monthlyInterst") var monthlyInterst: Double = 0.0
    @AppStorage("TotalCal") var TotalCal: Double = 0.0
  
    var body: some View {
        ZStack{
            HStack{
                Image("house")
                    .scaledToFit()
                    .padding(.bottom, 350)
                    .opacity(0.2)
              
    
            }.ignoresSafeArea()

            VStack {
                
                Text("Morgage Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack{
                    Image(systemName: "sterlingsign.circle.fill")
                    Text("Amount to be borrowed")
                }
                .font(.title3)
                
                
                TextField("Amount Borrowed", text: $amountBorrowed)
                    .frame( maxWidth: .infinity, maxHeight: 35)
                    .border(.blue)
                    .multilineTextAlignment(.center)
                    .onChange(of: LoanTimeYears,
                              perform: {
                        newValue in amountBorrowed = checkText(text: amountBorrowed)
                    })
                    .background(Color.white)
                    .keyboardType(.decimalPad)
                
                
                HStack{
                    
                    Image(systemName: "clock.badge.questionmark")
                    Text("Loan period - years")
                }
                .font(.title3)
                
                
                TextField("Loan Time", text: $LoanTimeYears)
                    .frame( maxWidth: .infinity, maxHeight: 35)
                    .background(Color.white)
                    .border(.blue)
                    .multilineTextAlignment(.center)
                    .onChange(of: LoanTimeYears,
                              perform: {
                        newValue in LoanTimeYears = checkText(text: LoanTimeYears)
                    })
                    .keyboardType(.decimalPad)
                    
                
                HStack{
                    Image(systemName: "percent")
                    Text("Interest rate")
                    
                }
                .font(.title3)
              
                
                TextField("Interest rate", text: $interestRate)
                    .frame(maxWidth: .infinity, maxHeight: 35)
                    .background(Color.white)
                    .border(.blue)
                    .multilineTextAlignment(.center)
                            .onChange(of: interestRate,
                                      perform: {
                                newValue in interestRate = checkText(text: interestRate)
                    })
                    .keyboardType(.decimalPad)
                    
                
                Button("Calculate") {
                    mortgageCalculator()
                }.padding()
                
                Text("Monthly payment: £ \(TotalCal, specifier: "%.2f")")

            }
            
        }
        
    }
    
    func mortgageCalculator(){
        //convert var to doubles as required for the calculation
        let time = Int(LoanTimeYears) ?? 0
        let rate = Double(interestRate) ?? 0.0
        let amount = Double(amountBorrowed) ?? 0.0

        let timeInMonths = time * 12
        let MonthlyInterestCal = (rate / 100) * (1 / 12)
        
 TotalCal = amount * (MonthlyInterestCal / (1 - pow(1 + MonthlyInterestCal, -(Double(timeInMonths)))))
        
    }

    func checkText(text:String)->String{
        var updatedString = text
        var dotCount = 0
        for d in text {
            if String(d) == "."
            {  dotCount += 1  }
        }
        if dotCount >= 2 {
            // remove the last typed point
            updatedString = String(text.dropLast())
        }
        return updatedString
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
