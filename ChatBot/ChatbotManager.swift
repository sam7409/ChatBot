import Foundation

protocol ChatbotManagerDelegate: AnyObject {
    func didReceiveMessage(_ message: String)
}

class ChatbotManager {
    weak var delegate: ChatbotManagerDelegate?

    func getChatbotResponse(message: String) {
        let apiKey = "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" // Replace this with your actual API key
        let endpoint = "https://api.openai.com/v1/engines/text-davinci-003/completions"
        
            guard let url = URL(string: endpoint) else {
                print("Invalid URL")
                return
            }
        
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
        
           var sendMessage = message + "Create five quotes"
            // Prepare the request body as a Swift dictionary
            let requestBody: [String: Any] = [
                "prompt": sendMessage,
                "max_tokens": 100
            ]
        
            // Convert the request body to JSON data
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = jsonData
            } catch {
                print("Error converting request body to JSON: \(error)")
                return
            }
        
            // Set the "Content-Type" header to "application/json"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            // Set the "Authorization" header with the API key
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

            if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dictResponse = jsonResponse as? [String: Any],
                       let botResponse = dictResponse["choices"] as? [[String: Any]],
                       let message = botResponse.first?["text"] as? String {
                        DispatchQueue.main.async {
                            print(message)
                            self.delegate?.didReceiveMessage(message)
                        }
                    }
                } catch {
                    print("Error parsing JSON response: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
