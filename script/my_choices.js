const choicesUrgency = new Choices(
    document.querySelector(".create-error__wrap-field .wrap-field__select"),
    {
        shouldSort: false,
        position: "bottom",
        searchEnabled: false,
        itemSelectText: ""
    });

choicesUrgency.setChoices(
    [
        {
            value: 'очень срочно',
            label: 'очень срочно',
        },
        {
            value: 'срочно',
            label: 'срочно',
        },
        {
            value: 'несрочно',
            label: 'несрочно',
        },
        {
            value: 'совсем несрочно',
            label: 'совсем несрочно',
        }
    ],
    'value',
    'label',
    true
)