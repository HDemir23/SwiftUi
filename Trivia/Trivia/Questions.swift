//
//  Questions.swift
//  Trivia
//
//  Created by Hakan Demir on 30.04.2025./Users/rose/Desktop/Swift/Trivia/Trivia/ContentView.swift
//

import Foundation

struct TriviaResponse: Codable {
    var results: [TriviaQuestions]
}

struct TriviaQuestions: Codable{
    var id: UUID {UUID()}
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    
}





func fetchData(for difficultyLevel: String, amount: Int) async -> [TriviaQuestions]{
         
         var diffParam = ""
         
         if difficultyLevel != "any" {
             diffParam = "&difficulty=\(difficultyLevel)"
             
           }
         
         
         guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)&type=multiple\(diffParam)") else {
             fatalError("API URL is not valid")
         }
    

         
         
         do {
             let (data, _) = try await URLSession.shared.data(from: url)
             
             let decoded = try JSONDecoder().decode(TriviaResponse.self, from: data)
             
             
             
             let cleanQuestions = decoded.results.map { question in
                 TriviaQuestions(
                     difficulty: question.difficulty,
                     category: question.category.htmlDecoded,
                     question: question.question.htmlDecoded,
                     correct_answer: question.correct_answer.htmlDecoded,
                     incorrect_answers: question.incorrect_answers.map { $0.htmlDecoded }
                 )
             }
             
             
             
             return cleanQuestions
         } catch {
             fatalError("Something went wrong \(error)")
         }
    
    
     }




extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let decoded = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return decoded.string
        } else {
            return self
        }
    }
}


