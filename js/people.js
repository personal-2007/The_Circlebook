/*
 * The Circlebook
 * People Directory JavaScript
 */

document.addEventListener("DOMContentLoaded", () => {
    initializePeoplePage();
});


/* =========================================
   INITIALIZE
========================================= */

function initializePeoplePage() {

    const searchForm =
        document.getElementById("peopleSearchForm");

    const searchInput =
        document.getElementById("peopleSearch");

    if (!searchForm || !searchInput) {
        return;
    }

    renderPeople("");


    searchForm.addEventListener("submit", (event) => {

        event.preventDefault();

        const query =
            searchInput.value.trim();

        renderPeople(query);
    });


    /* Live search */

    searchInput.addEventListener("input", () => {

        renderPeople(
            searchInput.value.trim()
        );
    });
}


/* =========================================
   GET USERS
========================================= */

function getPeopleUsers() {

    const users =
        localStorage.getItem("circlebook_users");

    if (!users) {
        return [];
    }

    try {
        return JSON.parse(users);
    } catch (error) {
        console.error(
            "Unable to load Circlebook users:",
            error
        );

        return [];
    }
}


/* =========================================
   CURRENT USER
========================================= */

function getPeopleCurrentUser() {

    const currentUser =
        localStorage.getItem(
            "circlebook_current_user"
        );

    if (!currentUser) {
        return null;
    }

    try {
        return JSON.parse(currentUser);
    } catch (error) {
        return null;
    }
}


/* =========================================
   RENDER PEOPLE
========================================= */

function renderPeople(query) {

    const results =
        document.getElementById("peopleResults");

    const empty =
        document.getElementById("peopleEmpty");

    const status =
        document.getElementById("searchStatus");

    if (!results) {
        return;
    }


    const users = getPeopleUsers();

    const currentUser =
        getPeopleCurrentUser();


    /* Don't show current user */

    let people = users.filter((user) => {

        if (!currentUser) {
            return true;
        }

        return user.id !== currentUser.id;
    });


    /* Search */

    if (query) {

        const search =
            query.toLowerCase();

        people = people.filter((user) => {

            if (!canSeePeopleProfile(user, currentUser, users)) {
                return (user.fullName || "").toLowerCase().includes(search);
            }

            const name =
                user.fullName || "";

            const location =
                user.location || "";

            const education =
                user.education || "";

            const interests =
                Array.isArray(user.interests)
                    ? user.interests.join(" ")
                    : "";

            const searchableText =
                `${name} ${location} ${education} ${interests}`
                    .toLowerCase();

            return searchableText.includes(search);
        });
    }


    results.innerHTML = "";


    if (people.length === 0) {

        if (empty) {
            empty.hidden = false;
        }

        if (status) {
            status.textContent =
                query
                    ? `No results found for "${query}".`
                    : "No other members are available yet.";
        }

        return;
    }


    if (empty) {
        empty.hidden = true;
    }


    if (status) {

        status.textContent =
            query
                ? `${people.length} ${
                    people.length === 1
                        ? "person"
                        : "people"
                } found.`
                : `${people.length} ${
                    people.length === 1
                        ? "person"
                        : "people"
                } in the community.`;
    }


    people.forEach((user) => {

        const card =
            createPersonCard(user, currentUser, users);

        results.appendChild(card);
    });
}


/* =========================================
   CREATE PERSON CARD
========================================= */

function createPersonCard(user, currentUser, users) {

    const card =
        document.createElement("article");

    card.className = "person-card";


    /* Photo */

    const photo =
        document.createElement("div");

    photo.className = "person-photo";

    const name =
        user.fullName || "Unknown User";

    photo.textContent =
        name.charAt(0).toUpperCase();


    /* Information */

    const information =
        document.createElement("div");

    information.className =
        "person-information";


    const title =
        document.createElement("h2");

    title.textContent = name;


    const location =
        document.createElement("p");

    location.className =
        "person-location";

    const canSeeProfile = canSeePeopleProfile(user, currentUser, users);
    location.textContent = canSeeProfile
        ? user.location || "Location not provided"
        : "Private profile";


    const education =
        document.createElement("p");

    education.className =
        "person-education";

    education.textContent = canSeeProfile
        ? user.education || "Education not provided"
        : "Private";


    /* Interests */

    const interests =
        document.createElement("div");

    interests.className =
        "person-interests";


    if (
        canSeeProfile && Array.isArray(user.interests) &&
        user.interests.length > 0
    ) {

        user.interests
            .slice(0, 3)
            .forEach((interest) => {

                const tag =
                    document.createElement("span");

                tag.textContent = interest;

                interests.appendChild(tag);
            });
    }


    /* View Profile */

    const actions =
        document.createElement("div");

    actions.className =
        "person-actions";


    const profileLink =
        document.createElement("a");

    profileLink.className =
        "btn btn-secondary";

    profileLink.href =
        `profile.html?id=${encodeURIComponent(user.id)}`;

    profileLink.textContent =
        "View Profile";


    /* Add to Friend */

    const addButton =
        document.createElement("button");

    addButton.type = "button";

    addButton.className =
        "btn btn-primary";

    addButton.textContent =
        "Add to Friend";


    addButton.addEventListener(
        "click",
        () => {

            if (sendFriendRequest(user.id)) {
                addButton.textContent = "Request Sent";
                addButton.disabled = true;
            }
        }
    );


    actions.appendChild(profileLink);
    actions.appendChild(addButton);


    /* Assemble */

    information.appendChild(title);
    information.appendChild(location);
    information.appendChild(education);
    information.appendChild(interests);
    information.appendChild(actions);


    card.appendChild(photo);
    card.appendChild(information);


    return card;
}


/* =========================================
   SEND FRIEND REQUEST
========================================= */

function sendFriendRequest(targetUserId) {

    const currentUser =
        getPeopleCurrentUser();

    if (!currentUser) {
        window.location.href = "login.html";
        return false;
    }


    const users =
        getPeopleUsers();


    const sender =
        users.find(
            (user) =>
                user.id === currentUser.id
        );

    const receiver =
        users.find(
            (user) =>
                user.id === targetUserId
        );


    if (!sender || !receiver) {
        showPeopleMessage("That member is no longer available.", "error");
        return false;
    }


    if (!Array.isArray(sender.friends)) {
        sender.friends = [];
    }

    if (!Array.isArray(receiver.friends)) {
        receiver.friends = [];
    }

    if (!Array.isArray(receiver.friendRequests)) {
        receiver.friendRequests = [];
    }


    /* Already friends */

    if (
        sender.friends.includes(targetUserId)
    ) {
        showPeopleMessage(
            "You are already in this person's circle.",
            "info"
        );

        return false;
    }


    /* Existing request */

    if (
        receiver.friendRequests.includes(
            sender.id
        )
    ) {
        showPeopleMessage(
            "Friend request already sent.",
            "info"
        );

        return false;
    }

    if (Array.isArray(sender.friendRequests) && sender.friendRequests.includes(targetUserId)) {
        showPeopleMessage("This person has already sent you a request.", "info");
        return false;
    }


    /* Add request */

    receiver.friendRequests.push(
        sender.id
    );


    localStorage.setItem(
        "circlebook_users",
        JSON.stringify(users)
    );


    showPeopleMessage(
        `Circle request sent to ${receiver.fullName}.`,
        "success"
    );

    return true;
}


/* =========================================
   MESSAGE
========================================= */

function showPeopleMessage(
    message,
    type = "info"
) {

    const existing =
        document.querySelector(
            ".people-message"
        );

    if (existing) {
        existing.remove();
    }


    const messageElement =
        document.createElement("div");

    messageElement.className =
        `people-message ${type}`;

    messageElement.textContent =
        message;


    document.body.appendChild(
        messageElement
    );


    setTimeout(() => {

        messageElement.remove();

    }, 3000);
}

function canSeePeopleProfile(user, viewer, users) {
    if (!viewer || user.id === viewer.id) {
        return true;
    }

    const visibility = user.privacy && user.privacy.profile || "friends";
    if (visibility === "public") {
        return true;
    }
    if (visibility !== "friends") {
        return false;
    }

    const viewerRecord = users.find(item => item.id === viewer.id);
    return Array.isArray(user.friends) && user.friends.includes(viewer.id) &&
        Array.isArray(viewerRecord && viewerRecord.friends) && viewerRecord.friends.includes(user.id);
}