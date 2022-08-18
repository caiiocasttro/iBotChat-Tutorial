//
//  ContentView.swift
//  iBotChatUi
//
//  Created by Caio Castro on 21/06/2022.
// TODO: CONTINUAR O TUTORIAL EM 09:21 

import SwiftUI

struct ContentView: View {
    
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to chat iBot"]
    var body: some View {
        // MARK: Parte de cima do projeto
        VStack{
            HStack{
                Text("iBot")
                    .font(.largeTitle)
                    .bold()
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.blue)
                
                
            }
            // MARK: Campo para a mensagem ---
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue.opacity(0.8))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    } else {
                        HStack {
                            Text(message)
                                .padding()
                                .background(.gray.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                }.rotationEffect(.degrees(180))
            }.rotationEffect(.degrees(180))
                .background(Color.gray.opacity(0.10))
            // MARK: Campo para digitar a mensagem ---
            HStack {
                TextField("Type something", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                // MARK: Botao para enviar a mensagem ---
                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
               }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
        }
    }
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message)
            self.messageText = ""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                messages.append(getBotResponse(message: message))
            }
        }
    }
}
        
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
