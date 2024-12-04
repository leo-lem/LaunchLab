from fastapi import FastAPI, Response, status, Request
from fastapi.responses import HTMLResponse, JSONResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from src.chatgpt_requester import ChatGPTRequester
from src.message_model import MessageModel

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")


templates = Jinja2Templates(directory="templates")


@app.get("/", response_class=HTMLResponse)
def read_root(request: Request):
    return templates.TemplateResponse(
        request=request, name="index.html"
    )


@app.post("/chat")
def post_chat_message(message_model: MessageModel):
    try:
        answer = ChatGPTRequester().send_message(message_model.message, add_context=True)
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)

    return JSONResponse(content={"answer": answer}, status_code=status.HTTP_200_OK)


@app.get("/chat-widget", response_class=HTMLResponse)
def get_chat_widget(request: Request):
    return templates.TemplateResponse(
        request=request, name="chat-widget-page.html"
    )