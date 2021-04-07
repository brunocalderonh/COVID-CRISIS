




**Proceed to create and set up the "quarterly data variable"*


generate date = tq(2007q4)+_n-1

format date %tq 


** Define the created variable as a time variable*


tsset date


*
*
** Transform relevant varialbes into logs: to stabilize variable variance & regression coefficients -*
** - are measured as partial elasticities*
*
*


** cunrate - cyclical unemployment rate = Unemployment Rate - Natural Short Term Unemploymenr Rate*

gen lcunrate = ln(cunrate)

** gcec1 - Real Government Consumption Expenditures and Gross Investment *

gen lgcec1 = ln(gcec1)

** gpdic1 - Real Gross Private Domestic Investmen*

gen lgpdic1 = ln(gpdic1)


** pcec96 - Real Personal Consumption Expenditures*

gen lpcec96 = ln(pcec96)

** tcu - Capacity Utilization: Total Index *

gen ltcu = ln(tcu)

**	isratio - Total Business: Inventories to Sales Ratio*

gen lisratio = ln(isratio)


*
*
** Transform relevant varialbes into first difference*
*
*

** cunrate - cyclical unemployment rate = Unemployment Rate - Natural Short Term Unemploymenr Rate*

gen dlcunrate = d.lcunrate

** gcec1 - Real Government Consumption Expenditures and Gross Investment *

gen dlgcec1 = d.lgcec1

** gpdic1 - Real Gross Private Domestic Investmen*

gen dlgpdic1 = d.lgpdic1

** netexc - Real Net Exports*

gen dnetexc = d.netexc

** pcec96 - Real Personal Consumption Expenditures*

gen dlpcec96 = d.lpcec96

** tcu - Capacity Utilization: Total Index *

gen dltcu = d.ltcu

**	isratio - Total Business: Inventories to Sales Ratio*

gen dlisratio = d.lisratio



*
*
** Univariate graphs of variables*
*
*

** cunrate - cyclical unemployment rate = Unemployment Rate - Natural Short Term Unemploymenr Rate*

line lcunrate date

** gcec1 - Real Government Consumption Expenditures and Gross Investment *

line lgcec1 date

** gpdic1 - Real Gross Private Domestic Investmen*

line lgpdic1 date

** netexc - Real Net Exports*

line netexc date

** pcec96 - Real Personal Consumption Expenditures*

line lpcec96 date

** tcu - Capacity Utilization: Total Index *

line ltcu date

**	isratio - Total Business: Inventories to Sales Ratio*

line lisratio date


*
*
** Bi-variate graphs of independent variables vs depdendent variable (cunrate)
*
*




** gcec1 - Real Government Consumption Expenditures and Gross Investment *

twoway (lfit lcunrate lgcec1 )(scatter lcunrate lgcec1 )

** gpdic1 - Real Gross Private Domestic Investmen*

twoway (lfit lcunrate lgpdic1 )(scatter lcunrate lgpdic1 )

** netexc - Real Net Exports*

twoway (lfit lcunrate netexc )(scatter lcunrate netexc )

** pcec96 - Real Personal Consumption Expenditures*

twoway (lfit lcunrate lpcec96 )(scatter lcunrate lpcec96 )

** tcu - Capacity Utilization: Total Index *

twoway (lfit lcunrate ltcu )(scatter lcunrate ltcu )

**	isratio - Total Business: Inventories to Sales Ratio*

twoway (lfit lcunrate lisratio )(scatter lcunrate lisratio )


*
*
** Histogram
*
*

** cunrate - cyclical unemployment rate = Unemployment Rate - Natural Short Term Unemploymenr Rate*

histogram lcunrate 

** gcec1 - Real Government Consumption Expenditures and Gross Investment *

histogram lgcec1

** gpdic1 - Real Gross Private Domestic Investmen*

histogram lgpdic1

** netexc - Real Net Exports*

histogram netexc

** pcec96 - Real Personal Consumption Expenditures*

histogram lpcec96

** tcu - Capacity Utilization: Total Index *

histogram ltcu

**	isratio - Total Business: Inventories to Sales Ratio*

histogram lisratio


*
*
*Skewness Test
*
*


sktest lcunrate lgcec1 lgpdic1 netexc lpcec96 ltcu lisratio



*
*
*Summary Data
*
*

sum lcunrate lgcec1 lgpdic1 netexc lpcec96 ltcu lisratio


*
*
*Covariance, Correlation
*
*

** gcec1 - Real Government Consumption Expenditures and Gross Investment *

correlate lcunrate lgcec1, covariance

** gpdic1 - Real Gross Private Domestic Investmen*

correlate lcunrate lgpdic1, covariance

** netexc - Real Net Exports*

correlate lcunrate netexc, covariance

** pcec96 - Real Personal Consumption Expenditures*

correlate lcunrate lpcec96, covariance

** tcu - Capacity Utilization: Total Index *

correlate lcunrate ltcu, covariance

**	isratio - Total Business: Inventories to Sales Ratio*

correlate lcunrate lisratio, covariance

*
* 
* Regression
*
*


regress lcunrate lgcec1 lgpdic1 netexc lpcec96 ltcu lisratio dummy_covid_lethality greatrecession


*
*
** Residuals
*
*

predict resid, resid

line resid date

predict fittedcunrate, xb

twoway(tsrline lcunrate fittedcunrate)


*
*
** Diagnostic Tests:  Normality, Homoscedasticity, autocorrelation
*
*

** Normality test

sktest resid

** Homoscedasticity

*Non-dynamic homoscedasticity

estat hettest

*Dynamic homoscedasticity

estat archlm, lags(1 2 3)

** Autocorrelation 

*- B.Godfrey 

estat bgodfrey

*- Durbin-Watson

estat dwatson

