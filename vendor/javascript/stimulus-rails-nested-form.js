import {Controller as e} from "@hotwired/stimulus";

class r extends e {
    add(e) {
        e.preventDefault();
        const t = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, (new Date).getTime().toString());
        this.targetTarget.insertAdjacentHTML("beforebegin", t);
    }

    remove(e) {
        e.preventDefault();
        const t = e.target.closest(this.wrapperSelectorValue);
        console.log(t);
        if ("true" === t.dataset.newRecord) t.remove(); else {
            t.style.display = "none";
            const e = t.querySelector("input[name*='_destroy']");
            e.value = "1";
            console.log(e);
            // t.querySelectorAll("input[name*='_destroy']").forEach(e => {
            //     e.value = "1";
            // });
        }
    }
}

r.targets = ["target", "template", "delete"];
r.values = {wrapperSelector: {type: String, default: ".nested-form-wrapper"}};
export {r as default};

