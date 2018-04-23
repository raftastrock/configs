'use strict'
window.urlObj = {}

document.querySelectorAll('.LessonList .lesson').forEach((node, i) => {
	setTimeout(() => {
		const title = node.querySelector('.title').innerText
		const url = document.querySelector('video').src
		window.urlObj[title] = url

		console.log(title, url)
		node.click()
	}, 3000 * i)
})
