let errorRecord = document.querySelectorAll(".error_list");

for (let record = 0; record < errorRecord.length; record++) {
    
    errorRecord[record].addEventListener("click", function () {
        
        let solu = document.querySelector(".solu");
        solu.style.display = "none";

        showRecordDetail(errorRecord[record]);
        goBackList();
    })
}

function showRecordDetail(recordData) {
    
    const detailResult = document.createElement("div");
    detailResult.classList.add("detail_result");

    const createBtn = document.createElement("button");
    createBtn.classList.add("go_back_btn");
    createBtn.innerText = "Go Back"

    for (let data = 0; data < recordData.children.length; data++) {

        let showResult = recordData.children[data]

        detailResult.innerHTML = detailResult.innerHTML + `<` + showResult.tagName + `>` + showResult.textContent + `</` + showResult.tagName + `>`;

    }

    document.querySelector(".main").appendChild(detailResult);
    document.querySelector(".main").appendChild(createBtn);
}

function goBackList() {

    const goBackBtn = document.querySelector(".go_back_btn");
    const detailResultOff = document.querySelector(".detail_result")
    const goBackBtnOff = document.querySelector(".go_back_btn")

    goBackBtn.addEventListener('click', function() {
        
        let solu = document.querySelector(".solu");
        solu.style.display = "block";

        detailResultOff.remove();
        goBackBtnOff.remove();
    })
}