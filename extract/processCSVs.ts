import  fs from "fs";
import csv from "csv-parser";
import * as covidDB from "../covidDB";
import * as dd from "../dataDescriptor";

function load_us_deaths()
{
	return new Promise((resolve,reject)=>
	{
		var deaths:Array<object>=[];
		fs.createReadStream(dd.us_deathsCSV)
		.pipe(csv())
		.on('data', (data) => {deaths.push(data); console.log(typeof data);})
		.on('end', () => {
			covidDB.processTimeSeries(deaths,"d").then(resolve);
		});  
	});
}

function load_us_confirmed()
{
	return new Promise((resolve,reject)=>
	{
		var confirmed:Array<object>=[];
			fs.createReadStream(dd.us_confirmedCSV)
				.pipe(csv())
				.on('data', (data) => {confirmed.push(data);})
				.on('end', () => {
					covidDB.processTimeSeries(confirmed,"c").then(resolve);
		});  
	});
};

async function refreshData()
{
	await covidDB.resetData();
	await load_us_deaths();
	await load_us_confirmed();
	covidDB.end();
}

refreshData();