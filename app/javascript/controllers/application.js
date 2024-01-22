import {Application} from "@hotwired/stimulus";
import Dropdown from "stimulus-dropdown";
import {Datepicker} from "stimulus-datepicker";

const application = Application.start();
application.register("dropdown", Dropdown);
application.register("datepicker", Datepicker);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export {application};
