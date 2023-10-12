//<!-------------------------------------------
//---              COMMENTS                 ---
//--------------------------------------------->

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

//<!-------------------------------------------
//---              EDIT ERROR               ---
//--------------------------------------------->
const buttonEdit = document.querySelector("div.button_edit");
const errorElementsShow = document.querySelectorAll(".error-flag_show");

const buttonCancel = document.querySelector("div.button_cancel");
const errorElementsHidden = document.querySelectorAll(".error-flag_hidden");

const newStatusElement = document.querySelector("select[name=new_status]");
const oldStatusElement = document.querySelector("input[name=old_status]");
const fieldsetNewComment = document.querySelector(".fieldset__new-comment");

buttonEdit.addEventListener("click", () => {
    if (!errorElementsShow[0].classList.contains("visually-hidden")) {
        errorElementsShow.forEach(element => {
            element.classList.add("visually-hidden");
        });

        errorElementsHidden.forEach(element => {
            element.classList.remove("visually-hidden");
        })
    }
})

buttonCancel.addEventListener("click", () => {
    if (errorElementsShow[0].classList.contains("visually-hidden")) {
        errorElementsShow.forEach(element => {
            element.classList.remove("visually-hidden");
        });

        errorElementsHidden.forEach(element => {
            element.classList.add("visually-hidden");
        })
    }
})

newStatusElement.addEventListener("change", () => {

    if (newStatusElement.value == oldStatusElement.value) {
        fieldsetNewComment.disabled = 1;
    }
    else {
        fieldsetNewComment.disabled = 0;
    }
})
//<!-------------------------------------------
//---              OTHER                    ---
//--------------------------------------------->

const buttonExit = document.querySelector(".button_exit");
buttonExit.addEventListener("click", () => {
    window.location.href = "./list_errors.cfm";
})