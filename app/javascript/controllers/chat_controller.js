import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    // This function is triggered every time a quote is added to the DOM.
    connect() {
        this.applyAuthorClasses()
    }

    // Apply the actual classes
    applyAuthorClasses() {
        const currentUserId = document.querySelector('meta[name="current-user-id"]').getAttribute('content');
        const authorId = this.element.getAttribute('data-author-id');


        const messageButtons = this.element.querySelector('.quote__actions')

        // Compare the IDs and apply the class accordingly
        if (currentUserId === authorId) {
            this.element.classList.add("quote--mine")
        } else {
            this.element.classList.add("quote--his")

            // Hide Delete and Edit button if not mine
            messageButtons.classList.add("quote__hidden")
        }

    }
}