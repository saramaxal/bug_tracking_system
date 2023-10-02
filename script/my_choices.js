
const choices = document.querySelectorAll("select");

// console.log(choices)

choices.forEach(select => {
    new Choices(
        select,
        {
            shouldSort: false,
            position: "bottom",
            searchEnabled: false,
            itemSelectText: ""
        });
});

// const choicesUrgency = new Choices(
//     document.querySelector(".create-error__wrap-field .wrap-field__select"),
//     {
//         shouldSort: false,
//         position: "bottom",
//         searchEnabled: false,
//         itemSelectText: ""
//     });

