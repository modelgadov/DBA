DECLARE @tableHTML  NVARCHAR(MAX) ;  
  
SET @tableHTML =  
N'<style type="text/css">
#box-table
{
font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
font-size: 12px;
text-align: center;
border-collapse: collapse;
border-top: 7px solid #9baff1;
border-bottom: 7px solid #9baff1;
}
#box-table th
{
font-size: 13px;
font-weight: normal;
background: #b9c9fe;
border-right: 2px solid #9baff1;
border-left: 2px solid #9baff1;
border-bottom: 2px solid #9baff1;
color: #039;
}
#box-table td
{
border-right: 1px solid #aabcfe;
border-left: 1px solid #aabcfe;
border-bottom: 1px solid #aabcfe;
color: #669;
}
tr:nth-child(odd)	{ background-color:#eee; }
tr:nth-child(even)	{ background-color:#fff; }	
</style>'+	
N'<H3><font color="Red">All Rows From [AdventureWorks].[Sales].[SpecialOffer]</H3>' +
N'<table id="box-table" >' +
N'<tr><font color="Green"><th>SpecialOfferID</th>
<th>Description</th>
<th>Type</th>
<th>Category</th>
<th>StartDate</th>
<th>EndDate</th>
</tr>' +
CAST ( ( 
SELECT td = CAST([SpecialOfferID] AS VARCHAR(100)),'',
td = [Description],'',
td = [Type],'',
td = [Category] ,'',
td = CONVERT(VARCHAR(30),[StartDate],120) ,'',
td = CONVERT(VARCHAR(30),[EndDate],120) 
FROM [AdventureWorks2012].[Sales].[SpecialOffer]	
ORDER BY [SpecialOfferID]
FOR XML PATH('tr'), TYPE 
) AS NVARCHAR(MAX) ) +
N'</table>';

EXEC msdb.dbo.sp_send_dbmail @recipients='danw@Adventure-Works.com',  
    @subject = 'Work Order List',  
    @body = @tableHTML,  
    @body_format = 'HTML' ; 
