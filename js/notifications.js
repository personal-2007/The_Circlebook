/* =========================================================
   THE CIRCLEBOOK - NOTIFICATIONS CENTER
   ========================================================= */

const CirclebookNotifications = {
    markAllRead() {
        CirclebookStore.notifications.forEach(n => n.isRead = true);
        CirclebookStore.saveState();
        CirclebookApp.toast("All notifications marked as read.");
        CirclebookRouter.render();
    }
};
