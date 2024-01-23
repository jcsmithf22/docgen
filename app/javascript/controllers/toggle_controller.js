import {Controller} from "@hotwired/stimulus";

export default class extends Controller {

    static targets = ["change", "clear", "button"];

    toggle() {
        this.changeTargets.forEach((target) => {
            target.classList.toggle("hidden");
        });
        // this.clearTargets.forEach((input) => input.value = "");
        this.buttonTarget.classList.toggle("md:row-start-3");
    }
}
