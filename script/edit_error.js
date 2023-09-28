const buttonAddComments = document.querySelector(".button_add-comments");
const CommentsForm = document.querySelector(".edit-error__comments-form");
const buttonClose = document.querySelector(".button_close");
const LinkLastComment = document.querySelector(".edit-error__link-last__comment");

buttonAddComments.addEventListener("click", () => {
    if (CommentsForm.classList.contains("visually-hidden")) {
        CommentsForm.classList.remove("visually-hidden");
        buttonAddComments.classList.add("off");

        CommentsForm.scrollIntoView({
            behavior: "smooth",
            block: "start"
        })
    }
})
buttonClose.addEventListener("click", () => {
    CommentsForm.classList.add("visually-hidden");
    buttonAddComments.classList.remove("off");
})

LinkLastComment.addEventListener("click", () => {
    const lastComment = document.querySelector(".edit-error__wrap-comment:last-child");
    lastComment.scrollIntoView({
        behavior: "smooth",
        block: "start"
    })
})

