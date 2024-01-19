import {Controller} from "@hotwired/stimulus";

export default class extends Controller {

    static targets = ["sidebar", "backdrop"];


    open() {
        this.backdropTarget.classList.remove("hidden");
        this.backdropTarget.classList.add("fadeIn");
        this.sidebarTarget.classList.remove("-translate-x-full");
    }

    disconnect() {
        if (this.exitTimeout) {
            clearTimeout(this.exitTimeout);
        }
    }

    close() {
        this.backdropTarget.classList.remove("fadeIn");
        this.backdropTarget.classList.add("fadeOut");
        this.sidebarTarget.classList.add("-translate-x-full");
        this.exitTimeout = setTimeout(() => {
            this.backdropTarget.classList.add("hidden");
            this.backdropTarget.classList.remove("fadeOut");
        }, 310);
    }
}
