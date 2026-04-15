from typing import List

from sentence_transformers import SentenceTransformer
import numpy as np

class SortSourceService:
    #cos similary search
    def __init__(self):
        self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")
        
    def sort_sources(self, querry: str, search_results: List[dict]):
        try:
            relevance_docs = []
            query_embedding = self.embedding_model.encode(querry)
            
            for res in search_results:
                content = res.get("content")
                if content is None:
                    continue
                res_embedding = self.embedding_model.encode(content)
                similarity = float(np.dot(query_embedding, res_embedding )/ (np.linalg.norm(res_embedding) * np.linalg.norm(query_embedding)))
                
                res['relevance_score'] = similarity;
                
                if(similarity > 0.3):
                    relevance_docs.append(res)
                
                
            return sorted(relevance_docs, key=lambda x:x['relevance_score'], reverse=True)
        except Exception as e:
            print(e)
            