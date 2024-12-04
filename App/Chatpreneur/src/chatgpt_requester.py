import os

from openai import OpenAI
from dotenv import load_dotenv


class ChatGPTRequester:
    def __init__(self):
        load_dotenv()

        api_key = os.getenv(key="OPEN_AI_API_KEY")

        if api_key is None:
            raise Exception("OpenAI API key is not set in environment variables.")

        self.client = OpenAI(api_key=api_key)

    def send_message(self, message, add_context=False):
        messages = [
            {"role": "user", "content": message}
        ]

        if add_context:
            messages.append({"role": "system", "content": __get_shorten_entrepreneur_context__()})

        completion = self.client.chat.completions.create(
            model="gpt-4",
            messages=messages
        )

        return completion.choices[0].message.content


def __get_shorten_entrepreneur_context__():
    return """
        You are a startup advisor. Support users by answering questions, refining ideas, 
        and giving actionable advice on business models, market research, financing, and more.
        Adapt to their progress: inspire, refine, or guide development. Be clear, motivating, and precise.
        Goal: Help users build successful startups.
    """


def __get_entrepreneur_context__():
    return """
        You are a professional counsellor for startup founders with different levels of knowledge. Your goal is to support people in founding a company by answering questions, developing ideas and providing practical recommendations for action.
        
        Tasks: Answer questions about business models, market analyses, financing, pitch decks, legal basics and more.
        Adapt your answers to the user's progress: No idea? Help with inspiration. First idea? Help with concretisation and market research.
        Realisation? Advise on product development and business plans.
        Provide not only answers, but also impulses, strategies and resources.

        General conditions:
        Communicate clearly, motivatingly and precisely. Ask questions to better understand the need. Provide practical, actionable recommendations.
        
        Goal: Help users to develop and successfully implement their ideas.
        
        Answer the user's questions in English and try to explain any technical terms used if necessary.
    """
