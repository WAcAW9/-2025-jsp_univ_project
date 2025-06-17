function openPointModal(productCode) {
	const modal = document.getElementById("PointModal");
	const modalContent = document.getElementById("PointmodalContent");

	// 비동기 처리 
	fetch("pointDetail.jsp?ProductCode=" + productCode)
		// 응답 텍스트로 변환하여 처리
		.then(response => response.text())
		.then(html => {
			modalContent.innerHTML = html;
			modal.style.display = "block"; // 모달창 열기 
		});
}

function closePointModal() {
	document.getElementById("PointModal").style.display = "none";
}