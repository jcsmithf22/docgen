import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        console.log("Flash controller connected");
        this.hideTimeout = setTimeout(() => {
            this.hide();
        }, 5 * 1000);
    }

    disconnect() {
        clearTimeout(this.hideTimeout);
        if (this.animateTimeout) {
            clearTimeout(this.animateTimeout);
        }
    }

    hide() {
        this.element.classList.remove("flashIn");
        this.element.classList.add("flashOut");
        this.animateTimeout = setTimeout(() => {
            this.element.remove();
        }, 250);
    }
}