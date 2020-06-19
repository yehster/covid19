import request from "request";
import * as dd from "../dataDescriptor";
import fs from "fs";


const url_deaths_us="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv";
const url_confirmed_us="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv";

function get_file(url : string ,destination :string ,type : string)
{
	request(url,(err,req,data)=>
	{
		fs.writeFileSync(destination,data);
	})
}

get_file(url_deaths_us,dd.us_deathsCSV,"d");
get_file(url_confirmed_us,dd.us_confirmedCSV,"c");