//dios
//  consejeroAIView.swift
//  diosvirgencita
//
//  Created by Havit on 25/07/26.
//

import SwiftUI


// MARK: - Modelo de Mensaje
struct ChatMessage: Identifiable, Codable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

// MARK: - Vista del Chat del Consejero AI (Powered by Gemini)
struct ConsejeroAIView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(
            text: "¡Dios te bendiga! ✝️ Soy tu Consejero Bíblico. Puedes hacerme preguntas sobre las Escrituras, pedir oraciones o buscar consuelo en la Palabra de Dios.",
            isUser: false
        )
    ]
    @State private var inputText: String = ""
    @State private var isLoading: Bool = false

    // 🔑 PEGA AQUÍ TU CLAVE CLEAN DE GEMINI (...cLjA)
  

    var body: some View {
        VStack(spacing: 0) {
            
            // Área de Chat / Mensajes
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(messages) { message in
                            ChatBubbleView(message: message)
                                .id(message.id)
                        }

                        if isLoading {
                            HStack {
                                ProgressView()
                                    .padding(12)
                                    .background(Color.gray.opacity(0.15))
                                    .cornerRadius(16)
                                Spacer()
                            }
                            .id("LoadingIndicator")
                        }
                    }
                    .padding()
                }
                .onChange(of: messages.count) { _ in
                    if let lastID = messages.last?.id {
                        withAnimation {
                            proxy.scrollTo(lastID, anchor: .bottom)
                        }
                    }
                }
            }

            Divider()

            // Campo de entrada de texto
            HStack(spacing: 12) {
                TextField("Escribe tu pregunta o inquietud...", text: $inputText)
                    .padding(12)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(20)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(inputText.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray : Color.orange)
                        .clipShape(Circle())
                }
                .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty || isLoading)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color(UIColor.systemBackground))
        }
        .onAppear(){
            loadMessages()
        }
        .navigationTitle("Consejero AI ✝️")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Enviar Mensaje
    private func sendMessage() {
        let textToSend = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !textToSend.isEmpty else { return }

        let userMessage = ChatMessage(text: textToSend, isUser: true)
        messages.append(userMessage)
        inputText = ""
        isLoading = true

        Task {
            await fetchGeminiResponse(userPrompt: textToSend)
        }
    }

    // MARK: - Conexión con Gemini API
    private let groqAPIKey: String = ""
    private func fetchGeminiResponse(userPrompt: String) async {
        let urlString = ""
        
        guard let url = URL(string: urlString) else {
            addErrorMessage("Error al construir la URL.")
            return
        }

        let systemPrompt = """
        Eres un Consejero Bíblico y Espiritual sabio, empático, amoroso y respetuoso de la doctrina cristiana en castellano. 
        Tu objetivo es guiar a las personas con amor, orar por ellas, brindar consuelo en batallas espirituales, aconsejar con sabiduría y ofrecer versículos o Salmos relevantes en la versión Reina-Valera. 
        Usa un tono pacífico, lleno de fe, empatía y bendición.
        """

        let body: [String: Any] = [
            "model": "llama-3.1-8b-instant",
            "messages": [
                ["role": "system", "content": systemPrompt],
                ["role": "user", "content": userPrompt]
            ],
            "temperature": 0.7
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(groqAPIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let choices = json["choices"] as? [[String: Any]],
                       let firstChoice = choices.first,
                       let messageObj = firstChoice["message"] as? [String: Any],
                       let responseText = messageObj["content"] as? String {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.messages.append(ChatMessage(text: responseText, isUser: false))
                            self.saveMessages() // 👈 Guarda el historial actualizado
                        }

                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.messages.append(ChatMessage(text: responseText.trimmingCharacters(in: .whitespacesAndNewlines), isUser: false))
                        }
                        return
                    }
                } else {
                    if let jsonError = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let errorObj = jsonError["error"] as? [String: Any],
                       let message = errorObj["message"] as? String {
                        DispatchQueue.main.async {
                            self.addErrorMessage("Error (\(httpResponse.statusCode)): \(message)")
                        }
                        return
                    }
                }
            }

            DispatchQueue.main.async {
                self.addErrorMessage("No se pudo obtener respuesta del servidor.")
            }

        } catch {
            DispatchQueue.main.async {
                self.addErrorMessage("Error de conexión: \(error.localizedDescription)")
            }
        }
        
        
    }
    

    private func addErrorMessage(_ text: String) {
        self.isLoading = false
        self.messages.append(ChatMessage(text: "✝️ \(text)", isUser: false))
    }
    //MARK: - manejo de memoria
    // 💾 Guardar mensajes en el dispositivo
    private func saveMessages() {
        if let encoded = try? JSONEncoder().encode(messages) {
            UserDefaults.standard.set(encoded, forKey: "ConsejeroChatHistory")
        }
    }

    // 📂 Cargar mensajes al abrir la vista
    private func loadMessages() {
        if let savedData = UserDefaults.standard.data(forKey: "ConsejeroChatHistory"),
           let decodedMessages = try? JSONDecoder().decode([ChatMessage].self, from: savedData) {
            self.messages = decodedMessages
        }
    }
    private func clearChat() {
        messages.removeAll()
        UserDefaults.standard.removeObject(forKey: "ConsejeroChatHistory")
    }
}

// MARK: - Componente de Burbuja de Chat
struct ChatBubbleView: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser { Spacer() }

            Text(message.text)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(message.isUser ? Color.orange : Color(UIColor.secondarySystemBackground))
                .foregroundColor(message.isUser ? .white : .primary)
                .cornerRadius(20)
                .frame(maxWidth: 290, alignment: message.isUser ? .trailing : .leading)

            if !message.isUser { Spacer() }
        }
    }
}







#Preview {
    ConsejeroAIView()
}
