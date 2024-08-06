import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["spinner"]

  connect() {
    // console.log("SpinnerController connected")
    if (this.hasSpinnerTarget) {
      console.log("Spinner target found")
      this.showSpinner()
    } else {
      console.error("Missing spinner target")
    }
  }

  showSpinner() {
    // console.log("Show spinner")
    this.spinnerTarget.style.display = "block"
    setTimeout(() => {
      this.hideSpinner()
    }, 5136) // 5 milliseconds delay
  }

  hideSpinner() {
    // console.log("Hide spinner")
    this.spinnerTarget.style.display = "none"
  }
}
