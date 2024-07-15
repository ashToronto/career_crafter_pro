import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button" ]

  createCheckoutSession(event) {
    event.preventDefault()

    const url = event.target.closest('form').action
    const planId = event.target.dataset.planId

    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ plan_id: planId })
    })
    .then(response => response.json())
    .then(data => {
      window.location.href = data.checkout_url
    })
    .catch(error => {
      console.error('Error:', error)
    })
  }
}
