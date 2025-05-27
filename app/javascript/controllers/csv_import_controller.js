import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["file", "password", "form"];

  submit(event) {
    if (this.fileTarget.files.length === 0) {
      event.preventDefault();
      alert("Please choose a file before importing.");
      return;
    }

    if (this.passwordTarget.value.trim() === "") {
      event.preventDefault();
      alert("Please confirm your password.");
      return;
    }
  }
}
