/* =========================================================
   THE CIRCLEBOOK - AUTHENTICATION MODULE
   ========================================================= */

const CirclebookAuth = {
    login(email, password) {
        if (!email || !password) {
            CirclebookApp.toast("Please fill in both email and password.");
            return false;
        }
        CirclebookApp.toast("Welcome back! Loading your profile...");
        CirclebookRouter.navigate("home", "feed");
        return true;
    },

    register(name, email, password) {
        if (!name || !email || !password) {
            CirclebookApp.toast("All fields are required for registration.");
            return false;
        }
        CirclebookApp.toast("Account successfully created! Starting onboarding...");
        CirclebookRouter.navigate("entry", "onboarding1");
        return true;
    },

    logout() {
        localStorage.removeItem("circlebook_master_store");
        CirclebookApp.toast("Logged out successfully.");
        CirclebookRouter.navigate("auth", "login");
    }
};
