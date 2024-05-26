import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["spinner"]

  connect() {
    this.spinnerTarget.style.display = 'none'; // Ensure spinner is hidden on load
  }

  download() {
    this.spinnerTarget.style.display = 'block';
    this.element.disabled = true;

    // Assuming the download shouldn't take more than a few seconds
    setTimeout(() => {
      this.spinnerTarget.style.display = 'none';
      this.element.disabled = false;
    }, 10000); // adjust time as needed
  }
}
