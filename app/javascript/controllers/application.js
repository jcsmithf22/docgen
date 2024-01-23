import {Application} from "@hotwired/stimulus";
import Dropdown from "stimulus-dropdown";
import NestedForm from "stimulus-rails-nested-form";
import {Datepicker} from "stimulus-datepicker";

const application = Application.start();
application.register("dropdown", Dropdown);
application.register("datepicker", Datepicker);
application.register("nested-form", NestedForm);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export {application};
