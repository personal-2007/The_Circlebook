/* =========================================================
   THE CIRCLEBOOK - MESSAGES & CHAT ENGINE
   ========================================================= */

const CirclebookMessages = {
    send(chatId, text) {
        CirclebookApp.handleSendChatMessage(chatId);
    }
};
