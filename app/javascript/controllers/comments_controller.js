import { Controller } from "@hotwired/stimulus"

export default class extends Controller { 
  static targets = [ 'comment', 'showLink', 'hideLink' ]
  static classes = [ 'hidden' ]

  connect() {
    this.addtlComments = this.commentTargets.slice(3);
    console.log(this.addtlComments);
    this.addtlComments.forEach((comment) => {
      comment.classList.add(this.hiddenClass);
    });

    if(this.addtlComments.length == 0) {
      this.showLinkTarget.classList.add(this.hiddenClass);
    }
  }

  show() {
    this.addtlComments.forEach((comment) => {
      comment.classList.remove(this.hiddenClass);
    });

    this.showLinkTarget.classList.add(this.hiddenClass);
    this.hideLinkTarget.classList.remove(this.hiddenClass);
  }

  hide() {
  this.addtlComments.forEach((comment) => {
    comment.classList.add(this.hiddenClass);

    this.showLinkTarget.classList.remove(this.hiddenClass);
    this.hideLinkTarget.classList.add(this.hiddenClass);
    });
  }
}