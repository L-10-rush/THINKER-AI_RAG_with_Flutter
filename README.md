# THINKER-AI: RAG with Flutter

## Overview

Ever chat with an AI and wish it knew more about current events or niche topics? This project solves that by giving your AI brain a real-time connection to the web. It lets you ask questions, and the AI will go out, search for the most relevant info, and then give you a thoughtful, cited answer, all streamed back to you as it thinks. It's like having a super-smart research assistant at your fingertips.

## Features

*   **Intelligent Web Search**: Automatically searches the internet to gather relevant information for your queries.
*   **Contextual Source Ranking**: Uses semantic similarity to identify and prioritize the most pertinent search results, ensuring the AI focuses on the best data.
*   **AI-Powered Responses**: Generates comprehensive, detailed, and accurate answers by synthesizing information from the curated web sources.
*   **Real-time Streaming**: Get AI responses in chunks as they are generated, providing a more dynamic and engaging user experience.
*   **Cited Answers**: Responses are grounded in the provided web context, making them verifiable and trustworthy.

## Getting Started

Let's get this up and running! This project has two main parts: a Flutter frontend (the app itself) and a Python FastAPI backend (which handles all the AI and search logic).

### Installation

First, clone the repository:

```bash
git clone https://github.com/L-10-rush/THINKER-AI_RAG_with_Flutter.git
cd THINKER-AI_RAG_with_Flutter
```

**For the Backend (Python FastAPI):**

1.  Navigate into the `server` directory:
    ```bash
    cd server
    ```
2.  Install the required Python packages:
    ```bash
    pip install -r requirements.txt
    ```
3.  Make sure you have your environment variables set up (see next section).
4.  Start the FastAPI server:
    ```bash
    uvicorn main:app --reload --host 0.0.0.0 --port 8000
    ```
    This will run the server on `http://localhost:8000`.

**For the Frontend (Flutter):**

1.  From the project root (where `pubspec.yaml` is located), get the Flutter dependencies:
    ```bash
    flutter pub get
    ```
2.  Run the Flutter application on your preferred device or emulator:
    ```bash
    flutter run
    ```

### Environment Variables

The backend requires a few API keys to function correctly. Create a `.env` file in the `server` directory and add the following:

```dotenv
TAVILY_API_KEY="your_tavily_api_key_here"
GEMINI_API_KEY="your_gemini_api_key_here"
```

*   **`TAVILY_API_KEY`**: This is for the web search capabilities. You can get one from [Tavily AI](https://tavily.com/).
*   **`GEMINI_API_KEY`**: This is for the Large Language Model (LLM) that generates the responses. You can obtain it from [Google AI Studio](https://ai.google.dev/).

## Usage

Once both the Flutter app and the FastAPI backend are running, you can open the Flutter application on your device or emulator. The app will connect to the backend's API.

You'll be able to type in your questions, and the app will send them to the FastAPI server. The server will then perform a web search, sort the results for relevance, and pass them to the Gemini AI model to generate a well-informed response. You'll see the search results and the AI's answer stream back in real-time within the app.

## API Documentation

The backend provides a REST endpoint for direct chat and a WebSocket endpoint for real-time, streaming interactions.

### Base URL
`http://localhost:8000`

### Endpoints

#### `POST /chat`
This endpoint allows you to send a query and receive a complete, non-streaming AI response.

**Description**: Sends a user query to the RAG system and returns the final AI-generated answer.

**Request**:
```json
{
  "query": "What are the latest advancements in quantum computing as of today?"
}
```

**Response**:
```json
{
  "response": "Based on recent web searches, quantum computing has seen several advancements including breakthroughs in qubit stability, error correction techniques, and the development of new quantum algorithms for specific problems like materials science and drug discovery. Companies like IBM and Google continue to push the boundaries with increasing qubit counts and improved coherence times in their experimental processors..."
}
```

**Errors**:
- 422 Unprocessable Entity: If the request body is malformed or missing the `query` field.
- 500 Internal Server Error: If an unexpected error occurs on the server during search or response generation.

#### `GET /ws/chat`
This endpoint establishes a WebSocket connection for real-time, streaming AI responses and intermediate search results.

**Description**: Opens a WebSocket connection to send queries and receive streaming data, including initial search results and subsequent AI response chunks.

**Interaction Flow**:
1.  Establish a WebSocket connection.
2.  Send a JSON message with your query:
    ```json
    {
      "query": "What's the current political situation in France?"
    }
    ```
3.  Receive a JSON message of type `search_result` with the top relevant web sources:
    ```json
    {
      "type": "search_result",
      "data": [
        {
          "title": "French Politics Today",
          "url": "https://example.com/french-politics",
          "content": "..."
        },
        {
          "title": "Macron's Approval Ratings",
          "url": "https://example.com/macron-ratings",
          "content": "..."
        }
      ]
    }
    ```
4.  Receive multiple JSON messages of type `content` containing chunks of the AI's response as it's generated:
    ```json
    {
      "type": "content",
      "data": "The current political situation in France..."
    }
    ```
    ```json
    {
      "type": "content",
      "data": "...is marked by ongoing debates around economic reforms..."
    }
    ```
    ...and so on, until the full response is streamed.

## Technologies Used

| Technology | Description |
| :------------------ | :------------------------------------------------------------------------------------------------- |
| **Flutter**         | Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. |
| **Python**          | The primary language for the backend, known for its readability and extensive libraries.        |
| **FastAPI**         | A modern, fast (high-performance) web framework for building APIs with Python 3.7+ based on standard Python type hints. |
| **Google Gemini AI**| The Large Language Model (LLM) used for generating intelligent and comprehensive responses.   |
| **Tavily API**      | Powers the intelligent web search functionality to gather up-to-date information.             |
| **Sentence Transformers** | Used for generating embeddings and calculating semantic similarity to rank search results.     |
| **Trafilatura**     | A Python library for extracting main text, comments, and metadata from web pages.              |

## Contributing

We'd love for you to contribute to this project! Here's how you can help:

1.  **Fork the repository**: Start by forking the project to your own GitHub account.
2.  **Create a new branch**: Make a new branch for your feature or bug fix: `git checkout -b feature/your-feature-name` or `bugfix/issue-description`.
3.  **Make your changes**: Implement your changes, following the existing code style.
4.  **Test your changes**: Ensure your changes work as expected and don't introduce new issues.
5.  **Commit your changes**: Write clear and concise commit messages.
6.  **Push to your fork**: `git push origin feature/your-feature-name`
7.  **Create a Pull Request**: Open a pull request to the `main` branch of this repository, describing your changes and why they're beneficial.

## Author Info

*   **LinkedIn**: [Your LinkedIn Profile](https://www.linkedin.com/)

## Badges

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com/)
[![Google Gemini](https://img.shields.io/badge/Google_Gemini-FF6817?style=for-the-badge&logo=google-gemini&logoColor=white)](https://ai.google.dev/models/gemini)
[![Tavily AI](https://img.shields.io/badge/Tavily_AI-121212?style=for-the-badge&logo=tavily&logoColor=white)](https://tavily.com/)

[![Readme was generated by Dokugen](https://img.shields.io/badge/Readme%20was%20generated%20by-Dokugen-brightgreen)](https://www.npmjs.com/package/dokugen)