import asyncio

from fastapi import FastAPI, WebSocket

from pydantic_models.chat_body import ChatBody
from services.llm_service import LLMService
from services.search_service import SearchService
from services.sort_source_service import SortSourceService

app = FastAPI()

search_service = SearchService()
sort_source_service =  SortSourceService()
llm_service  = LLMService()




# Web sockets
@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        data  = await websocket.receive_json()
        # print(data)
        query = data.get("query")
        # print(query)
        search_results = search_service.web_search(query)
        # print(search_results)
        sorted_results =  sort_source_service.sort_sources(querry=query, search_results=search_results)
        
        await websocket.send_json({
            'type': 'search_result',
            'data': sorted_results
        })
        
        for chunk in llm_service.generate_response(query, sorted_results):
            await asyncio.sleep(0.1)
            await websocket.send_json({
                'type': 'content', 'data': chunk
            })
    except Exception as e:
        print(e)
        print("Unexpected error occurred at websocket")
    finally:
        await websocket.close()


# chating
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    
    # SEARCH THE web and find the appropriate sources
    search_results = search_service.web_search(body.query)
    # sort the sources
    sorted_results =  sort_source_service.sort_sources(querry=body.query, search_results=search_results)
    response = llm_service.generate_response(body.query, sorted_results)
    
    
    # generate the respose usign the LLM
    
    return response
