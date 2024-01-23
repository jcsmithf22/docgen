import {Controller} from "@hotwired/stimulus";

export default class extends Controller {

    static targets = ["container", "checkbox"];

    connect() {
        this.toggle();
    }

    toggle() {
        console.log("checked");
        if (this.checkboxTarget.checked) {
            this.containerTarget.classList.remove("hidden");
        } else {
            this.containerTarget.classList.add("hidden");
        }

    }
}
