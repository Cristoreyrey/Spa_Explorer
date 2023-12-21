import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-display-map"
export default class extends Controller {
  static targets = [ "map_display" ]

  connect() {
    console.log("SEIJI 2");
  }

  fire() {
    console.log("SEIJI 3");
    this.map_displayTarget.classList.toggle("d-none");
  }
}
