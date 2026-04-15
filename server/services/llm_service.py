import google.generativeai as genai
from config import Settings

settings = Settings()

class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel(model_name="gemini-3.1-flash-lite-preview")
    def generate_response(self, query:str, search_results:list[dict]):
        # source1 : <url>
        # content
        context_text = "\n\n".join([
            f"Source {i+1} {result['url']}:\n{result['content']}"
            for i, result in enumerate(search_results)
        ])
        
        full_prompt = f"""
        Context from web Search:
        {context_text}
        
        Query: {query}
        
        Please provide a comprehensive, detailed, well-cited accurate response using the above context. Think and reason deeply. Ensure it answers the query the human is asking. Do not use your Knowledge until absolute necessary.
        """
        
        response = self.model.generate_content(full_prompt, stream=True)
        
        for chunk in response:
            yield chunk.text #
            
        # return response.text
        
        