import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-create-spa-form"
export default class extends Controller {
  static targets = [ "spa_form" ]

  connect() {
    console.log("SEIJI");
  }

  fire() {
    this.spa_formTarget.classList.toggle("d-none");
  }
}
