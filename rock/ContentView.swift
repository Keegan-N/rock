//
//  ContentView.swift
//  rock
//
//  Created by Norgard, Keegan - Student on 10/2/24.
//

import SwiftUI
import AVFoundation
struct ContentView: View {
    @State var choice :Bool = false
    @State var rock :Bool = false
    @State var paper :Bool = false
    @State var scissors :Bool = false
    @State var compRock :Bool = false
    @State var compPaper :Bool = false
    @State var compScissors :Bool = false
    @State var win :Int = 0
    @State var compChoice: Int = 0
    @State var humanScore: Int = 0
    @State var compScore: Int = 0
    @StateObject private var soundManager = SoundManager()
    @State var tie: Bool = false
    @State var tieHumanScore: Int = 0
    @State var tieCompScore: Int = 0
    var body: some View {
        if(tie){
            HStack{
                
                
                VStack {
                    Text("You")
                        .font(.title)
                    Text("\(tieHumanScore)")
                        .font(.system(size: 40))
                        .bold()
                    
                    
                    
                    Circle()
                        .foregroundStyle(.red)
                        .overlay {
                            Image("rock")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                            
                        }
                        .offset(x: rock ? 275 : 0, y:  rock ? 210 : 0)
                        .onTapGesture {
                            if(!choice){
                                withAnimation(.linear(duration: 1)) {
                                    rock.toggle()
                                    choice.toggle()
                                }
                            }
                        }
                    
                    
                    
                    Circle()
                        .foregroundStyle(.yellow)
                        .overlay {
                            Image("paper")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: paper ? 275 : 0)
                        .onTapGesture {
                            if(!choice){
                                withAnimation(.linear(duration: 1)) {
                                    paper.toggle()
                                    choice.toggle()
                                }
                            }
                        }
                    
                    
                    Circle()
                        .foregroundStyle(.orange)
                        .overlay {
                            Image("scissors")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: scissors ? 275 : 0, y:  scissors ? -210 : 0)
                        .onTapGesture {
                            if(!choice){
                                withAnimation(.linear(duration: 1)) {
                                    scissors.toggle()
                                    choice.toggle()
                                }
                            }
                        }
                }
                .padding()
                Spacer()
                VStack{
                    Button{
                        choice = false
                        rock  = false
                        paper  = false
                        scissors  = false
                        compRock  = false
                        compPaper  = false
                        compScissors  = false
                        win = 0
                        compChoice = 0
                        
                    } label: {
                        Text("Again")
                            .font(.system(size: 40))
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if(paper){
                        if(compPaper){
                            Text("Tie")
                                .bold()
                        }
                        if(compRock){
                            Text("You Win")
                                .bold()
                        }
                        if(compScissors){
                            Text("You Lose")
                                .bold()
                        }
                    }
                    if(rock){
                        if(compPaper){
                            Text("You Lose")
                                .bold()
                        }
                        if(compRock){
                            Text("Tie")
                                .bold()
                        }
                        if(compScissors){
                            Text("You Win")
                                .bold()
                        }
                    }
                    if(scissors){
                        if(compPaper){
                            Text("You Win")
                                .bold()
                        }
                        if(compRock){
                            Text("You Lose")
                                .bold()
                        }
                        if(compScissors){
                            Text("Tie")
                                .bold()
                        }
                    }
                    
                    
                }
                Spacer()
                    .onChange(of: choice) {
                        if(choice){
                            
                            win = Int.random(in: 1...3)
                            withAnimation(.linear(duration: 1)){
                                if(win > 1){
                                    compChoice = Int.random(in: 1...3)
                                } else {
                                    if paper {
                                        compScissors = true
                                    }
                                    if rock {
                                        compPaper = true
                                    }
                                    if scissors {
                                        compRock = true
                                    }
                                }
                                if(compChoice == 1){
                                    compRock = true
                                }
                                if(compChoice == 2){
                                    compPaper = true
                                }
                                if(compChoice == 3){
                                    compScissors = true
                                }
                                if(rock){
                                    if(compPaper){
                                        tieCompScore += 1
                                        soundManager.playSound(filename: "L", fileType: "mp3")
                                    }
                                    if(compScissors){
                                        tieHumanScore += 1
                                        soundManager.playSound(filename: "W", fileType: "mp3")
                                    }
                                    
                                }
                                if(paper){
                                    if(compRock){
                                        tieHumanScore += 1
                                        soundManager.playSound(filename: "W", fileType: "mp3")
                                    }
                                    if(compScissors){
                                        tieCompScore += 1
                                        soundManager.playSound(filename: "L", fileType: "mp3")
                                    }
                                    
                                }
                                if(scissors){
                                    if(compRock){
                                        tieCompScore += 1
                                        soundManager.playSound(filename: "L", fileType: "mp3")
                                    }
                                    if(compPaper){
                                        tieHumanScore += 1
                                        soundManager.playSound(filename: "W", fileType: "mp3")
                                    }
                                    
                                }
                                
                            }
                        }
                        if(tieHumanScore > 1||tieCompScore > 1){
                            withAnimation(.linear(duration: 1)){
                                tie = false
                            }
                            if(tieHumanScore > 1){
                                humanScore += 1
                            }
                            if(tieCompScore > 1){
                                compScore += 1
                            }
                        }
                    }
                VStack {
                    Text("CPU")
                        .font(.title)
                    Text("\(tieCompScore)")
                        .font(.system(size: 40))
                        .bold()
                    
                    
                    
                    Circle()
                        .foregroundStyle(.red)
                        .overlay {
                            Image("rock")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: compRock ? -275 : 0,y: compRock ? 210 : 0)
                    
                    
                    
                    Circle()
                        .foregroundStyle(.yellow)
                        .overlay {
                            Image("paper")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: compPaper ? -275 : 0)
                    
                    
                    
                    Circle()
                        .foregroundStyle(.orange)
                        .overlay {
                            Image("scissors")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: compScissors ? -275 : 0,y: compScissors ? -210 : 0)
                    
                    
                    
                }
                .padding()
                
                
            }
            .padding(.horizontal,25)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(.green)
            
        } else{
            HStack{
                
                
                VStack {
                    Text("You")
                        .font(.title)
                    Text("\(humanScore)")
                        .font(.system(size: 40))
                        .bold()
                    
                    
                    
                    Circle()
                        .foregroundStyle(.red)
                        .overlay {
                            Image("rock")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                            
                        }
                        .offset(x: rock ? 275 : 0, y:  rock ? 210 : 0)
                        .onTapGesture {
                            if(!choice){
                                withAnimation(.linear(duration: 1)) {
                                    rock.toggle()
                                    choice.toggle()
                                }
                            }
                        }
                    
                    
                    
                    Circle()
                        .foregroundStyle(.yellow)
                        .overlay {
                            Image("paper")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: paper ? 275 : 0)
                        .onTapGesture {
                            if(!choice){
                                withAnimation(.linear(duration: 1)) {
                                    paper.toggle()
                                    choice.toggle()
                                }
                            }
                        }
                    
                    
                    Circle()
                        .foregroundStyle(.orange)
                        .overlay {
                            Image("scissors")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: scissors ? 275 : 0, y:  scissors ? -210 : 0)
                        .onTapGesture {
                            if(!choice){
                                withAnimation(.linear(duration: 1)) {
                                    scissors.toggle()
                                    choice.toggle()
                                }
                            }
                        }
                }
                .padding()
                Spacer()
                VStack{
                    Button{
                        if(!tie){
                            choice = false
                            rock  = false
                            paper  = false
                            scissors  = false
                            compRock  = false
                            compPaper  = false
                            compScissors  = false
                            win = 0
                            compChoice = 0
                        }
                        
                    } label: {
                        Text("Again")
                            .font(.system(size: 40))
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if(paper){
                        if(compPaper){
                            Text("Tie")
                                .bold()
                        }
                        if(compRock){
                            Text("You Win")
                                .bold()
                        }
                        if(compScissors){
                            Text("You Lose")
                                .bold()
                        }
                    }
                    if(rock){
                        if(compPaper){
                            Text("You Lose")
                                .bold()
                        }
                        if(compRock){
                            Text("Tie")
                                .bold()
                        }
                        if(compScissors){
                            Text("You Win")
                                .bold()
                        }
                    }
                    if(scissors){
                        if(compPaper){
                            Text("You Win")
                                .bold()
                        }
                        if(compRock){
                            Text("You Lose")
                                .bold()
                        }
                        if(compScissors){
                            Text("Tie")
                                .bold()
                        }
                    }
                    
                    
                }
                Spacer()
                    .onChange(of: choice) {
                        if(choice){
                            win = Int.random(in: 1...3)
                            withAnimation(.linear(duration: 1)){
                                if(win > 1){
                                    compChoice = Int.random(in: 1...3)
                                } else {
                                    if paper {
                                        compScissors = true
                                    }
                                    if rock {
                                        compPaper = true
                                    }
                                    if scissors {
                                        compRock = true
                                    }
                                }
                                if(compChoice == 1){
                                    compRock = true
                                }
                                if(compChoice == 2){
                                    compPaper = true
                                }
                                if(compChoice == 3){
                                    compScissors = true
                                }
                                if(rock){
                                    if(compPaper){
                                        compScore += 1
                                        soundManager.playSound(filename: "L", fileType: "mp3")
                                    }
                                    if(compScissors){
                                        humanScore += 1
                                        soundManager.playSound(filename: "W", fileType: "mp3")
                                    }
                                    if(compRock){
                                        tie = true
                                        tieHumanScore = 0
                                        tieCompScore = 0
                                    }
                                }
                                if(paper){
                                    if(compRock){
                                        humanScore += 1
                                        soundManager.playSound(filename: "W", fileType: "mp3")
                                    }
                                    if(compScissors){
                                        compScore += 1
                                        soundManager.playSound(filename: "L", fileType: "mp3")
                                    }
                                    if(compPaper){
                                        tie = true
                                        tieHumanScore = 0
                                        tieCompScore = 0
                                    }
                                }
                                if(scissors){
                                    if(compRock){
                                        compScore += 1
                                        soundManager.playSound(filename: "L", fileType: "mp3")
                                    }
                                    if(compPaper){
                                        humanScore += 1
                                        soundManager.playSound(filename: "W", fileType: "mp3")
                                    }
                                    if(compScissors){
                                        tie = true
                                        tieHumanScore = 0
                                        tieCompScore = 0
                                    }
                                }
                                
                            }
                        }
                    }
                VStack {
                    Text("CPU")
                        .font(.title)
                    Text("\(compScore)")
                        .font(.system(size: 40))
                        .bold()
                    
                    
                    
                    Circle()
                        .foregroundStyle(.red)
                        .overlay {
                            Image("rock")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: compRock ? -275 : 0,y: compRock ? 210 : 0)
                    
                    
                    
                    Circle()
                        .foregroundStyle(.yellow)
                        .overlay {
                            Image("paper")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: compPaper ? -275 : 0)
                    
                    
                    
                    Circle()
                        .foregroundStyle(.orange)
                        .overlay {
                            Image("scissors")
                            
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                        }
                        .offset(x: compScissors ? -275 : 0,y: compScissors ? -210 : 0)
                    
                    
                    
                }
                .padding()
                
                
            }
            .padding(.horizontal,25)
        }
    }
}
class SoundManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    
    func playSound(filename: String, fileType: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: fileType) else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
#Preview {
    ContentView()
}
