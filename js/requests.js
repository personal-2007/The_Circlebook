/*
 * The Circlebook
 * Circle Requests JavaScript
 */

document.addEventListener("DOMContentLoaded", () => {
    initializeRequestsPage();
});


/* =========================================
   INITIALIZE
========================================= */

function initializeRequestsPage() {

    const currentUser = getRequestCurrentUser();

    if (!currentUser) {
        window.location.href = "login.html";
        return;
    }

    renderRequests();

}


/* =========================================
   GET CURRENT USER
========================================= */

function getRequestCurrentUser() {

    const data = localStorage.getItem(
        "circlebook_current_user"
    );

    if (!data) {
        return null;
    }

    try {
        return JSON.parse(data);
    } catch (error) {
        console.error(
            "Invalid current user:",
            error
        );

        return null;
    }
}


/* =========================================
   GET USERS
========================================= */

function getRequestUsers() {

    const data =
        localStorage.getItem("circlebook_users");

    if (!data) {
        return [];
    }

    try {
        return JSON.parse(data);
    } catch (error) {
        console.error(
            "Unable to load users:",
            error
        );

        return [];
    }
}


/* =========================================
   SAVE USERS
========================================= */

function saveRequestUsers(users) {

    localStorage.setItem(
        "circlebook_users",
        JSON.stringify(users)
    );
}


/* =========================================
   RENDER REQUESTS
========================================= */

function renderRequests() {

    const currentUser =
        getRequestCurrentUser();

    const users =
        getRequestUsers();

    const requestsList =
        document.getElementById("requestsList");

    const emptyState =
        document.getElementById("requestsEmpty");

    const status =
        document.getElementById("requestStatus");


    if (
        !currentUser ||
        !requestsList
    ) {
        return;
    }


    const user =
        users.find(
            item => item.id === currentUser.id
        );


    if (!user) {
        return;
    }


    const requestIds =
        Array.isArray(user.friendRequests)
            ? user.friendRequests
            : [];


    const requestUsers =
        requestIds
            .map(id =>
                users.find(
                    person => person.id === id
                )
            )
            .filter(Boolean);


    requestsList.innerHTML = "";


    /* No requests */

    if (requestUsers.length === 0) {

        if (emptyState) {
            emptyState.hidden = false;
        }

        if (status) {
            status.textContent =
                "You have no pending circle requests.";
        }

        return;
    }


    if (emptyState) {
        emptyState.hidden = true;
    }


    if (status) {

        status.textContent =
            `${requestUsers.length} ${
                requestUsers.length === 1
                    ? "pending request"
                    : "pending requests"
            }.`;
    }


    requestUsers.forEach(requestUser => {

        const card =
            createRequestCard(requestUser);

        requestsList.appendChild(card);

    });
}


/* =========================================
   CREATE REQUEST CARD
========================================= */

function createRequestCard(requestUser) {
    const currentUser = getRequestCurrentUser();
    const users = getRequestUsers();
    const viewer = users.find(user => user.id === currentUser.id);
    const canSeeProfile = canViewRequestProfile(requestUser, viewer, users);

    const card =
        document.createElement("article");

    card.className = "request-card";


    /* Profile Photo */

    const photo =
        document.createElement("div");

    photo.className = "request-photo";

    const name =
        requestUser.fullName ||
        "Unknown User";

    photo.textContent =
        name.charAt(0).toUpperCase();


    /* Information */

    const information =
        document.createElement("div");

    information.className =
        "request-information";


    const heading =
        document.createElement("h2");

    heading.textContent = name;


    const location =
        document.createElement("p");

    location.className =
        "request-location";

    location.textContent = canSeeProfile
        ? requestUser.location || "Location not provided"
        : "Private profile";


    const education =
        document.createElement("p");

    education.className =
        "request-education";

    education.textContent = canSeeProfile
        ? requestUser.education || "Education not provided"
        : "Private";


    /* Actions */

    const actions =
        document.createElement("div");

    actions.className =
        "request-actions";


    const viewButton =
        document.createElement("a");

    viewButton.href =
        `profile.html?id=${encodeURIComponent(
            requestUser.id
        )}`;

    viewButton.className =
        "btn btn-secondary";

    viewButton.textContent =
        "View Profile";


    const acceptButton =
        document.createElement("button");

    acceptButton.type = "button";

    acceptButton.className =
        "btn btn-primary";

    acceptButton.textContent =
        "Accept";


    const declineButton =
        document.createElement("button");

    declineButton.type = "button";

    declineButton.className =
        "btn btn-secondary";

    declineButton.textContent =
        "Decline";


    acceptButton.addEventListener(
        "click",
        () => {

            acceptRequest(
                requestUser.id
            );

        }
    );


    declineButton.addEventListener(
        "click",
        () => {

            declineRequest(
                requestUser.id
            );

        }
    );


    actions.appendChild(viewButton);
    actions.appendChild(acceptButton);
    actions.appendChild(declineButton);


    information.appendChild(heading);
    information.appendChild(location);
    information.appendChild(education);
    information.appendChild(actions);


    card.appendChild(photo);
    card.appendChild(information);


    return card;
}

function canViewRequestProfile(user, viewer, users) {
    const visibility = user.privacy && user.privacy.profile || "friends";
    if (visibility === "public") {
        return true;
    }
    if (visibility !== "friends") {
        return false;
    }

    return Array.isArray(user.friends) && user.friends.includes(viewer.id) &&
        Array.isArray(viewer.friends) && viewer.friends.includes(user.id);
}


/* =========================================
   ACCEPT REQUEST
========================================= */

function acceptRequest(requesterId) {

    const currentUser =
        getRequestCurrentUser();

    const users =
        getRequestUsers();


    const currentUserData =
        users.find(
            user => user.id === currentUser.id
        );

    const requester =
        users.find(
            user => user.id === requesterId
        );


    if (
        !currentUserData ||
        !requester
    ) {
        return;
    }

    if (!Array.isArray(currentUserData.friendRequests) ||
        !currentUserData.friendRequests.includes(requesterId)) {
        showRequestMessage("That request is no longer pending.", "info");
        renderRequests();
        return;
    }

    if (Array.isArray(requester.friendRequests)) {
        requester.friendRequests = requester.friendRequests.filter(
            id => id !== currentUserData.id
        );
    }


    if (!Array.isArray(
        currentUserData.friends
    )) {
        currentUserData.friends = [];
    }


    if (!Array.isArray(
        requester.friends
    )) {
        requester.friends = [];
    }


    /* Add both users to each other's circle */

    if (
        !currentUserData.friends.includes(
            requesterId
        )
    ) {
        currentUserData.friends.push(
            requesterId
        );
    }


    if (
        !requester.friends.includes(
            currentUserData.id
        )
    ) {
        requester.friends.push(
            currentUserData.id
        );
    }


    /* Remove request */

    currentUserData.friendRequests =
        Array.isArray(
            currentUserData.friendRequests
        )
            ? currentUserData.friendRequests.filter(
                id => id !== requesterId
            )
            : [];


    saveRequestUsers(users);


    showRequestMessage(
        `${requester.fullName} is now in your circle.`,
        "success"
    );


    renderRequests();
}


/* =========================================
   DECLINE REQUEST
========================================= */

function declineRequest(requesterId) {

    const currentUser =
        getRequestCurrentUser();

    const users =
        getRequestUsers();


    const currentUserData =
        users.find(
            user => user.id === currentUser.id
        );


    if (!currentUserData) {
        return;
    }


    currentUserData.friendRequests =
        Array.isArray(
            currentUserData.friendRequests
        )
            ? currentUserData.friendRequests.filter(
                id => id !== requesterId
            )
            : [];


    saveRequestUsers(users);


    showRequestMessage(
        "Circle request declined.",
        "info"
    );


    renderRequests();
}


/* =========================================
   MESSAGE
========================================= */

function showRequestMessage(
    message,
    type = "info"
) {

    const existing =
        document.querySelector(
            ".request-message"
        );

    if (existing) {
        existing.remove();
    }


    const messageElement =
        document.createElement("div");

    messageElement.className =
        `request-message ${type}`;

    messageElement.textContent =
        message;


    document.body.appendChild(
        messageElement
    );


    setTimeout(() => {

        messageElement.remove();

    }, 3000);
}