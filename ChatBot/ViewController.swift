//import UIKit
//
//class ViewController: UIViewController {
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var inputTextField: UITextField!
//
//    var chatMessages: [String] = []
//    let chatbotManager = ChatbotManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//          tableView.tableFooterView = UIView()
//
//          // Register the custom cell class here
//          tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatCell")
//
//          // Set the delegate to receive chatbot responses
//          chatbotManager.delegate = self
//    }
//
//    @IBAction func sendButtonTapped(_ sender: UIButton) {
//        if let message = inputTextField.text, !message.isEmpty {
//            sendMessage(message)
//            inputTextField.text = ""
//        }
//    }
//
//    func sendMessage(_ message: String) {
//        // Add user message to chatMessages
//        chatMessages.append(message)
//        tableView.reloadData()
//
//        // Get chatbot response
//        chatbotManager.getChatbotResponse(message: message)
//    }
//
//    func receiveMessage(_ message: String) {
//        // Add bot message to chatMessages
//        chatMessages.append(message)
//        print(chatMessages)
//        tableView.reloadData()
//    }
//}
//
//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chatMessages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
//        cell.message = chatMessages[indexPath.row]
//        return cell
//    }
//
//    // Add this method to set a fixed height for the cells
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80 // Set your desired cell height here
//    }
//}
//
//extension ViewController: ChatbotManagerDelegate {
//    func didReceiveMessage(_ message: String) {
//        // Remove leading and trailing whitespace and newline characters
//        let trimmedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
//        receiveMessage(trimmedMessage)
//        print(message)
//
//    }
//}


import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputTextField: UITextField!
    
    var chatMessages: [String] = []
    let chatbotManager = ChatbotManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self // Add the delegate for handling item selection
        
        // Register the custom cell class here
        collectionView.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: "ChatCell")
        
        // Set the delegate to receive chatbot responses
        chatbotManager.delegate = self
        // Set minimum interitem spacing and minimum line spacing to zero
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.sectionInset = UIEdgeInsets.zero
        }
        collectionView.backgroundColor = .gray
        collectionView.bounds = view.bounds
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        if let message = inputTextField.text, !message.isEmpty {
            sendMessage(message)
            inputTextField.text = ""
        }
    }
    
    func sendMessage(_ message: String) {
//        chatMessages.append(message)
        collectionView.reloadData()
        
        // Get chatbot response
        chatbotManager.getChatbotResponse(message: message)
    }
    
    func receiveMessage(_ message: String) {
        chatMessages.removeAll()
        // Add bot message to chatMessages
        let quotesText = message
        // Split the text into individual lines
        let lines = quotesText.components(separatedBy: "\n")
        
        // Loop through the lines and extract the quotes with their respective integers
        for line in lines {
            // Add user message to chatMessages
            chatMessages.append(line)
        }
        var stringArray = chatMessages
        let filteredArray = stringArray.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        chatMessages = filteredArray

        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(chatMessages.count)
        return chatMessages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCell", for: indexPath) as! ChatCollectionViewCell
        
        // Check if the index is within the bounds of the chatMessages array
        if indexPath.item < chatMessages.count {
            cell.setLabelText (chatMessages[indexPath.item])
        }
        
        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    // Add this method to set a fixed size for the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400 , height: collectionView.frame.height - 340) // Set your desired cell height here
    }
    
    // Set the minimum spacing between items in the same row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Return the desired minimum spacing
        return 10
    }
    // Set the minimum spacing between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Return the desired minimum line spacing
        return 10
    }
}

extension ViewController: ChatbotManagerDelegate {
    func didReceiveMessage(_ message: String) {
        // Remove leading and trailing whitespace and newline characters
        let trimmedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
        receiveMessage(trimmedMessage)

    }
    
}






