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
		.on('data', (data) => {deaths.push(data)})
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
			.on('data', (data) => {confirmed.push(data)})
			.on('end', () => {
				covidDB.processTimeSeries(confirmed,"c").then(resolve);
	});  
});

async function refreshData()
{
	
}
covidDB.resetData().then(()=>{load_us_deaths().then(()=>{load_us_confirmed().then(()=>{covidDB.updateDeltas().then(covidDB.end);})})});
//load_us_deaths();