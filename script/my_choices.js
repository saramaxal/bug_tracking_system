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
            value: '����� ������',
            label: '����� ������',
        },
        {
            value: '������',
            label: '������',
        },
        {
            value: '��������',
            label: '��������',
        },
        {
            value: '������ ��������',
            label: '������ ��������',
        }
    ],
    'value',
    'label',
    true
)