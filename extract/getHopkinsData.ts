const request=require("request");
const cheerio=require("cheerio");
const dataPath=require("../dataDescriptors.js").dataPath;
const fs=require("fs");

const sourceURL="https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports";
const rawURL="https://raw.githubusercontent.com";
function saveDataFile(url,title)
{
    request(url,(err,req,data)=>
    {
        console.log(url);
        var filename=dataPath+title;
        
        fs.writeFileSync(filename,data);
    });
    
}
function getDataFiles()
{
    return new Promise((resolve,reject)=>
    {
        request(sourceURL,function(err,req,data)
        {
            if(err)
            {
                reject(err);
                return;
            }
            var $=cheerio(data);

            var files = $.find("a.js-navigation-open[title$='.csv']");
            files.each((idx,elem)=>{
                var curFile=files.eq(idx);
                var fileURL=rawURL+curFile.attr("href");
                fileURL=fileURL.replace("/blob","")
                saveDataFile(fileURL,curFile.attr("title"));
            });
            
            
            
        });
    });
}
// Retrieve data files


function main()
{
    getDataFiles().then()
};

main();