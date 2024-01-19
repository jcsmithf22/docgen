import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        this.setActiveLink();
    }

    setActiveLink() {
        const currentPath = window.location.pathname;
        this.element.querySelectorAll("a").forEach((link) => {
            if (link.getAttribute("href") === currentPath) {
                link.classList.remove("default-sidebar-link");
                link.classList.add("active-sidebar-link");
            } else {
                link.classList.remove("active-sidebar-link");
                link.classList.add("default-sidebar-link");
            }
        });
    }
}