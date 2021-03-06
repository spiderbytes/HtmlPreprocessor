# HtmlPreprocessor

## About

With the HtmlProcessor you are able to manipulate the HTML file generated by SpiderBasic before displaying it in the browser.

After setting up the HtmlPreprocessor (see Installation below), it will pay attention to the following block in your code in the future:

```
;!  <HtmlPreprocessor>
;!    [
;!      {
;!        "search": [TermToSearchFor],
;!        "replace": [TermToReplaceWith]
;!      }
;!    ]
;!  </HtmlPreprocessor>
```
## Example:

```
;!  <HtmlPreprocessor>
;!    [
;!      {
;!        "search": "</title>",
;!        "replace": "</title>\n\n<script src='https://cdn.jsdelivr.net/npm/apexcharts'></script>"
;!      }
;!    ]
;!  </HtmlPreprocessor>

! $("body").append($("<div id='chart' style='width:500px;height:300px;background-color:#FFFFFF' />"));

! var options = {
!    chart:    { type: 'line' },
!    series: [ { name: 'sales', data: [30,40,35,50,49,60,70,91,125] } ],
!    xaxis:    { categories: [1991,1992,1993,1994,1995,1996,1997,1998,1999] }
! }

! var chart = new ApexCharts(document.querySelector("#chart"), options);
! chart.render();
```

## Notes:

* The Block between ```<HtmlPreprocessor>``` and ```</HtmlPreprocessor>``` follows the JSON-Syntax. This means that certain characters such as double quotes or line breaks must be escaped.
* Not all JavaScript libraries can be placed anywhere. Sometimes you have to experiment a little bit.
* JavaScript libraries that have their own ```require``` cause a conflict with SpiderBasic - ```require``` in most cases.

## Installation

The Html preprocessor must be set up as a tool in SpiderBasic:

![](https://i.imgur.com/k0a2FGX.png)

To generate WebApps, the HtmlPreprocessor must be set up as a separate tool with the "After Create Executable" trigger.

![](https://i.imgur.com/EMoaBeC.png)

## Questions? Suggestions? Bug-Reports?

[SpiderBasic-Forum (englisch)](http://forums.spiderbasic.com/index.php)

[SpiderBasic-Forum (german)](http://www.purebasic.fr/german/viewforum.php?f=33)

## License

[MIT](https://github.com/spiderbytes/HtmlPreprocessor/blob/master/LICENSE)


