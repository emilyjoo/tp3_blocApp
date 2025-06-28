
# 🤖 ChatBot GPT App

A Flutter-based chatbot application powered by OpenAI's GPT-4o API for generating intelligent and natural responses.

---

## 🚀 Features

- 🔐 Login interface
- 🤖 Interactive GPT-4o chatbot
- 🧠 Smart conversational flow
- ⚙️ Error handling (e.g. 401 Unauthorized)
- 📦 State management with `flutter_bloc`

---

## 🛠 Technologies Used

- **OpenAI GPT-4o API** — For generating responses
- **HTTP (`http` package)** — For making API calls
- **Flutter BLoC (`flutter_bloc`)** — For managing app state

---

## 📦 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Erradilatifa/Chatbot-app.git
cd chatbot
````

### 2. Install dependencies

```bash
flutter pub add flutter_bloc
```

### 3. Add your OpenAI API key

Create a `.env` file or configure your key directly:

```env
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 4. Run the app

```bash
flutter run
```

---

## 📁 Project Structure

* `lib/`

  * `bloc/` – BLoC files for state management
  * `models/` – Data models
  * `screens/` – UI screens (Login, Chat)
  * `services/` – API communication
  * `main.dart` – Entry point
