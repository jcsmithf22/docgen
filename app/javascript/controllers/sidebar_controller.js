import {Controller} from "@hotwired/stimulus";

export default class extends Controller {

    static targets = ["sidebar", "backdrop"];


    open() {
        this.backdropTarget.classList.remove("hidden");
        setTimeout(() => this.backdropTarget.classList.remove("opacity-0"), 0);
        this.sidebarTarget.classList.remove("-translate-x-full");
    }

    disconnect() {
        if (this.exitTimeout) {
            clearTimeout(this.exitTimeout);
        }
    }

    close() {
        this.backdropTarget.classList.add("opacity-0");
        this.sidebarTarget.classList.add("-translate-x-full");
        this.exitTimeout = setTimeout(() => {
            this.backdropTarget.classList.add("hidden");
        }, 310);
    }
}
