import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'menu' ]
  static classes = [ 'active' ]
  
  show() {
    this.menuTarget.classList.toggle(this.activeClass)
  }
}
