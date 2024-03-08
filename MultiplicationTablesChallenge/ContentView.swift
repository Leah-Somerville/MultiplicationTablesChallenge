//
//  ContentView.swift
//  MultiplicationTablesChallenge
//
//  Created by Leah Somerville on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numSelection = [2, 3, 4, 5, 6, 7 , 8 , 9, 10, 11, 12]
    @State private var numSelected = 2
    
    @State private var questionSelection = [5, 10, 20]
    @State private var questionAmount = 5
    
    @State private var userAnswer = 0
    
    @State private var configGame = true
    @State private var playGame = false
    @State private var gameOver = false
    
    @State private var problem: String = "Sorry, there was an error"
    @State private var randomNum = Int.random(in: 0...12)
    
    @State private var score = 0
    
    @State private var showAlert = false
    @State private var alertMessage: String = "Sorry, there was an error"
    
    @State private var currentQuestion = 0
    
    var body: some View {
        NavigationView{
            Form {
                if configGame {
                    Section {
                        Picker("Please select a number", selection: $numSelected){
                            ForEach(0 ..< 11, id: \.self) {
                                Text("\(numSelection[$0])")}
                        }.pickerStyle(.segmented)
                    } header: {
                        Text("Which times table would you like?")
                            .font(.title2).foregroundStyle(.black)
                    }
                    
                    Section {
                        Picker("How many questions would you like?", selection: $questionAmount) {
                            ForEach(0 ..< 3, id: \.self) {
                                Text("\(questionSelection[$0])")
                            }
                        }
                    }
                    
                    Button("Play Game!") {
                        configureGame()
                    }
                }
                
                if playGame {
                    Section {
                        TextField("User answer", value: $userAnswer, format: .number)
                    } header: {
                        Text(problem)
                            .font(.title)
                            .foregroundStyle(.black)
                    }
    
                    Section {
                        Text("Score: \(score)")
                    }
                    
                    Button("Check Answer") {
                        checkAnswer()
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    
                    .alert(alertMessage, isPresented: $showAlert) {
                        Button("Ok") {
                            if gameOver {
                                startNewGames()
                            }
                        }
                    }

                }
            }
        }
        .navigationTitle("Multipaction Tables")
    }
    
    func configureGame() {

        playGame = true
        configGame = false
        gameOver = false

        var count = 0
        while count < questionAmount {
            problem = "What is \(numSelected) x \(randomNum)?"
            count += 1
        }

    }
    
    func checkAnswer() {
        if userAnswer == numSelected * randomNum {
            score += 1
            alertMessage = "Correct!"
        } else {
            alertMessage = "Wrong"
        }
        
        currentQuestion += 1
        showAlert = true
        newQuestion()
    }
    
    func newQuestion() {
        if currentQuestion < questionAmount {
            randomNum = Int.random(in: 0...12)
            problem = "What is \(numSelected) x \(randomNum)?"
        } else {
            showAlert = true
            alertMessage = "Game Over! Start New Game? "
            gameOver = true
        }
    }
    
    func startNewGames() {
        currentQuestion = 0
        score = 0
        playGame = false
        configGame = true
    }

}

#Preview {
    ContentView()
}
