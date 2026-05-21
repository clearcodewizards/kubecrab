import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["div"]
  connect() {
    setTimeout(() => {
      this.divTarget.classList.add("hidden");
    }, 4000);
  }
}
