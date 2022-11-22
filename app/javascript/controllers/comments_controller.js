import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["comment", "showLink", "hideLink"];
  static classes = ["hidden"];

  connect() {
    // Upon loading page, show only first three comments (keep the rest hidden)
    this.firstComments = this.commentTargets.slice(0, 3);
    this.firstComments.forEach((comment) => {
      comment.classList.remove(this.hiddenClass);
    });

    // Upon loading page, if there more than three comments, show the link to
    // reveal more comments
    if (this.commentTargets.length <= 3) {
      this.showLinkTarget.classList.add(this.hiddenClass);
    }

    // Toggle status to change behavior of broadcasted comments
    this.status = "hidden";
  }

  show() {
    // Show all comments
    this.commentTargets.forEach((comment) => {
      comment.classList.remove(this.hiddenClass);
    });

    // Switch show link with hide link
    this.showLinkTarget.classList.add(this.hiddenClass);
    this.hideLinkTarget.classList.remove(this.hiddenClass);

    // Toggle status to change behavior of broadcasted comments
    this.status = "shown";
  }

  hide() {
    // Determine additional comments (which will be outdated if new comments
    // have been broadcasted in)
    this.addtlComments = this.commentTargets.slice(3);

    // Hide only additional comments (besides first three)
    this.addtlComments.forEach((comment) => {
      comment.classList.add(this.hiddenClass);
    });

    // Switch hide link with show link
    this.showLinkTarget.classList.remove(this.hiddenClass);
    this.hideLinkTarget.classList.add(this.hiddenClass);

    // Toggle status to change behavior of broadcasted comments
    this.status = "hidden";
  }

  // Triggered when new comments are broadcasted in
  commentTargetConnected() {
    // If all comments are showing, show this one as well
    if (this.status == "shown" || this.commentTargets.length <= 3) {
      this.element.querySelector(".hidden").classList.remove(this.hiddenClass);

      // If additional comments are hidden but there are more than three total,
      // reveal show link
    } else if (this.commentTargets.length > 3) {
      this.showLinkTarget.classList.remove(this.hiddenClass);
    }
  }

  // Triggered when a comment is deleted
  commentTargetDisconnected() {
    if (this.commentTargets.length <= 3) {
      // Hide any links to show/hide comments
      this.showLinkTarget.classList.add(this.hiddenClass);
      this.hideLinkTarget.classList.add(this.hiddenClass);

      // Toggle status to hidden, so links are added properly after 3 or more
      // comments are present
      this.status = "hidden";
    }
  }
}
