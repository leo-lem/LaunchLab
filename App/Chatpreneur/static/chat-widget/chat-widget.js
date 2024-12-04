document.addEventListener("DOMContentLoaded", () => {
    const chatWidget = new ChatWidget();
});

class ChatWidget {
    constructor() {
        this.chat = new Chat();
        this.chatGUI = new ChatGUI();
        this.chatGUI.addSendButtonCallback(this.handleMessageSend.bind(this));
    }

    async handleMessageSend() {
        const message = this.chatGUI.chatInput.value;
        this.chatGUI.chatInput.value = "";

        const evt = new CustomEvent("messageSend");
        this.chatGUI.chatInput.dispatchEvent(evt);

        this.chatGUI.renderChatMessage("right", message);

        this.chatGUI.showChatBotLoading();
        const chatBotResponse = await this.chat.getChatBotResponse(message).then((response) => {
            this.chatGUI.hideChatBotLoading();
            return response.json();
        });

        this.chatGUI.renderChatMessage("left", chatBotResponse.answer);
    }
}

class ChatGUI {
    constructor() {
        const selectors = {
            chatWidget: "#chat-widget"
        };

        this.isChatOpen = false;
        this.chatWidget = document.querySelector(selectors.chatWidget);
        this.chatButton = document.querySelector(`${selectors.chatWidget} .chat-float-icon`);
        this.chatWindow = document.querySelector(`${selectors.chatWidget} .chat-window`);
        this.chatMessages = document.querySelector(`${selectors.chatWidget} .chat-messages`);

        this.chatActions = document.querySelector(`${selectors.chatWidget} .chat-actions`);
        this.chatSendButton = document.querySelector(`${selectors.chatWidget} #chat-send`);
        this.chatInput = document.querySelector(`${selectors.chatWidget} #chat-input`);
        this.goToBottomButton = document.querySelector(`${selectors.chatWidget} #chat-go-to-bottom`);

        this.chatButton.addEventListener("click", this.handleChatOpen.bind(this));
        this.chatInput.addEventListener("input", this.adjustHeight);
        this.chatInput.addEventListener("paste", this.adjustHeight);
        this.chatInput.addEventListener("messageSend", this.adjustHeight);

        this.goToBottomButton.addEventListener("click", () => {
            this.chatMessages.scrollTop = this.chatMessages.scrollHeight;
        });

        this.chatMessages.addEventListener("scroll", () => {
            if (this.chatMessages.scrollTop === (this.chatMessages.scrollHeight - this.chatMessages.offsetHeight)) {
                this.goToBottomButton.classList.remove("slideInFromBottomButton");
                this.goToBottomButton.classList.add("slideOutToBottomButton");
            } else {
                this.goToBottomButton.classList.add("slideInFromBottomButton");
                this.goToBottomButton.classList.remove("slideOutToBottomButton");
            }
        });

        // setTimeout(() => {
        //     this.chatButton.classList.add("bounce");
        // }, 1000);
    }

    showChatBotLoading() {
        this.chatSendButton.setAttribute("disabled", true);
        this.chatInput.setAttribute("disabled", true);
        this.chatMessages.appendChild(createLoadingChatMessageElement());
    }

    hideChatBotLoading() {
        const loadingElem = this.chatMessages.querySelector(".message:has(.dot-loader)");
        this.chatMessages.removeChild(loadingElem);
        this.chatSendButton.removeAttribute("disabled");
        this.chatInput.removeAttribute("disabled");
    }

    addSendButtonCallback(callback) {
        this.chatSendButton.addEventListener("click", () => {
            this.chatActions.classList.remove("fadeIn");
            this.chatActions.classList.add("fadeOut");

            this.chatMessages.scrollTop = this.chatMessages.scrollHeight;
            callback();
        });
        this.chatInput.addEventListener("keyup", (e) => {
            this.chatMessages.scrollTop = this.chatMessages.scrollHeight;

            if (this.chatInput.value.trim() !== "") {
                this.chatActions.classList.remove("fadeOut");
                this.chatActions.classList.add("fadeIn");
            } else {
                this.chatActions.classList.remove("fadeIn");
                this.chatActions.classList.add("fadeOut");
            }

            if (!e.shiftKey && e.keyCode == 13) {
                this.chatActions.classList.remove("fadeIn");
                this.chatActions.classList.add("fadeOut");

                e.preventDefault();
                callback();
            }
        });
    }

    renderChatMessage(side, message) {
        this.chatMessages.appendChild(createChatMessageElement(side, message));
    }

    handleChatOpen() {
        this.isChatOpen = !this.isChatOpen;
        if (this.isChatOpen) {
            this.chatButton.innerHTML = getChevronDownIcon();
            this.chatWidget.classList.add("slideInFromBottomWidget");
            this.chatWidget.classList.remove("slideOutToBottomWidget");
        } else {
            this.chatButton.innerHTML = getChatIcon();
            this.chatWidget.classList.remove("slideInFromBottomWidget");
            this.chatWidget.classList.add("slideOutToBottomWidget");
        }
    }

    adjustHeight() {
        var el = this,
            offset = el.offsetHeight - el.clientHeight,
            maxHeight = parseFloat(getComputedStyle(el).maxHeight),
            minHeight = 50;

        if (el.scrollHeight > el.clientHeight) {
            // Grow the field if scroll height is smaller, but not exceed maxHeight
            var newHeight = el.scrollHeight - offset;
            el.style.height = (newHeight > maxHeight ? maxHeight : newHeight) + 'px';
        } else {
            // Shrink the field and then re-set it to the scroll height in case it needs to shrink
            el.style.height = minHeight + 'px';
            // var newHeight = el.scrollHeight - offset;
            // el.style.height = (newHeight > maxHeight ? maxHeight : newHeight) + 'px';
        }

        // Ensure cursor stays within padding when max height is reached
        if (el.scrollHeight > maxHeight) {
            el.scrollTop = el.scrollHeight - el.clientHeight;
            el.style.overflowY = 'scroll';
        } else {
            el.style.overflowY = 'hidden';
        }
    }
}

class Chat {
    constructor() {
        // TODO: Maybe save messages in array and local storage for persistence
    }

    async getChatBotResponse(message) {
        const url = "/chat";

        try {
            const response = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    "message": message
                }),
            });

            if (!response.ok) {
                throw new Error("Failed to fetch chatbot response");
            }

            return response;

        } catch (error) {
            console.error("Error fetching chatbot response: ", error);
            return "Sorry, I'm having trouble understanding you right now. Please try again later.";
        }
    }
}

function createLoadingChatMessageElement() {
    const messageElement = document.createElement("div");
    messageElement.classList.add("message");
    messageElement.setAttribute("data-side", "left");

    const avatar = document.createElement("div");
    avatar.classList.add("chat-avatar");
    avatar.innerHTML = getChatBotAvatar();

    messageElement.appendChild(avatar);

    const contentWrapper = document.createElement("div");
    contentWrapper.classList.add("content-wrapper");

    const content = document.createElement("div");
    content.classList.add("content");

    const dotLoader = document.createElement("div");
    dotLoader.classList.add("dot-loader");

    content.appendChild(dotLoader);

    contentWrapper.appendChild(content);
    messageElement.appendChild(contentWrapper);

    return messageElement;
}

function createChatMessageElement(side, message) {
    const messageElement = document.createElement("div");
    messageElement.classList.add("message");
    messageElement.setAttribute("data-side", side);

    if (side === "left") {
        const avatar = document.createElement("div");
        avatar.classList.add("chat-avatar");
        avatar.innerHTML = getChatBotAvatar();

        messageElement.appendChild(avatar);
    }

    const contentWrapper = document.createElement("div");
    contentWrapper.classList.add("content-wrapper");

    const content = document.createElement("div");
    content.classList.add("content");

    const messageArray = message.split("\n");
    content.innerHTML = messageArray.map((paragraph) => {
        if (paragraph !== "") {
            return `<p>${paragraph}</p>`;
        }
    }).join("");

    contentWrapper.appendChild(content);
    messageElement.appendChild(contentWrapper);

    return messageElement;
}

function getChatBotAvatar() {
    return '<svg fill="#fff" width="24px" height="24px" viewBox="0 0 24 24"><path d="M21.928 11.607c-.202-.488-.635-.605-.928-.633V8c0-1.103-.897-2-2-2h-6V4.61c.305-.274.5-.668.5-1.11a1.5 1.5 0 0 0-3 0c0 .442.195.836.5 1.11V6H5c-1.103 0-2 .897-2 2v2.997l-.082.006A1 1 0 0 0 1.99 12v2a1 1 0 0 0 1 1H3v5c0 1.103.897 2 2 2h14c1.103 0 2-.897 2-2v-5a1 1 0 0 0 1-1v-1.938a1.006 1.006 0 0 0-.072-.455zM5 20V8h14l.001 3.996L19 12v2l.001.005.001 5.995H5z" /><ellipse cx="8.5" cy="12" rx="1.5" ry="2" /><ellipse cx="15.5" cy="12" rx="1.5" ry="2" /><path d="M8 16h8v2H8z" /></svg>';
}

function getChatIcon() {
    return '<svg fill="#fff" height="26px" width="26px" viewBox="0 0 60 60"><g><path d="M57.348,0.793H12.652C11.189,0.793,10,1.983,10,3.446v7.347h34.348c2.565,0,4.652,2.087,4.652,4.653v25.347h1.586L60,50.207V3.446C60,1.983,58.811,0.793,57.348,0.793z" /><path d="M44.348,12.793H2.652C1.189,12.793,0,13.983,0,15.446v43.761l9.414-9.414h34.934c1.463,0,2.652-1.19,2.652-2.653V15.446C47,13.983,45.811,12.793,44.348,12.793z M11,22.793h12c0.553,0,1,0.448,1,1s-0.447,1-1,1H11c-0.553,0-1-0.448-1-1S10.447,22.793,11,22.793z M36,38.793H11c-0.553,0-1-0.448-1-1s0.447-1,1-1h25c0.553,0,1,0.448,1,1S36.553,38.793,36,38.793zM36,31.793H11c-0.553,0-1-0.448-1-1s0.447-1,1-1h25c0.553,0,1,0.448,1,1S36.553,31.793,36,31.793z" /></g></svg>';
}

function getChevronDownIcon() {
    return '<svg fill="#fff" height="26px" width="26px" viewBox="0 0 407.437 407.437"><polygon points="386.258,91.567 203.718,273.512 21.179,91.567 0,112.815 203.718,315.87 407.437,112.815 " /></svg>';
}