'use strict'
window.urlObj = {}

const lessons = document.querySelectorAll('.LessonList .lesson')

for (let i = 0; i < lessons.length; i++) {
	setTimeout(() => {
		const title = lessons[i].querySelector('.title').innerText
		const url = document.querySelector('video').src
		console.log(i, url)
		window.urlObj[title] = url

		if (i < lessons.length - 1) {
			lessons[i + 1].click()
		}
	}, 3000 * i)
}
