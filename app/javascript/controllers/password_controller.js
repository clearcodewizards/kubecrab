import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="password"
//
// Allows toggling the visibility of a password field via inset button
//
// Assumes the button includes both a visible and hidden SVG icon that both get
// visibility toggled on click.
export default class extends Controller {
  static targets = ['password', 'toggle']

  toggleTargetConnected () {
    // Progressive enhancement
    this.toggleTarget.classList.remove('hidden')
  }

  toggle (event) {
    if (this.passwordTarget.type === 'password') {
      this.passwordTarget.type = 'text'
    } else {
      this.passwordTarget.type = 'password'
    }

    this.toggleTarget.querySelectorAll('svg').forEach((icon) => {
      icon.classList.toggle('hidden')
    })

    event.preventDefault()
  }
}
