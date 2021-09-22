const puppeteer = require('puppeteer');
const parse = require('node-html-parser').parse;
const fs = require('fs');

const UID = '';
const PASSWORD = '';

/**
 * GET MARKS OUT OF HTML FILE
 * @param {*} html Page as String
 * @returns JSO array of Data
 */
const getMarks = html => {
	const root = parse(html);

	const elements = root.querySelectorAll('.qis_records');
	const newArray = [];

	for (let index = 0; index < elements.length; index += 9) {
		//To filter out main subjects but not rly needed becuase other class selector
		const id = parseInt(elements[index + 0].text.replaceAll(/\s/g, ''), 10);
		if (id % 1000 == 0) continue;
		newArray.push({
			id: id,
			name: elements[index + 1].text.replaceAll(/\s/g, ''),
			type: elements[index + 2].text.replaceAll(/\s/g, ''),
			grade: parseFloat(elements[index + 3].text.replaceAll(/\s/g, '')),
			status: elements[index + 4].text.replaceAll(/\s/g, ''),
			credits: parseInt(elements[index + 5].text.replaceAll(/\s/g, ''), 10),
			note: elements[index + 6].text.replaceAll(/\s/g, ''),
			try: parseInt(elements[index + 7].text.replaceAll(/\s/g, ''), 10),
			date: elements[index + 8].text.replaceAll(/\s/g, ''),
		});
	}

	return newArray;
};

/**
 *
 * @param {*} resultsArray JSON ARRAY OF MARKS
 * @returns An Average of Data in an Object
 */
const getAverageObject = resultsArray => {
	let amountOfGrades = 0;
	let averageObject = {
		total: 0,
		done: 0,
		credits: 0,
		grade: 0,
		try: 0,
	};

	resultsArray.forEach(result => {
		averageObject.total++;
		if (result.status == 'BE') {
			averageObject.done++;
		}
		if (!isNaN(result.credits)) {
			averageObject.credits += result.credits;
		}
		if (!isNaN(result.grade) && result.grade != 0) {
			amountOfGrades++;
			averageObject.grade += result.grade;
		}
		if (!isNaN(result.try)) {
			averageObject.try += result.try;
		}
	});

	if (amountOfGrades > 0) {
		averageObject.grade = (averageObject.grade / amountOfGrades).toFixed(3);
	}
	return averageObject;
};

/**
 * PUPPETER FUNCTION TO DOWNLOAD LATEST MARK OVERVIEW
 * @returns html
 */
const getLatestPageFromWeb = async () => {
	const browser = await puppeteer.launch();
	const page = await browser.newPage();
	await page.goto('https://studienkonto.fh-erfurt.de/');

	await page.waitForXPath("//*[@id='asdf']");

	await page.screenshot({ path: 'example1.png' });

	await page.type('[name=asdf]', UID);
	await page.type('[name=fdsa]', PASSWORD);

	await page.click('[type=submit]');
	await page.waitForFunction(
		'document.querySelector(".divloginstatus").innerText.includes("' +
			UID +
			'")'
	);
	await page.screenshot({ path: 'example2.png' });

	//Click auf Prüfungsverwaltung
	const NavElements = await page.$x('//*[@id="makronavigation"]/ul/li[1]/a');
	await NavElements[0].click();
	await page.waitFor(2000);
	await page.screenshot({ path: 'example3.png' });

	//Click auf Notenspiegel
	const NotElements = await page.$x(
		'//*[@id="wrapper"]/div[6]/div[2]/div/form/div/ul/li[3]/a'
	);
	await NotElements[0].click();
	await page.waitFor(2000);
	await page.screenshot({ path: 'example4.png' });

	//Click auf Bachlor
	const BacElements = await page.$x(
		'//*[@id="wrapper"]/div[6]/div[2]/form/ul/li/a[1]'
	);
	await BacElements[0].click();
	await page.waitFor(2000);
	await page.screenshot({ path: 'example5.png' });

	//Click auf anzeigen
	const elements = await page.$x(
		'//*[@id="wrapper"]/div[6]/div[2]/form/ul/li/ul/li/a[1]'
	);
	await elements[0].click();
	await page.waitFor(2000);
	await page.screenshot({ path: 'example65.png' });

	const html = await page.content();

	await browser.close();

	fs.writeFileSync('./Page.html', html);
	return html;
};

/**
 * READ THE LATEST SAVED HTML PAGE AND RETURN IT AS STRING
 * @returns HTML TEXT
 */
const loadHtmlFromFile = () => {
	try {
		return fs.readFileSync('./Page.html', 'utf8');
	} catch (err) {
		return '';
	}
};

/**
 *
 * @param {*} averageObject
 */
const saveResultData = averageObject => {
	console.log('SAVING FILE');
	fs.writeFileSync('./LatestResult.json', JSON.stringify(averageObject));
};

const checkForChanges = averageObject => {
	fs.readFile('./LatestResult.json', (err, data) => {
		if (err == null) {
			const oldResults = JSON.parse(data);
			console.log(oldResults);
			console.log(averageObject);

			if (
				oldResults.total != averageObject.total ||
				oldResults.done != averageObject.done ||
				oldResults.credits != averageObject.credits ||
				oldResults.grade != averageObject.grade ||
				oldResults.try != averageObject.try
			) {
				console.log('THERE WAS AN UPDATE');
			}
		}
		//SAVE THE NEW DATA
		saveResultData(averageObject);
	});
};

const main = async () => {
	//const html = await getLatestPageFromWeb();
	const html = await loadHtmlFromFile();

	const results = getMarks(html);
	//console.log(results);
	const averageObject = getAverageObject(results);
	//console.log(averageObject);

	checkForChanges(averageObject);
};

main();
