import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition";

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets = ['modal', 'panel']
  connect() {
    enter(this.modalTarget);
    enter(this.panelTarget);
    document.body.classList.add("overflow-hidden")
  }
  hideModal() {
    leave(this.modalTarget);
    leave(this.panelTarget);
    this.element.parentElement.removeAttribute("src")
    this.element.remove()
    document.body.classList.remove("overflow-hidden")
  }
  submitEnd(e) {    
    if (e.detail.success) {
      this.hideModal()
    }
  }
}
