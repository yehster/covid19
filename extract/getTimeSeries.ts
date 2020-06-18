const request=require("request");
const dataDescriptors=require("../dataDescriptors.js");
const fs=require("fs");


const url_deaths_us="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv";
const url_confirmed_us="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv";

function get_file(url,destination,type)
{
    request(url,(err,req,data)=>
    {
        fs.writeFileSync(destination,data);
    })
}

get_file(url_deaths_us,dataDescriptors.us_deathsCSV,"d");
get_file(url_confirmed_us,dataDescriptors.us_confirmedCSV,"c");