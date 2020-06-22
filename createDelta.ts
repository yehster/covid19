import * as covidDB from "./covidDB";




async function main()
{
	await covidDB.table_delta("confirmed");
	await covidDB.table_delta("deaths");
	await covidDB.table_delta("confirmed_delta");
	await covidDB.table_delta("deaths_delta");
	covidDB.end();
}

main();